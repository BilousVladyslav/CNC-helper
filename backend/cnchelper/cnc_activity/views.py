from rest_framework import status
from rest_framework.response import Response
from rest_framework.filters import SearchFilter
from rest_framework.viewsets import GenericViewSet
from rest_framework.pagination import PageNumberPagination
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from rest_framework.mixins import CreateModelMixin, RetrieveModelMixin,\
    UpdateModelMixin, DestroyModelMixin, ListModelMixin

from user_profile.permissions import IsVerified, IsSupervisorOrReadOnly, IsWorkerOrReadOnly

from . import serializers
from .models import Machine, MachineLog
from .paginators import LogsPageNumberPagination, MachinesPageNumberPagination


class MachineManaging(GenericViewSet,
                      ListModelMixin,
                      RetrieveModelMixin,
                      CreateModelMixin,
                      UpdateModelMixin,
                      DestroyModelMixin):
    permission_classes = [IsAuthenticated, IsVerified, IsSupervisorOrReadOnly]
    authentication_classes = [BasicAuthentication, SessionAuthentication, TokenAuthentication]
    pagination_class = MachinesPageNumberPagination
    lookup_field = 'inventory_number'
    queryset = Machine.objects.order_by('inventory_number')

    def filter_queryset(self, queryset):
        if self.request.user.is_supervisor:
            return queryset
        return queryset.filter(workers=self.request.user)

    def get_serializer_class(self):
        if self.action == 'list' or self.action == 'retrieve':
            return serializers.ReadOnlyMachineSerializer
        else:
            return serializers.MachineSerializer


class MachineLogging(GenericViewSet,
                     ListModelMixin,
                     CreateModelMixin):
    permission_classes = [IsAuthenticated, IsVerified, IsWorkerOrReadOnly]
    authentication_classes = [BasicAuthentication, SessionAuthentication, TokenAuthentication]
    pagination_class = LogsPageNumberPagination
    filter_backends = [SearchFilter]
    search_fields = ['=bench__inventory_number']
    queryset = MachineLog.objects.order_by('created')

    def filter_queryset(self, queryset):
        if self.request.user.is_supervisor:
            return queryset.filter(bench__supervisors=self.request.user)
        return queryset.filter(worked_now=self.request.user)

    def get_serializer_class(self):
        if self.action == 'list':
            return serializers.GetMachineLogSerializer
        else:
            return serializers.CreateMachineLogSerializer

    def get_serializer_context(self):
        return {'user': self.request.user}
