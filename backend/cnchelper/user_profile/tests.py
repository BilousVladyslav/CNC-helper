from django.test import TestCase
from django.contrib.auth import get_user_model
from datetime import datetime, date
from .models import EmailConfirmation


def confirm_email(uuid):
    submited = EmailConfirmation.objects.get(uuid=uuid)
    submited.is_confirmed = True
    submited.user.is_verified = True
    submited.user.save()
    submited.save()


class UsersManagersTests(TestCase):
    def test_create_user(self):
        User = get_user_model()
        user = User.objects.create_user('normal', 'normal@user.com', 'Vladyslav',
                                        'Bilous', 'foo', date(2000, 2, 26))
        self.assertEqual(user.username, 'normal')
        self.assertEqual(user.email, 'normal@user.com')
        self.assertEqual(user.first_name, 'Vladyslav')
        self.assertEqual(user.get_short_name(), 'Vladyslav')
        self.assertEqual(user.last_name, 'Bilous')
        self.assertEqual(user.get_full_name(), 'Bilous Vladyslav')
        self.assertTrue(user.is_active)
        self.assertFalse(user.is_staff)
        self.assertFalse(user.is_superuser)

    def test_create_superuser(self):
        User = get_user_model()
        admin_user = User.objects.create_superuser('super', 'super@user.com', 'Vladyslav',
                                                   'Bilous', 'foo', date(2000, 2, 26))
        self.assertEqual(admin_user.username, 'super')
        self.assertEqual(admin_user.email, 'super@user.com')
        self.assertEqual(admin_user.first_name, 'Vladyslav')
        self.assertEqual(admin_user.get_short_name(), 'Vladyslav')
        self.assertEqual(admin_user.last_name, 'Bilous')
        self.assertEqual(admin_user.get_full_name(), 'Bilous Vladyslav')
        self.assertTrue(admin_user.is_active)
        self.assertTrue(admin_user.is_staff)
        self.assertTrue(admin_user.is_superuser)

    def test_create_confirmation(self):
        User = get_user_model()
        user = User.objects.create_user('confirm', 'confirm@user.com', 'Illya',
                                        'Filonich', 'foo', date(2010, 8, 16))
        confirmation = EmailConfirmation.objects.get(user=user)
        self.assertEqual(confirmation.user, user)
        self.assertEqual(confirmation.send_to, 'confirm@user.com')
        self.assertEqual(confirmation.new_mail, 'confirm@user.com')
        self.assertFalse(user.is_verified)
        self.assertFalse(confirmation.is_confirmed)

    def test_submit_confirmation(self):
        User = get_user_model()
        user = User.objects.create_user('submit', 'submit@user.com', 'Hennadiy',
                                        'Kovel', 'foo', date(2010, 8, 16))
        confirmation = EmailConfirmation.objects.get(user=user, is_confirmed=False)

        self.assertFalse(user.is_verified)
        self.assertFalse(confirmation.is_confirmed)

        confirm_email(confirmation.uuid)
        
        check_user = User.objects.get(username=user.username)
        check_confirm = EmailConfirmation.objects.get(uuid=confirmation.uuid)

        self.assertTrue(check_user.is_verified)
        self.assertTrue(check_confirm.is_confirmed)
