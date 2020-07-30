# Generated by Django 3.0.8 on 2020-07-29 17:56

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Machine',
            fields=[
                ('inventory_number', models.CharField(max_length=60, primary_key=True, serialize=False)),
                ('name', models.CharField(max_length=100)),
                ('supervisors', models.ManyToManyField(related_name='machines_to_manage', to=settings.AUTH_USER_MODEL)),
                ('workers', models.ManyToManyField(related_name='machines_to_work', to=settings.AUTH_USER_MODEL)),
            ],
        ),
        migrations.CreateModel(
            name='MachineLog',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('date_created', models.DateTimeField(auto_now=True)),
                ('log_header', models.CharField(max_length=150)),
                ('log_text', models.TextField()),
                ('bench', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to='cnc_activity.Machine')),
                ('worked_now', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]