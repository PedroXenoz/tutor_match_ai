# Tutor Match AI

**Tutor Match AI: A Tutor-Student Matching and Recommender System using K-Nearest Neighbors (KNN)**

A Flutter Web prototype. This repository is the result of **Activity 8: Flutter Web Project Initialization**.

## Current Activity Scope

Included now:
- Flutter Web project that runs in Google Chrome
- Home page (navigation bar, welcome section, three fictional sample tutor cards, footer)
- Login page (email/password form with validation, **demonstration only**)
- Reusable widgets, basic navigation, organized folders

Not included yet (future stages): PostgreSQL, REST API, KNN recommendations, real authentication, registration, password recovery.

> All tutor data shown in the app is **fictional demonstration data**. The Login button does not authenticate anyone.

## Technologies Used
- Flutter and Dart (Material widgets only, no extra packages)
- Google Chrome (target browser)
- Visual Studio Code
- Git and GitHub

## Project Folder Structure
```text
tutor_match_ai/
├── lib/
│   ├── main.dart              # entry point
│   ├── app.dart               # MaterialApp, theme, routes
│   ├── screens/
│   │   ├── home_screen.dart
│   │   └── login_screen.dart
│   ├── widgets/
│   │   ├── app_button.dart
│   │   └── app_text_field.dart
│   ├── services/              # reserved for future API integration
│   ├── models/
│   │   └── tutor.dart
│   ├── routes/
│   │   └── app_routes.dart
│   └── constants/
│       └── app_colors.dart
├── web/
├── test/
│   └── widget_test.dart
├── pubspec.yaml
├── analysis_options.yaml
├── .gitignore
└── README.md
```

## Prerequisites
- Windows 11
- Flutter SDK installed and added to PATH
- Google Chrome
- Visual Studio Code with the Flutter and Dart extensions
- Git

Android Studio, the Android SDK, and Visual Studio desktop build tools are **not** needed for this web prototype.

## Install and Run
```bash
flutter doctor
flutter devices
flutter pub get
flutter run -d chrome
```

`flutter devices` should list **Chrome**. If it does not, run `flutter config --enable-web` and try again.

### If web platform files are missing
This project includes a basic `web/` folder. If Flutter reports that the project is not configured for web, or `web/` is incomplete (for example, missing icons), run this from the project root:

```bash
flutter create . --platforms web
```

It adds missing web files and keeps your `lib/` code. Then run `flutter pub get` again.

### Run the tests (optional)
```bash
flutter test
```

## Git and GitHub
Create an **empty** repository on GitHub first (no README, no .gitignore), then replace the placeholder URL below.

```bash
git init
git add .
git commit -m "Initial commit: Flutter Web project with Home and Login pages"
git branch -M main
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
git push -u origin main
```

If Git asks who you are:
```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```
