from django.conf.urls import url
from .views import ObtainTokenWithStatus


profile_urlpatterns = [
    # url(r'^api/profile/$', UserProfile.as_view()),
    url(r'^api/auth/', ObtainTokenWithStatus.as_view()),
    # url(r'^api/profile/register/', RegistrationGenericView.as_view()),
]