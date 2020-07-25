from rest_framework import serializers
from django.contrib.auth import get_user_model
from rest_framework.validators import UniqueValidator


class UserProfileSerializer(serializers.ModelSerializer):

    class Meta:
        model = get_user_model()
        fields = ['email', 'username', 'is_supervisor', 'first_name', 'last_name', 'birth_date', 'is_verified']
        read_only_fields = ['username', 'is_supervisor', 'email', 'is_verified']


class RegisterUserSerializer(serializers.ModelSerializer):

    class Meta:
        model = get_user_model()
        fields = ['email', 'username', 'first_name', 'last_name', 'password', 'birth_date']
        extra_kwargs = {'password': {'write_only': True,
                                     'min_length': 8,
                                     'required': True},
                        'email': {'required': True},
                        'last_name': {'required': True},
                        'first_name': {'required': True}}

    def create(self, validated_data):
        password = validated_data.pop('password')
        model = get_user_model()
        user = model(**validated_data)
        user.set_password(password)
        user.save()
        return user
