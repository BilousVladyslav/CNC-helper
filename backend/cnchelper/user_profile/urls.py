from django.conf.urls import url
from .views import ObtainTokenWithStatus, UserRegistration, PasswordUpdating, EmailConfirming, EmailConfirmationCreating


profile_urlpatterns = [
    # url(r'^api/profile/$', UserProfile.as_view()),
    url(r'^api/auth/', ObtainTokenWithStatus.as_view()),
    url(r'^api/register/', UserRegistration.as_view()),
    url(r'^api/password/', PasswordUpdating.as_view()),
    url(r'^api/verify/', EmailConfirming.as_view()),
    url(r'^api/email/', EmailConfirmationCreating.as_view()),
]