from django.contrib import admin
from django.urls import path
from user_profile.urls import profile_urlpatterns
from cnc_activity.urls import cnc_activity_urlpatterns


urlpatterns = [
    path('admin/', admin.site.urls),
]

urlpatterns += profile_urlpatterns
urlpatterns += cnc_activity_urlpatterns