from django.test import TestCase
from django.contrib.auth import get_user_model
from datetime import datetime, date


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
