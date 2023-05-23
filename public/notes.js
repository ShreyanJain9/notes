function showLoginForm() {
    document.getElementById('login-form').style.display = 'block';
    document.getElementById('note-form').style.display = 'none';
    document.getElementById('note-list').style.display = 'none';
  }

  function showNoteForm() {
    document.getElementById('login-form').style.display = 'none';
    document.getElementById('note-form').style.display = 'block';
    document.getElementById('note-list').style.display = 'block';
  }

function setToken() {
    localStorage.setItem('token', token);
  }

function getToken() {
    return localStorage.getItem('token');
  }

  function clearToken() {
    localStorage.removeItem('token');
  }

  function login() {
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;

    fetch('/login', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({ username, password })
    })
      .then(response => response.json())
      .then(data => {
        const token = data.token;
        if (token) {
          setToken(token);
          showNoteForm();
          fetchNotes();
        } else {
          alert('Login failed. Please try again.');
        }
      })
      .catch(error => {
        console.error('Error logging in:', error);
        alert('Error logging in. Please try again.');
      });
  }

  function logout() {
    clearToken();
    showLoginForm();
  }

  function fetchNotes() {
    const token = getToken();

    if (!token) {
      showLoginForm();
      return;
    }

    fetch('/notes', {
      headers: {
        'Authorization': `Bearer ${token}`
      }
    })
      .then(response => response.json())
      .then(data => {
        updateNoteList(data.notes);
      })
      .catch(error => {
        console.error('Error fetching notes:', error);
        alert('Error fetching notes. Please try again.');
      });
  }

  function createNote() {
    const content = document.getElementById('note-content').value;
    const token = getToken();

    if (content && token) {
      fetch('/paste', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
          'Authorization': `Bearer ${token}`
        },
        body: JSON.stringify({ content })
      })
        .then(response => response.json())
        .then(data => {
          document.getElementById('note-content').value = ''; // Clear the note content field
          fetchNotes(); // Refresh the notes list
        })
        .catch(error => {
          console.error('Error creating note:', error);
          alert('Error creating note. Please try again.');
        });
    }
  }

  function updateNoteList(notes) {
    const noteItems = document.getElementById('note-items');
    noteItems.innerHTML = '';

    if (notes && notes.length > 0) {
      notes.forEach(note => {
        const noteItem = document.createElement('div');
        noteItem.classList.add('note-item');
        noteItem.innerHTML = `
          <p>${note.content}</p>
          <br>
          <button onclick="editNoteModal('${note.id}', '${note.content}')">Edit</button>
          <button onclick="deleteNoteModal('${note.id}')">Delete</button>
        `;
        noteItems.appendChild(noteItem);
      });
    } else {
      noteItems.innerHTML += '<p>No notes found.</p>';
    }
  }

function editNoteModal(noteId, noteContent) {
    const newContent = prompt('Enter the new note content:', noteContent);
    if (newContent) {
        fetch(`/notes/${noteId}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${getToken()}`
            },
            body: JSON.stringify({ content: newContent })
        })
            .then(response => response.json())
            .then(data => {
                console.log('Note updated:', data);
                fetchNotes();
            })
            .catch(error => {
                console.error('Error updating note:', error);
                alert('Error updating note. Please try again.');
            });
    }
}

function deleteNoteModal(noteId) {
    if (confirm('Are you sure you want to delete this note?')) {
        fetch(`/notes/${noteId}`, {
            method: 'DELETE',
            headers: {
                'Authorization': `Bearer ${getToken()}`
            }
        })
            .then(response => response.json())
            .then(data => {
                console.log('Note deleted:', data);
                fetchNotes();
            })
            .catch(error => {
                console.error('Error deleting note:', error);
                alert('Error deleting note. Please try again.');
            });
    }
}

// ...

// Update note list UI
function fetchNotes() {
    const token = getToken();

    if (!token) {
        showLoginForm();
        return;
    }

    fetch('/notes', {
        headers: {
            'Authorization': `Bearer ${token}`
        }
    })
        .then(response => response.json())
        .then(data => {
            updateNoteList(data.notes);
        })
        .catch(error => {
            console.error('Error fetching notes:', error);
            alert('Error fetching notes. Please try again.');
        });
}
// Check if the user has a token stored
if (getToken()) {
    showNoteForm();
    fetchNotes();
} else {
    showLoginForm();
}
