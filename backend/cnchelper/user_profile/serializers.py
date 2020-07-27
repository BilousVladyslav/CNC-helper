from rest_framework import serializers
from django.contrib.auth import get_user_model
from django.contrib.auth.hashers import check_password
from rest_framework.validators import UniqueValidator


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
                        'first_name': {'required': True}}

    def validate(self, attrs):
        if attrs['password'] != attrs['confirm_password']:
            raise serializers.ValidationError('Passwords must match.')
        attrs.pop('confirm_password')
        return attrs

    def create(self, validated_data):
        password = validated_data.pop('password')
        model = get_user_model()
        user = model(**validated_data)
        user.set_password(password)
        user.save()
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
