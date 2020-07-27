from django.conf.urls import url
from .views import ObtainTokenWithStatus, UserRegistration, PasswordUpdating


profile_urlpatterns = [
    # url(r'^api/profile/$', UserProfile.as_view()),
    url(r'^api/auth/', ObtainTokenWithStatus.as_view()),
    url(r'^api/register/', UserRegistration.as_view()),
    url(r'^api/password/', PasswordUpdating.as_view()),
]