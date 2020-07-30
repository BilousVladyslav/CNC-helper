from rest_framework import status
from rest_framework.response import Response
from rest_framework.generics import GenericAPIView
from rest_framework.viewsets import GenericViewSet
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from rest_framework.mixins import CreateModelMixin, RetrieveModelMixin,\
    UpdateModelMixin, DestroyModelMixin, ListModelMixin

from django.contrib.auth import get_user_model

from user_profile.permissions import IsVerified, IsSupervisorOrReadOnly, IsWorkerOrReadOnly

from .serializers import MachineLogSerializer, MachineSerializer, ReadOnlyMachineSerializer
from .models import Machine, MachineLog


class MachineManaging(GenericViewSet,
                      CreateModelMixin,
                      UpdateModelMixin,
                      DestroyModelMixin):
    serializer_class = MachineSerializer
    permission_classes = [IsAuthenticated, IsVerified, IsSupervisorOrReadOnly]
    authentication_classes = [BasicAuthentication, SessionAuthentication, TokenAuthentication]
    lookup_field = 'inventory_number'

    def get_queryset(self):
        if self.request.user.is_supervisor:
            return Machine.objects.all()
        return Machine.objects.filter(workers=self.request.user)

    def list(self, request, *args, **kwargs):
        queryset = self.filter_queryset(self.get_queryset())

        page = self.paginate_queryset(queryset)
        if page is not None:
            serializer = ReadOnlyMachineSerializer(page, many=True)
            return self.get_paginated_response(serializer.data)

        serializer = ReadOnlyMachineSerializer(queryset, many=True)
        return Response(serializer.data)

    def retrieve(self, request, *args, **kwargs):
        instance = self.get_object()
        serializer = ReadOnlyMachineSerializer(instance)
        return Response(serializer.data)


class MachineLogging(GenericViewSet,
                     ListModelMixin,
                     CreateModelMixin):
    permission_classes = [IsAuthenticated, IsVerified, IsWorkerOrReadOnly]
    authentication_classes = [BasicAuthentication, SessionAuthentication, TokenAuthentication]
    serializer_class = MachineLogSerializer

    def get_queryset(self):
        if self.request.user.is_supervisor:
            return MachineLog.objects.filter(bench__supervisors=self.request.user)
        return MachineLog.objects.filter(worked_now=self.request.user)

    def get_serializer_context(self):
        return {'user': self.request.user}
