# Tactical Ops

A military-themed productivity app built with Flutter and Firebase, designed for operators who think in missions, not to-do lists.

Plan your day with a morning briefing, track objectives through the Eisenhower matrix, and close the day with a structured night debrief.

---

## Features

| Feature | Description |
|---|---|
| **Morning Briefing** | Set your commander's intent, pick your Top 5 objectives, and assign them to the Eisenhower matrix |
| **Eisenhower Matrix** | Full-screen 2×2 priority matrix — DO NOW / SCHEDULE / DELEGATE / ELIMINATE — synced across all tabs |
| **Night Debrief** | Drag completed objectives into sections (wins, learning points, carry-forward), rate your day RAG |
| **Objectives / Tasks** | Unified task list sorted by matrix quadrant; tasks created anywhere appear everywhere |
| **SITREP Dashboard** | Daily quote, 7-day RAG strip, briefing/debrief status, and today's Top 5 resolved by name |
| **Ops Log** | Chronological history of past debriefs |
| **Persistent Auth** | Firebase Auth with splash-screen pre-warming — no re-login on every launch |

---

## Tech Stack

- **Framework**: Flutter 3 (Dart) — Android + Windows targets
- **Backend**: Firebase (Auth, Firestore)
- **State**: Riverpod v3 (`Notifier`, `StreamProvider`, `Provider.family`)
- **Routing**: GoRouter
- **Serialization**: Freezed + json_serializable
- **UI**: Material 3, ShareTechMono font, military olive palette

---

## Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install) ≥ 3.12
- [Firebase CLI](https://firebase.google.com/docs/cli) + a Firebase project
- Android SDK (for Android builds)
- Visual Studio 2022 with "Desktop development with C++" workload (for Windows builds)
- Git in system PATH (required by Windows build pipeline)

---

## Getting Started

### 1. Clone

```bash
git clone https://github.com/TS0047/tactical-ops.git
cd tactical-ops
flutter pub get
```

### 2. Configure Firebase

This repo excludes `google-services.json` (Android Firebase credentials). See **[SETUP.md](SETUP.md)** for step-by-step instructions on connecting your own Firebase project.

### 3. Run

```bash
# Windows desktop
flutter run -d windows

# Android (device or emulator must be connected)
flutter run -d android
```

---

## Building for Distribution

```bash
# Android APK (direct install / sideload)
flutter build apk --release

# Android App Bundle (Google Play)
flutter build appbundle --release

# Windows executable
flutter build windows --release
```

Output locations:
- APK → `build/app/outputs/flutter-apk/app-release.apk`
- AAB → `build/app/outputs/bundle/release/app-release.aab`
- Windows → `build/windows/x64/runner/Release/`

---

## Project Structure

```
lib/
├── core/
│   ├── constants/       # Colors, strings, theme, quotes
│   └── utils/           # Date helpers
├── data/
│   ├── models/          # Freezed data classes (Task, DailyPlan, Debrief…)
│   └── repositories/    # Firestore abstraction layer
├── presentation/
│   ├── providers/       # Riverpod providers & notifiers
│   ├── screens/         # One folder per feature screen
│   └── widgets/         # Shared widgets (AppShell, nav)
└── routing/             # GoRouter config + route names
```

---

## Architecture Notes

- **Single source of truth**: `Task.quadrant` drives the matrix tab; `DailyPlan.matrixItems` is a daily snapshot linked via `linkedTaskId`
- **Top 5 stores IDs**: `DailyPlan.topFive: List<String>` holds task IDs, resolved to titles at render time via `taskListProvider`
- **Reactive debrief**: `briefedTaskIdsProvider` watches the plan stream so the drag-and-drop strip is always in sync
- **Offline-first**: Firestore's local persistence is enabled; the app reads from cache when offline

---

## Contributing

1. Fork the repo
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Commit your changes
4. Push and open a PR against `develop`

See [SETUP.md](SETUP.md) for the full environment setup.

---

## License

MIT — see [LICENSE](LICENSE)
