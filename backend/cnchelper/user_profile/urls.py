from django.conf.urls import url
from rest_framework.routers import DefaultRouter
from .views import ObtainTokenWithStatus, UserRegistration, PasswordUpdating, \
    EmailConfirming, EmailConfirmationCreating, UserProfile

profile_urlpatterns = [
    url(r'^api/auth/', ObtainTokenWithStatus.as_view()),
    url(r'^api/register/', UserRegistration.as_view()),
    url(r'^api/password/', PasswordUpdating.as_view()),
    url(r'^api/profile/$', UserProfile.as_view()),
    url(r'^api/email/', EmailConfirmationCreating.as_view()),
]

router = DefaultRouter()
router.register(r'^api/verify', EmailConfirming, basename='confirmation')

profile_urlpatterns += router.urls
