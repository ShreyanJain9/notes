Notes Web Application
--------------------

The "notes" web application allows users to securely store and manage their notes online. Users can create, edit, delete, and retrieve their notes using a simple and intuitive API.

Setup:
- Make sure you have Ruby and SQLite installed on your system.
- Clone this repository to your local machine.
- Install the required dependencies by running: bundle install.
- Run the database migration to set up the necessary tables: ruby migration.rb.
- Start the application server by running: ruby app.rb.

API Endpoints:
- POST /register: Register a new user with a username and password.
- POST /login: Obtain a JWT token by providing valid username and password.
- POST /paste: Store a new note in the user's bin.
- GET /bin: Retrieve all notes from the user's bin.
- PUT /notes/:note_id: Edit the content of a specific note.
- DELETE /notes/:note_id: Delete a specific note.
- GET /notes/:note_id: Retrieve the content of a specific note.
- GET /notes: Retrieve all notes.

Authentication:
- The authentication process uses JWT (JSON Web Token).
- To authenticate, include the JWT token in the "Authorization" header as follows: "Bearer <jwt_token>".

Database:
- The application uses an SQLite database to store user information and notes.
- The database file is named "pastebin.db" and is created automatically upon running the migration.

Dependencies:
- This application is built with Ruby and uses the following gems: sinatra, sequel, bcrypt, jwt.
- The required gems are listed in the Gemfile.

Note: Replace "http://localhost:9292" in the API endpoints with the appropriate URL if you deploy the application to a different location.

Enjoy managing your notes with the "notes" web application!

