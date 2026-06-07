# Firebase Setup Guide

Because `google-services.json` is excluded from this repo (it contains API keys), you need to connect your own Firebase project before running the app.

## Step 1 — Create a Firebase Project

1. Go to [console.firebase.google.com](https://console.firebase.google.com)
2. Click **Add project** → name it (e.g. `tactical-ops-dev`)
3. Disable Google Analytics if you don't need it → **Create project**

## Step 2 — Enable Auth and Firestore

**Authentication:**
- Build → Authentication → Get started
- Sign-in method → Enable **Email/Password**

**Firestore:**
- Build → Firestore Database → Create database
- Start in **production mode** → choose a region close to you → Enable

## Step 3 — Add the Android App

1. In Firebase Console → Project settings → **Add app** → Android
2. Package name: `com.tacticalops.tactical_ops`
3. Register app → download `google-services.json`
4. Place it at: `android/app/google-services.json`

> This file is gitignored — never commit it to a public repo.

## Step 4 — Add the Windows App (Optional)

Firebase on Windows uses the C++ SDK, which FlutterFire configures automatically. No separate credential file needed — it uses the same project via the FlutterFire config in `lib/firebase_options.dart`.

If you're setting up a brand-new Firebase project, regenerate `firebase_options.dart`:

```bash
# Install FlutterFire CLI if not already installed
dart pub global activate flutterfire_cli

# Re-run config (follow the prompts)
flutterfire configure
```

This regenerates `lib/firebase_options.dart` for your project.

## Step 5 — Firestore Security Rules

In Firebase Console → Firestore → Rules, replace the default with:

```
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can only read/write their own data
    match /users/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

Click **Publish**.

## Step 6 — Run

```bash
flutter pub get
flutter run -d windows   # or -d android
```

---

## Android Signing (Release Builds Only)

To build a signed release APK/AAB, create `android/key.properties`:

```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=tactical_ops
storeFile=../tactical_ops_release.jks
```

Generate a keystore if you don't have one:

```bash
keytool -genkey -v -keystore tactical_ops_release.jks -keyalg RSA -keysize 2048 -validity 10000 -alias tactical_ops
```

> `key.properties` and `*.jks` are gitignored. Keep them backed up separately.
