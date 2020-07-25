import logging

from django.urls import reverse
from django.core.mail import send_mail
from django.contrib.auth import get_user_model
from cnchelper.celery import app


@app.task(bind=True, default_retry_delay=10)
def send_verification_email(self, receiver_email, email_to_confirm, uuid_code):
    try:
        send_mail(
            'Verify your CNC-helper e-mail',
            f'Follow this link to verify your {email_to_confirm} e-mail: '
            'http://localhost:8000%s' % reverse('verify', kwargs={'uuid': str(uuid_code)}),
            'django.backend.dev@gmail.com',
            [receiver_email],
            fail_silently=False,
        )
    except Exception as e:
        self.retry(exc=e, max_retries=3)
