from django.test import TestCase, Client
from django.contrib.auth import get_user_model
from django.contrib.auth.hashers import check_password
from rest_framework.test import APITestCase
from datetime import datetime, date
from .models import EmailConfirmation
import logging


logging.basicConfig(level=logging.DEBUG)


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
        user = User.objects.create_user('confirmed', 'confirmed@user.com', 'Illya',
                                        'Filonich', 'foo', date(2010, 8, 16))
        confirmation = EmailConfirmation.objects.get(user=user)
        self.assertEqual(confirmation.user, user)
        self.assertEqual(confirmation.send_to, 'confirmed@user.com')
        self.assertEqual(confirmation.new_mail, 'confirmed@user.com')
        self.assertFalse(user.is_verified)
        self.assertFalse(confirmation.is_confirmed)

    def test_submit_confirmation(self):
        User = get_user_model()
        user = User.objects.create_user('submited', 'submited@user.com', 'Hennadiy',
                                        'Kovel', 'foo', date(2010, 8, 16))
        confirmation = EmailConfirmation.objects.get(user=user, is_confirmed=False)

        self.assertFalse(user.is_verified)
        self.assertFalse(confirmation.is_confirmed)

        confirm_email(confirmation.uuid)

        check_user = User.objects.get(username=user.username)
        check_confirm = EmailConfirmation.objects.get(uuid=confirmation.uuid)

        self.assertTrue(check_user.is_verified)
        self.assertTrue(check_confirm.is_confirmed)


class UserRegistrationTests(TestCase):
    REGISTRATION_URL = '/api/register/'

    def test_correct_data(self):
        c = Client()
        registration_data = {
            'username': 'register',
            'password': 'fooBaR12',
            'confirm_password': 'fooBaR12',
            'email': 'register@register.com',
            'first_name': 'Emily',
            'last_name': 'Jason',
            'birth_date': date(1998, 4, 8)
        }
        response = c.post(self.REGISTRATION_URL, registration_data, content_type='application/json')
        self.assertEqual(response.status_code, 201)

    def test_exist_email(self):
        c = Client()
        registration_data = {
            'username': 'register1',
            'password': 'fooBaR12',
            'confirm_password': 'fooBaR12',
            'email': 'vladyslav.bilous1@gmail.com',
            'first_name': 'Emily',
            'last_name': 'Jason',
            'birth_date': date(1998, 4, 8)
        }
        correct_response = c.post(self.REGISTRATION_URL, registration_data, content_type='application/json')
        self.assertEqual(correct_response.status_code, 201)

        registration_data['username'] = 'register2'
        incorrect_response = c.post(self.REGISTRATION_URL, registration_data, content_type='application/json')

        self.assertEqual(incorrect_response.status_code, 400)
        self.assertEqual(incorrect_response.json()['email'], ["user with this email already exists."])

    def test_exist_username(self):
        c = Client()
        registration_data = {
            'username': 'just_a_name',
            'password': 'fooBaR12',
            'confirm_password': 'fooBaR12',
            'email': 'not.exists1@register.com',
            'first_name': 'Emily',
            'last_name': 'Jason',
            'birth_date': date(1998, 4, 8)
        }
        correct_response = c.post(self.REGISTRATION_URL, registration_data, content_type='application/json')
        self.assertEqual(correct_response.status_code, 201)

        registration_data['email'] = 'not.exists2@register.com'
        incorrect_response = c.post(self.REGISTRATION_URL, registration_data, content_type='application/json')
        self.assertEqual(incorrect_response.status_code, 400)
        self.assertEqual(incorrect_response.json()['username'], ["user with this username already exists."])


class UserAuthTests(TestCase):
    AUTH_URL = '/api/auth/'

    def test_correct_credentials_verified(self):
        user = get_user_model().objects.create_user('submit', 'submit@user.com', 'Hennadiy',
                                                    'Kovel', 'foo', date(2010, 8, 16))
        confirmation = EmailConfirmation.objects.get(user=user, is_confirmed=False)
        confirm_email(confirmation.uuid)

        c = Client()
        response = c.post(self.AUTH_URL, {'username': 'submit', 'password': 'foo'}, content_type='application/json')
        self.assertEqual(response.status_code, 200)
        self.assertTrue(response.json()['is_verified'])
        self.assertIsNotNone(response.json()['token'])

    def test_correct_credentials_not_verified(self):
        get_user_model().objects.create_user('confirm', 'confirm@user.com', 'Illya',
                                             'Filonich', 'foo', date(2010, 8, 16))
        c = Client()
        response = c.post(self.AUTH_URL, {'username': 'confirm', 'password': 'foo'}, content_type='application/json')
        self.assertEqual(response.status_code, 200)
        self.assertFalse(response.json()['is_verified'])
        self.assertIsNotNone(response.json()['token'])

    def test_incorrect_credentials(self):
        c = Client()
        response = c.post(self.AUTH_URL, {'username': 'confirm', 'password': 'bar'}, content_type='application/json')
        self.assertEqual(response.status_code, 400)
        self.assertEqual(response.json()['non_field_errors'], ["Unable to log in with provided credentials."])

    def test_partial_credentials(self):
        c = Client()
        empty_response = c.post(self.AUTH_URL, {}, content_type='application/json')
        self.assertEqual(empty_response.status_code, 400)
        self.assertEqual(empty_response.json()['username'], ["This field is required."])
        self.assertEqual(empty_response.json()['password'], ["This field is required."])

        response_without_username = c.post(self.AUTH_URL, {'password': 'foo'}, content_type='application/json')
        self.assertEqual(response_without_username.status_code, 400)
        self.assertEqual(response_without_username.json()['username'], ["This field is required."])

        response_without_password = c.post(self.AUTH_URL, {'username': 'confirm'}, content_type='application/json')
        self.assertEqual(response_without_password.status_code, 400)
        self.assertEqual(response_without_password.json()['password'], ["This field is required."])


class UpdatePasswordTests(APITestCase):

    @classmethod
    def setUpTestData(cls):
        cls.user = get_user_model().objects.create_user('normal', 'normal@user.com', 'Vladyslav',
                                                        'Bilous', 'foo', date(2000, 2, 26))
        cls.URL = '/api/password/'

    def test_correct_passwords(self):
        self.client.force_login(user=self.user)
        data = {
            'old_password': 'foo',
            'new_password': 'ThisIsTheNewPassword123',
            'confirm_password': 'ThisIsTheNewPassword123',
        }
        response = self.client.put(self.URL, data, format='json')

        self.user.refresh_from_db(fields=['password'])
        password = self.user.password

        self.assertEqual(response.status_code, 200)
        self.assertFalse(check_password('foo', password))
        self.assertTrue(check_password('ThisIsTheNewPassword123', password))
