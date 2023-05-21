import os
import json
import requests

BASE_URL = 'http://localhost:9292'  # Update with the appropriate base URL

def load_settings():
    settings_path = os.path.expanduser('~/.notecli/settings.json')

    if os.path.exists(settings_path):
        with open(settings_path) as f:
            settings = json.load(f)
    else:
        settings = {}

    return settings

def save_settings(settings):
    settings_path = os.path.expanduser('~/.notecli/settings.json')

    os.makedirs(os.path.dirname(settings_path), exist_ok=True)

    with open(settings_path, 'w') as f:
        json.dump(settings, f)

def get_token():
    settings = load_settings()
    return settings.get('token')

def set_token(token):
    settings = load_settings()
    settings['token'] = token
    save_settings(settings)

def login():
    token = get_token()

    if token:
        print('You are already logged in.')
    else:
        username = input('Enter your username: ')
        password = input('Enter your password: ')

        response = requests.post(f'{BASE_URL}/login', json={'username': username, 'password': password})

        if response.status_code == 200:
            token = response.json().get('token')
            set_token(token)
            print('Login successful.')
        else:
            print('Login failed. Please try again.')

def logout():
    set_token(None)
    print('Logout successful.')

def paste():
    token = get_token()

    if token:
        content = input('Enter the content to paste: ')

        headers = {'Authorization': f'Bearer {token}'}
        data = {'content': content}

        response = requests.post(f'{BASE_URL}/paste', headers=headers, json=data)

        if response.status_code == 200:
            note_id = response.json().get('note_id')
            print(f'Paste saved successfully. Note ID: {note_id}')
        else:
            print('Error saving the paste.')
    else:
        print('You are not logged in. Please login first.')

def get_bin():
    token = get_token()

    if token:
        headers = {'Authorization': f'Bearer {token}'}
        response = requests.get(f'{BASE_URL}/bin', headers=headers)

        if response.status_code == 200:
            content = response.json().get('content')
            print(f'Bin content:\n{content}')
        else:
            print('Error retrieving bin content.')
    else:
        print('You are not logged in. Please login first.')

def main():
    while True:
        choice = input('Select an option: \n1. Login\n2. Logout\n3. Paste\n4. Get Bin\n5. Exit\n')

        if choice == '1':
            login()
        elif choice == '2':
            logout()
        elif choice == '3':
            paste()
        elif choice == '4':
            get_bin()
        elif choice == '5':
            break
        else:
            print('Invalid option. Please try again.')

if __name__ == '__main__':
    main()
