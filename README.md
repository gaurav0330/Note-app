# googlenoteclone

A Flutter-based note-taking app, inspired by Google Keep, that allows users to create, edit, and delete notes. The app supports Google sign-in for syncing notes and uses both Firestore for cloud storage and SQLite for local data storage.

Features

- Google Sign-In integration for seamless user authentication.
- Create, edit, and delete notes.
- Notes are stored locally using SQLite for offline access.
- Syncs notes with Firestore for cloud storage.
- Easy-to-use interface similar to Google Keep.

Packages Used

- firebase_auth: For Google sign-in integration.
- cloud_firestore: For storing notes in Firestore.
- sqflite: For local SQLite storage.
- path: To work with file paths for SQLite.

Folder Structure
|-- android/
|-- assets/
|-- ios/
|-- lib/
|-- linux/
|-- macos/
|-- web/
|-- windows/
|-- .gitignore
|-- .metadata
|-- README.md
|-- analysis_options.yaml
|-- pubspec.lock
|-- pubspec.yaml
