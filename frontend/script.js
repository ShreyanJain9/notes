const apiUrl = 'http://localhost:9292'; // Replace with your backend URL

// Login functionality
const loginButton = document.getElementById('login-button');
loginButton.addEventListener('click', () => {
    const username = document.getElementById('username-input').value;
    const password = document.getElementById('password-input').value;

    fetch(`${apiUrl}/login`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
        },
        body: JSON.stringify({ username, password }),
    })
        .then((response) => response.json())
        .then((data) => {
            // Save JWT token to localStorage for subsequent requests
            localStorage.setItem('token', data.token);

            // Hide login container and show app container
            document.getElementById('login-container').style.display = 'none';
            document.getElementById('app-container').style.display = 'block';

            // Load user's bin
            loadBin();
        })
        .catch((error) => console.error('Error:', error));
});

// Paste functionality
const pasteButton = document.getElementById('paste-button');
pasteButton.addEventListener('click', () => {
    const content = document.getElementById('content-input').value;

    fetch(`${apiUrl}/paste`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            Authorization: `Bearer ${localStorage.getItem('token')}`,
        },
        body: JSON.stringify({ content }),
    })
        .then((response) => response.json())
        .then((data) => {
            // Clear content input
            document.getElementById('content-input').value = '';

            // Reload user's bin
            loadBin();
        })
        .catch((error) => console.error('Error:', error));
});

// Load user's bin
function loadBin() {
    fetch(`${apiUrl}/bin`, {
        headers: {
            Authorization: `Bearer ${localStorage.getItem('token')}`,
        },
    })
        .then((response) => response.json())
        .then((data) => {
            const binList = document.getElementById('bin-list');
            binList.innerHTML = '';

            data.content.forEach((content) => {
                const li = document.createElement('li');
                li.textContent = content;
                binList.appendChild(li);
            });
        })
        .catch((error) => console.error('Error:', error));
}
