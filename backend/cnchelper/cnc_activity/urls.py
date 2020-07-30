from django.conf.urls import url
from rest_framework.routers import DefaultRouter
from .views import MachineManaging, MachineLogging


router = DefaultRouter()
router.register(r'^api/logs', MachineLogging, basename='log')
router.register(r'^api/machines', MachineManaging, basename='machine')


cnc_activity_urlpatterns = router.urls
