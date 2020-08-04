from django.db import models
from django.contrib.auth import get_user_model


class Machine(models.Model):
    inventory_number = models.CharField(primary_key=True, max_length=60)
    name = models.CharField(blank=False, max_length=100)
    supervisors = models.ManyToManyField(get_user_model(), related_name='machines_to_manage')
    workers = models.ManyToManyField(get_user_model(), related_name='machines_to_work')


class MachineLog(models.Model):
    bench = models.ForeignKey(Machine, on_delete=models.CASCADE)
    created = models.DateTimeField(auto_now=True)
    log_header = models.CharField(max_length=150, blank=False)
    log_text = models.TextField(blank=False)
    worked_now = models.ForeignKey(get_user_model(), on_delete=models.CASCADE)
    readers = models.ManyToManyField(get_user_model(), related_name='read_logs')
