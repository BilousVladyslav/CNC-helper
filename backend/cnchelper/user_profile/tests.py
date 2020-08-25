from django.test import TestCase, Client
from django.contrib.auth import get_user_model
from django.contrib.auth.hashers import check_password
from rest_framework.test import APITestCase
from rest_framework.authtoken.models import Token
from datetime import datetime, date
from .models import EmailConfirmation
import logging


logging.basicConfig(level=logging.ERROR)


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

    @classmethod
    def setUpTestData(cls):
        cls.user = get_user_model().objects.create_user('normal', 'normal@user.com', 'Vladyslav',
                                                        'Bilous', 'foo', date(2000, 2, 26))
        cls.REGISTRATION_URL = '/api/register/'

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
            'email': 'normal@user.com',
            'first_name': 'Emily',
            'last_name': 'Jason',
            'birth_date': date(1998, 4, 8)
        }

        response = c.post(self.REGISTRATION_URL, registration_data, content_type='application/json')

        self.assertEqual(response.status_code, 400)
        self.assertEqual(response.json()['email'], ["user with this email already exists."])

    def test_exist_username(self):
        c = Client()
        registration_data = {
            'username': 'normal',
            'password': 'fooBaR12',
            'confirm_password': 'fooBaR12',
            'email': 'not.exists1@register.com',
            'first_name': 'Emily',
            'last_name': 'Jason',
            'birth_date': date(1998, 4, 8)
        }

        response = c.post(self.REGISTRATION_URL, registration_data, content_type='application/json')
        self.assertEqual(response.status_code, 400)
        self.assertEqual(response.json()['username'], ["user with this username already exists."])


class UserAuthTests(TestCase):

    @classmethod
    def setUpTestData(cls):
        cls.AUTH_URL = '/api/auth/'

        cls.user = get_user_model().objects.create_user('normal', 'normal@user.com', 'Vladyslav',
                                                        'Bilous', 'foo', date(2000, 2, 26))
        cls.verified_user = get_user_model().objects.create_user('confirmed', 'confirmed@user.com', 'Illya',
                                                                 'Filonich', 'foo', date(2010, 8, 16))

        confirmation = EmailConfirmation.objects.get(user=cls.verified_user, is_confirmed=False)
        confirm_email(confirmation.uuid)
        cls.verified_user.refresh_from_db(fields=['is_verified'])

    def test_correct_credentials_verified(self):
        c = self.client
        response = c.post(self.AUTH_URL, {'username': 'confirmed', 'password': 'foo'}, content_type='application/json')
        self.assertEqual(response.status_code, 200)
        self.assertTrue(response.json()['is_verified'])
        self.assertIsNotNone(response.json()['token'])

    def test_correct_credentials_not_verified(self):
        c = self.client
        response = c.post(self.AUTH_URL, {'username': 'normal', 'password': 'foo'}, content_type='application/json')
        self.assertEqual(response.status_code, 200)
        self.assertFalse(response.json()['is_verified'])
        self.assertIsNotNone(response.json()['token'])

    def test_incorrect_credentials(self):
        c = self.client
        response = c.post(self.AUTH_URL, {'username': 'normal', 'password': 'bar'}, content_type='application/json')
        self.assertEqual(response.status_code, 400)
        self.assertEqual(response.json()['non_field_errors'], ["Unable to log in with provided credentials."])

    def test_partial_credentials(self):
        c = self.client
        empty_response = c.post(self.AUTH_URL, {}, content_type='application/json')
        self.assertEqual(empty_response.status_code, 400)
        self.assertEqual(empty_response.json()['username'], ["This field is required."])
        self.assertEqual(empty_response.json()['password'], ["This field is required."])

        response_without_username = c.post(self.AUTH_URL, {'password': 'foo'}, content_type='application/json')
        self.assertEqual(response_without_username.status_code, 400)
        self.assertEqual(response_without_username.json()['username'], ["This field is required."])

        response_without_password = c.post(self.AUTH_URL, {'username': 'normal'}, content_type='application/json')
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
        old_token = Token.objects.get(user=self.user).key
        data = {
            'old_password': 'foo',
            'new_password': 'ThisIsTheNewPassword123',
            'confirm_password': 'ThisIsTheNewPassword123',
        }
        response = self.client.put(self.URL, data, format='json')

        self.user.refresh_from_db(fields=['password'])
        password = self.user.password
        new_token = Token.objects.get(user=self.user).key

        self.assertEqual(response.status_code, 200)
        self.assertNotEqual(new_token, old_token)
        self.assertFalse(check_password('foo', password))
        self.assertTrue(check_password('ThisIsTheNewPassword123', password))

    def test_incorrect_old_password(self):
        self.user.refresh_from_db(fields=['password'])
        self.client.force_login(user=self.user)
        data = {
            'old_password': 'bar',
            'new_password': 'ThisIsTheNewPassword123',
            'confirm_password': 'ThisIsTheNewPassword123',
        }
        response = self.client.put(self.URL, data, format='json')
        self.user.refresh_from_db(fields=['password'])
        password = self.user.password

        self.assertEqual(response.status_code, 400)
        self.assertEqual(response.data['non_field_errors'], ['Wrong password.'])
        self.assertTrue(check_password('foo', password))
        self.assertFalse(check_password('ThisIsTheNewPassword123', password))

    def test_incorrect_new_passwords(self):
        self.user.refresh_from_db(fields=['password'])
        self.client.force_login(user=self.user)
        data = {
            'old_password': 'foo',
            'new_password': 'ThisIsTheNewPassword111',
            'confirm_password': 'ThisIsTheNewPassword333',
        }
        response = self.client.put(self.URL, data, format='json')
        self.user.refresh_from_db(fields=['password'])
        password = self.user.password

        self.assertEqual(response.status_code, 400)
        self.assertEqual(response.data['non_field_errors'], ['New passwords must match.'])
        self.assertTrue(check_password('foo', password))
        self.assertFalse(check_password('ThisIsTheNewPassword123', password))


class VerifyUserProfileTests(APITestCase):

    @classmethod
    def setUpTestData(cls):
        cls.URL = '/api/verify/'
        cls.user = get_user_model().objects.create_user('normal', 'akkauntdriver@gmail.com', 'Vladyslav',
                                                        'Bilous', 'foo', date(2000, 2, 26))
        cls.confirmation = cls.user.confirmations.all()[0]

    def test_correct_uuid_verification(self):
        uuid = str(self.confirmation.uuid)
        self.assertFalse(self.user.is_verified)
        self.assertFalse(self.confirmation.is_confirmed)

        response = self.client.get(self.URL + uuid + '/')

        self.user.refresh_from_db(fields=['is_verified'])
        self.confirmation.refresh_from_db(fields=['is_confirmed'])

        self.assertEqual(response.status_code, 200)
        self.assertTrue(self.confirmation.is_confirmed)
        self.assertTrue(self.user.is_verified)


class ChangeEmailTests(APITestCase):

    @classmethod
    def setUpTestData(cls):
        cls.URL = '/api/email/'
        cls.user = get_user_model().objects.create_user('normal', 'normal@user.com', 'Vladyslav',
                                                        'Bilous', 'foo', date(2000, 2, 26))
        cls.confirmation = cls.user.confirmations.all()[0]
        cls.user.is_verified = True
        cls.confirmation.is_confirmed = True
        cls.user.save()
        cls.confirmation.save()

    def test_change_email_confirmation_creating(self):
        self.client.force_login(user=self.user)
        data = {'email': 'new.mail@mail.com'}

        response = self.client.post(self.URL, data, format='json')

        confirmations = EmailConfirmation.objects.filter(user=self.user, is_confirmed=False)

        self.assertIsNotNone(confirmations)
        self.assertEqual(response.status_code, 201)
        self.assertFalse(confirmations[0].is_confirmed)

    def test_email_changing_confirming(self):
        self.client.force_login(user=self.user)
        create_confirmation_data = {'email': 'new.mail@mail.com'}

        creation_response = self.client.post(self.URL, create_confirmation_data, format='json')

        confirmations = EmailConfirmation.objects.filter(user=self.user, is_confirmed=False)

        self.assertNotEqual(len(confirmations), 0)
        self.assertEqual(creation_response.status_code, 201)
        self.assertFalse(confirmations[0].is_confirmed)

        uuid = str(confirmations[0].uuid)
        confirming_response = self.client.get('/api/verify/' + uuid + '/')

        self.user.refresh_from_db(fields=['is_verified', 'email'])
        confirmations[0].refresh_from_db(fields=['is_confirmed'])

        self.assertEqual(confirming_response.status_code, 200)
        self.assertEqual(self.user.email, 'new.mail@mail.com')
        self.assertTrue(confirmations[0].is_confirmed)
        self.assertTrue(self.user.is_verified)


class UserProfileTests(APITestCase):

    @classmethod
    def setUpTestData(cls):
        cls.URL = '/api/profile/'
        cls.user = get_user_model().objects.create_user('normal', 'normal@user.com', 'Vladyslav',
                                                        'Bilous', 'foo', date(2000, 2, 26))
        cls.confirmation = cls.user.confirmations.all()[0]
        cls.user.is_verified = True
        cls.confirmation.is_confirmed = True
        cls.user.save()
        cls.confirmation.save()

    def test_get_user_profile(self):
        self.client.force_login(user=self.user)
        response = self.client.get(self.URL)

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['username'], 'normal')
        self.assertEqual(response.data['email'], 'normal@user.com')
        self.assertEqual(response.data['first_name'], 'Vladyslav')
        self.assertEqual(response.data['last_name'], 'Bilous')
        self.assertEqual(response.data['birth_date'], '2000-02-26')
        self.assertFalse(response.data['is_supervisor'])
        self.assertTrue(response.data['is_verified'])

    def test_delete_user_profile(self):
        self.client.force_login(user=self.user)
        response = self.client.delete(self.URL)
        queryset = get_user_model().objects.filter(username=self.user.username)

        self.assertEqual(response.status_code, 204)
        self.assertEqual(len(queryset), 0)

    def test_correct_profile_update(self):
        self.client.force_login(user=self.user)
        data = {
            'first_name': 'Anton',
            'last_name': 'Pakin'
        }
        response = self.client.put(self.URL, data)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['first_name'], 'Anton')
        self.assertEqual(response.data['last_name'], 'Pakin')
        self.assertEqual(response.data['birth_date'], '2000-02-26')

    def test_incorrect_profile_update(self):
        self.client.force_login(user=self.user)
        data = {
            'first_name': 'Anton',
            'last_name': 'Pakin',
            'wrong_field': 'value',
            'is_supervisor': True
        }
        response = self.client.put(self.URL, data)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['first_name'], 'Anton')
        self.assertEqual(response.data['last_name'], 'Pakin')
        self.assertEqual(response.data['birth_date'], '2000-02-26')
        self.assertFalse(response.data['is_supervisor'])
