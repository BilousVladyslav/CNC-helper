from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import Machine, MachineLog
from user_profile.serializers import UsersSerializer


class MachineSerializer(serializers.ModelSerializer):
    supervisors = serializers.PrimaryKeyRelatedField(many=True,
                                                     required=True,
                                                     queryset=get_user_model().objects.filter(is_supervisor=True))
    workers = serializers.PrimaryKeyRelatedField(many=True,
                                                 queryset=get_user_model().objects.filter(is_verified=True))

    class Meta:
        model = Machine
        fields = ['inventory_number', 'name', 'supervisors', 'workers']

    def validate_supervisors(self, value):
        for supervisor in value:
            if not supervisor.is_supervisor:
                value.delete(supervisor)
        return value


class ReadOnlyMachineSerializer(serializers.ModelSerializer):
    supervisors = UsersSerializer(many=True, read_only=True)
    workers = UsersSerializer(many=True, read_only=True)

    class Meta:
        model = Machine
        fields = ['inventory_number', 'name', 'supervisors', 'workers']


class GetMachineLogSerializer(serializers.ModelSerializer):
    bench = serializers.PrimaryKeyRelatedField(queryset=Machine.objects.all())
    worked_now = UsersSerializer(read_only=True)
    has_been_read = serializers.SerializerMethodField()

    class Meta:
        model = MachineLog
        fields = ['bench', 'log_header', 'log_text', 'created', 'worked_now', 'has_been_read']

    def get_has_been_read(self, obj):
        user = self.context['user']
        if user not in obj.readers.all():
            obj.readers.add(user)
            return False
        return True


class CreateMachineLogSerializer(serializers.ModelSerializer):
    bench = serializers.PrimaryKeyRelatedField(queryset=Machine.objects.all())
    worked_now = UsersSerializer(read_only=True)

    class Meta:
        model = MachineLog
        fields = ['bench', 'log_header', 'log_text', 'worked_now']

    def create(self, validated_data):
        log = MachineLog.objects.create(**validated_data, worked_now=self.context['user'])
        return log