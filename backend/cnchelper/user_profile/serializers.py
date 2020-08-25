from django.contrib.auth import get_user_model
from django.contrib.auth.hashers import check_password
from django.utils import timezone

from rest_framework import serializers
from rest_framework.validators import UniqueValidator
from rest_framework.generics import get_object_or_404
from rest_framework.authtoken.models import Token

from .models import EmailConfirmation


class UserProfileSerializer(serializers.ModelSerializer):

    class Meta:
        model = get_user_model()
        fields = ['email', 'username', 'is_supervisor', 'first_name', 'last_name', 'birth_date', 'is_verified']
        read_only_fields = ['username', 'is_supervisor', 'email', 'is_verified']


class RegisterUserSerializer(serializers.ModelSerializer):
    confirm_password = serializers.CharField(required=True, write_only=True, min_length=8)

    class Meta:
        model = get_user_model()
        fields = ['email', 'username', 'first_name', 'last_name', 'password', 'confirm_password', 'birth_date']
        extra_kwargs = {'password': {'write_only': True,
                                     'min_length': 8,
                                     'required': True,
                                     'max_length': 40},
                        'email': {'required': True},
                        'last_name': {'required': True},
                        'first_name': {'required': True},
                        'username': {'min_length': 5}}

    def validate(self, attrs):
        if attrs['password'] != attrs['confirm_password']:
            raise serializers.ValidationError('Passwords must match.')
        attrs.pop('confirm_password')
        return attrs

    def create(self, validated_data):
        model = get_user_model()
        user = model.objects.create_user(**validated_data)
        return user


class PasswordChangeSerializer(serializers.Serializer):
    old_password = serializers.CharField(required=True)
    new_password = serializers.CharField(required=True, min_length=8, max_length=40)
    confirm_password = serializers.CharField(required=True, min_length=8, max_length=40)

    def validate(self, attrs):
        user = self.context['user']
        if not check_password(attrs['old_password'], user.password):
            raise serializers.ValidationError('Wrong password.')
        if attrs['new_password'] != attrs['confirm_password']:
            raise serializers.ValidationError('New passwords must match.')
        return attrs

    def save(self, **kwargs):
        user = self.context['user']
        user.set_password(self.validated_data['new_password'])
        user.save()
        Token.objects.get(user=user).delete()
        Token.objects.create(user=user)


class EmailConfirmationSerializer(serializers.Serializer):
    email = serializers.EmailField(required=True,
                                   validators=[UniqueValidator(queryset=get_user_model().objects.all(),
                                                               message='Email already exist.')])

    def validate(self, attrs):
        now = timezone.now()
        date_created = now.replace(day=int(now.day - 1))
        confirmations = EmailConfirmation.objects.filter(created__gte=date_created,
                                                         user=self.context['user'],
                                                         new_mail=attrs['email'],
                                                         is_confirmed=False)
        if len(confirmations) != 0:
            raise serializers.ValidationError("Confirmation for this email already sent, you must confirm it.")

        return attrs

    def save(self, **kwargs):
        user = self.context['user']
        if user.is_verified:
            confirmation = EmailConfirmation.objects.create(user=user,
                                                            send_to=user.email,
                                                            new_mail=self.validated_data['email'])
        else:
            confirmation = EmailConfirmation.objects.create(user=user,
                                                            send_to=self.validated_data['email'],
                                                            new_mail=self.validated_data['email'])
            user.email = self.validated_data['email']
            user.save()
        return confirmation


class UsersSerializer(serializers.ModelSerializer):
    full_name = serializers.SerializerMethodField()

    class Meta:
        model = get_user_model()
        fields = ['username', 'full_name']

    def get_full_name(self, obj):
        return obj.get_full_name()
