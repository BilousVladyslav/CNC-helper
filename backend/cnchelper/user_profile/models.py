from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin


class UserManager(BaseUserManager):

    def create_user(self, username, email, first_name, last_name, password, birth_date=None):
        if not username:
            raise ValueError("User must have username.")
        if not email:
            raise ValueError("User must have e-mail address.")
        if not first_name:
            raise ValueError("User must have first name.")
        if not last_name:
            raise ValueError("User must have last name.")
        if not password:
            raise ValueError("User must have password.")

        user = self.model(username=username,
                          email=self.normalize_email(email),
                          first_name=first_name,
                          last_name=last_name,
                          birth_date=birth_date)
        user.set_password(password)
        user.save()
        return user

    def create_superuser(self, username, email, first_name, last_name, password, birth_date=None):
        superuser = self.create_user(username, email, first_name, last_name, password, birth_date)
        superuser.is_staff = True
        superuser.is_superuser = True
        superuser.save()
        return superuser
    pass


class User(AbstractBaseUser, PermissionsMixin):
    username = models.CharField(unique=True, blank=False, primary_key=True, max_length=30)
    email = models.EmailField(unique=True, blank=False)
    first_name = models.CharField(blank=False, max_length=30)
    last_name = models.CharField(blank=False, max_length=30)
    birth_date = models.DateField(null=True)

    date_joined = models.DateTimeField(auto_now=True)
    is_supervisor = models.BooleanField(default=False)
    # avatar = models.ImageField()

    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)

    objects = UserManager()

    USERNAME_FIELD = 'username'
    EMAIL_FIELD = 'email'
    REQUIRED_FIELDS = ['email', 'first_name', 'last_name']

    def get_short_name(self):
        return self.first_name

    def get_full_name(self):
        return f'{self.last_name} {self.first_name}'

    def __str__(self):
        return self.username

    pass
