from random import choice


LOGS_SAMPLES = [
    {'log_header': 'Safety error', 'log_text': 'Safety shield is not installed. You must install it.'}
]

def get_random_log():
    return choice(LOGS_SAMPLES)