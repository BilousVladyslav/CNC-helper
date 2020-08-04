from django.test import TestCase, Client
from django.contrib.auth import get_user_model
from rest_framework.test import APITestCase
from datetime import datetime, date
from .models import MachineLog, Machine
import logging


logging.basicConfig(level=logging.ERROR)


def verify_worker(worker):
    worker.is_verified = True
    worker.save()


def verify_supervisor(supervisor):
    supervisor.is_verified = True
    supervisor.is_supervisor = True
    supervisor.save()


class MachineManagingTests(APITestCase):

    @classmethod
    def setUpTestData(cls):
        cls.supervisor = get_user_model().objects.create_user('supervisor', 'supervisor@user.com', 'Vladyslav',
                                                              'Bilous', 'foo', date(2000, 2, 26))
        cls.supervisor.is_verified = True
        cls.supervisor.is_supervisor = True
        cls.supervisor.save()

        cls.worker = get_user_model().objects.create_user('worker', 'worker@user.com', 'Vladyslav',
                                                          'Bilous', 'foo', date(2000, 2, 26))
        cls.worker.is_verified = True
        cls.worker.save()
        cls.URL = '/api/machines/'

    def test_machine_create_by_supervisor(self):
        self.client.force_login(user=self.supervisor)
        data ={
            'inventory_number': '15814856422696',
            'name': 'First CNC',
            'supervisors': ['supervisor'],
            'workers': ['worker']
        }
        response = self.client.post(self.URL, data, format='json')
        # logging.debug(response.data)
        self.assertEqual(response.status_code, 201)
        self.assertEqual(response.data['inventory_number'], '15814856422696')
        self.assertEqual(response.data['name'], 'First CNC')
        self.assertIn('supervisor', response.data['supervisors'])
        self.assertIn('worker', response.data['workers'])

    def test_machines_list(self):
        self.client.force_login(user=self.supervisor)
        data = {
            'inventory_number': '15814856422696',
            'name': 'First CNC',
            'supervisors': ['supervisor'],
            'workers': []
        }
        self.client.post(self.URL, data, format='json')
        LIST_URL = '{0}{1}/'.format(self.URL, data['inventory_number'])
        response = self.client.get(self.URL)

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['count'], 1)
        self.assertEqual(response.data['results'][0]['inventory_number'], '15814856422696')
        self.assertEqual(response.data['results'][0]['name'], 'First CNC')
        self.assertEqual(response.data['results'][0]['workers'], [])
        supervisors = {
            'username': 'supervisor',
            'full_name': 'Bilous Vladyslav'
        }
        self.assertEqual(response.data['results'][0]['supervisors'], [supervisors])

    def test_machine_retrieve(self):
        self.client.force_login(user=self.supervisor)
        data = {
            'inventory_number': '15814856422696',
            'name': 'First CNC',
            'supervisors': ['supervisor'],
            'workers': ['worker']
        }
        self.client.post(self.URL, data, format='json')
        RETRIEVE_URL = '{0}{1}/'.format(self.URL, data['inventory_number'])
        response = self.client.get(RETRIEVE_URL)

        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['inventory_number'], '15814856422696')
        self.assertEqual(response.data['name'], 'First CNC')
        supervisors = {
            'username': 'supervisor',
            'full_name': 'Bilous Vladyslav'
        }
        workers = {
            'username': 'worker',
            'full_name': 'Bilous Vladyslav'
        }
        self.assertEqual(response.data['supervisors'], [supervisors])
        self.assertEqual(response.data['workers'], [workers])

    def test_machine_delete(self):
        self.client.force_login(user=self.supervisor)
        data = {
            'inventory_number': '15814856422696',
            'name': 'First CNC',
            'supervisors': ['supervisor'],
            'workers': ['worker']
        }
        self.client.post(self.URL, data, format='json')
        DELETE_URL = '{0}{1}/'.format(self.URL, data['inventory_number'])
        response = self.client.delete(DELETE_URL)
        self.assertEqual(response.status_code, 204)

    def test_machine_update(self):
        self.client.force_login(user=self.supervisor)
        initial_data = {
            'inventory_number': '15814856422696',
            'name': 'First CNC',
            'supervisors': ['supervisor'],
            'workers': []
        }
        self.client.post(self.URL, initial_data, format='json')
        UPDATE_URL = '{0}{1}/'.format(self.URL, initial_data['inventory_number'])
        data = {
            'workers': ['worker']
        }
        response = self.client.patch(UPDATE_URL, data)
        self.assertEqual(response.status_code, 200)
        self.assertIn('worker', response.data['workers'])


class MachineLogsTests(APITestCase):

    @classmethod
    def setUpTestData(cls):
        cls.URL = '/api/logs/'
        cls.supervisor = get_user_model().objects.create_user('supervisor', 'supervisor@user.com', 'Vladyslav',
                                                              'Bilous', 'foo', date(2000, 2, 26))
        cls.supervisor.is_verified = True
        cls.supervisor.is_supervisor = True
        cls.supervisor.save()

        cls.worker = get_user_model().objects.create_user('worker', 'worker@user.com', 'Vladyslav',
                                                          'Bilous', 'foo', date(2000, 2, 26))
        cls.worker.is_verified = True
        cls.worker.save()

        cls.machine = Machine.objects.create(inventory_number='15814856422696',
                                             name='First CNC')
        cls.machine.supervisors.add(cls.supervisor)
        cls.machine.workers.add(cls.worker)
        cls.machine.save()

    def test_create_machine_log(self):
        self.client.force_login(user=self.worker)
        data = {
            'bench': '15814856422696',
            'log_header': 'No data',
            'log_text': 'Data for current detail is not loaded'
        }
        response = self.client.post(self.URL, data)
        self.assertEqual(response.status_code, 201)
        self.assertEqual(response.data['bench'], '15814856422696')
        self.assertEqual(response.data['log_header'], 'No data')
        self.assertEqual(response.data['log_text'], 'Data for current detail is not loaded')
        worker = {
            'username': 'worker',
            'full_name': 'Bilous Vladyslav'
        }
        self.assertEqual(response.data['worked_now'], worker)

    def test_get_machine_logs(self):
        self.client.force_login(user=self.worker)
        data = {
            'bench': '15814856422696',
            'log_header': 'No data',
            'log_text': 'Data for current detail is not loaded.'
        }
        self.client.post(self.URL, data)
        data['log_header'] = 'Safety shield'
        data['log_text'] = 'Safety shield are not installed.'
        self.client.post(self.URL, data)
        data['log_header'] = 'Сalibration not completed'
        data['log_text'] = 'Сalibration failed.'
        self.client.post(self.URL, data)

        response = self.client.get(self.URL, data)
        logging.debug(response.data)
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data['count'], 3)
        self.assertFalse(response.data['results'][0]['has_been_read'])
        self.assertFalse(response.data['results'][1]['has_been_read'])
        self.assertFalse(response.data['results'][2]['has_been_read'])

    def test_read_machine_logs(self):
        self.client.force_login(user=self.worker)
        data = {
            'bench': '15814856422696',
            'log_header': 'No data',
            'log_text': 'Data for current detail is not loaded.'
        }
        self.client.post(self.URL, data)

        first_response = self.client.get(self.URL, data)
        self.assertEqual(first_response.status_code, 200)
        self.assertFalse(first_response.data['results'][0]['has_been_read'])
        last_response = self.client.get(self.URL, data)
        self.assertEqual(last_response.status_code, 200)
        self.assertTrue(last_response.data['results'][0]['has_been_read'])
        self.assertIsNone(last_response.data['next'])
        self.assertIsNone(last_response.data['previous'])
