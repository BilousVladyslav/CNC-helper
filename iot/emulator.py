import requests
import time
from .logs_samples import get_random_log

INVENTORY_NUMBER = '15115616515'
MACHINE_NAME = 'Second Machine'

print('====================================================')
print(f"Інвентарний номер станка: {INVENTORY_NUMBER}"
print(f"Назва станка: {MACHINE_NAME}")
print()
print('Авторизацыя:')


login = input('Введіть Ваш логін: ').strip()
password = input('Введіть Ваш пароль: ').strip()
auth_data = {
    "username": login,
    "password":  password
}
token_response = requests.get('http://127.0.0.1:8000/api/auth/', auth_data).json()

if not token_response['is_verified']:
    print('Ви не можете працювати за станком, так як не підтвердили свій профіль.')

else:
    print('Авторизація успішна.\n')

    request_header = {"Authorization": f"Token {token_response['token']}"}

    machine_info = requests.get('http://127.0.0.1:8000/api/machines/' + INVENTORY_NUMBER, headers=request_header).json()

    machine_workers = [worker['username'] for worker in machine_info['workers'] ]
    
    if login in machine_workers:
        for _ in range(15):
            log_info = get_random_log()
            log_data = {
                'bench': INVENTORY_NUMBER,
                'log_header': log_info['log_header'],
                'log_text': log_info['log_text']
            }
            log_response = requests.post('http://127.0.0.1:8000/api/logs/', log_data, headers=request_header).json()
            print(log_response)
    else:
        print('Ви не можете працювати за станком.')
