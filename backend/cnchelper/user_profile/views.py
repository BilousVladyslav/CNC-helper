from rest_framework import status
from rest_framework.filters import SearchFilter
from rest_framework.response import Response
from rest_framework.generics import GenericAPIView
from rest_framework.authtoken.models import Token
from rest_framework.permissions import IsAuthenticated
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from rest_framework.authtoken.views import ObtainAuthToken
from rest_framework.mixins import CreateModelMixin, RetrieveModelMixin, UpdateModelMixin, DestroyModelMixin, \
    ListModelMixin

from django.contrib.auth import get_user_model

from .permissions import IsSupervisor, IsVerified
from .serializers import RegisterUserSerializer, PasswordChangeSerializer, EmailConfirmationSerializer, \
    ConfirmEmailSerializer, UserProfileSerializer, UsersSerializer


class ObtainTokenWithStatus(ObtainAuthToken):

    def post(self, request, *args, **kwargs):
        serializer = self.serializer_class(data=request.data,
                                           context={'request': request})
        serializer.is_valid(raise_exception=True)
        user = serializer.validated_data['user']
        token, _ = Token.objects.get_or_create(user=user)
        return Response({
            'token': token.key,
            'is_verified': user.is_verified
        })


class UserRegistration(GenericAPIView, CreateModelMixin):
    serializer_class = RegisterUserSerializer

    def post(self, request):
        return self.create(request)


class PasswordUpdating(GenericAPIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [BasicAuthentication, SessionAuthentication, TokenAuthentication]
    serializer_class = PasswordChangeSerializer

    def put(self, request):
        serializer = self.serializer_class(data=request.data,
                                           context={'user': request.user})
        serializer.is_valid(raise_exception=True)
        serializer.save()
        return Response(status=status.HTTP_200_OK)


class EmailConfirmationCreating(GenericAPIView):
    permission_classes = [IsAuthenticated]
    authentication_classes = [BasicAuthentication, SessionAuthentication, TokenAuthentication]
    serializer_class = EmailConfirmationSerializer

    def post(self, request):
        serializer = self.serializer_class(data=request.data,
                                           context={'user': request.user})
        serializer.is_valid(raise_exception=True)
        confirmation = serializer.save()
        # send_verification_email.delay(confirmation.send_to, confirmation.new_mail, confirmation.uuid)
        return Response(status=status.HTTP_201_CREATED)


class EmailConfirming(GenericAPIView):
    serializer_class = ConfirmEmailSerializer

    def put(self, request):
        serializer = self.serializer_class(data=request.data)
        serializer.is_valid(raise_exception=True)
        serializer.save()

        return Response(status=status.HTTP_200_OK)


class UserProfile(GenericAPIView, UpdateModelMixin, RetrieveModelMixin, DestroyModelMixin):
    permission_classes = [IsAuthenticated]
    authentication_classes = [BasicAuthentication, SessionAuthentication, TokenAuthentication]
    serializer_class = UserProfileSerializer
    queryset = get_user_model().objects.all()

    def get_object(self):
        return self.request.user

    def get(self, request):
        return self.retrieve(request)

    def put(self, request):
        return self.partial_update(request)

    def delete(self, request):
        return self.destroy(request)


class GetUsersList(GenericAPIView, ListModelMixin):
    permission_classes = [IsAuthenticated, IsSupervisor, IsVerified]
    authentication_classes = [BasicAuthentication, SessionAuthentication, TokenAuthentication]
    serializer_class = UsersSerializer
    queryset = get_user_model().objects.filter(is_verified=True)
    filter_backends = [SearchFilter]
    search_fields = ['^username', '^first_name', '^last_name']

