from django.contrib import admin
from .models import User, EmailConfirmation

admin.site.register(User)
admin.site.register(EmailConfirmation)
