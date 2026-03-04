# CryptiQ — Decode the Logic 🧩

> A premium cryptarithm puzzle game for Android, built with Flutter.

## About

CryptiQ challenges players to solve cryptarithm puzzles — mathematical equations where letters represent digits. Each puzzle requires logical deduction to determine the correct digit-to-letter mapping.

**Example:**
```
  S E N D
+ M O R E
─────────
M O N E Y
```

## Features

### 🧩 Core Gameplay
- **1200 puzzles** across 4 difficulty levels (Easy → Expert)
- Interactive number pad with digit assignment
- Smart hint system with progressive reveal
- Undo button and auto-fill next letter
- Long press for digit usage tooltips
- Star rating system (⭐ – ⭐⭐⭐) with replay confirmation
- Timer pause when app goes to background

### 🔥 Daily Challenge
- New puzzle every day (date-seeded, deterministic)
- Streak tracking with milestones
- Monthly calendar view
- Push notification reminders

### 📊 Progression
- Level select with completion badges
- "NEW" tags on freshly unlocked levels
- Statistics dashboard with detailed metrics
- 20+ achievements with unlock animations
- Sharable score cards and statistics as images

### 👥 Multiplayer
- Pass & Play mode (2-4 players)
- Round-based scoring with customizable players
- Difficulty and operation filters

### 🎨 Themes
- 5 visual themes: Navy Gold, Ocean Teal, Midnight Purple, Forest Green, Rose Gold
- Theme picker in settings (premium themes for Pro users)
- Animated particle background on home screen

### 💎 Pro Features
- No ads
- Bonus hints
- All premium themes unlocked

### 🌐 Localization
- English (197 keys)
- Indonesian (195 keys)

## Tech Stack

| Layer | Technology |
|-------|-----------|
| Framework | Flutter 3.x |
| State Management | Riverpod |
| Navigation | GoRouter |
| Local Storage | Hive |
| Ads | Google AdMob |
| IAP | in_app_purchase |
| Audio | audioplayers |
| Notifications | flutter_local_notifications |
| Sharing | share_plus |

## Project Structure

```
lib/
├── core/
│   ├── constants/     # App constants
│   ├── services/      # Audio, Ads, IAP, Notifications, Update
│   └── theme/         # Theme presets and service
├── data/
│   └── datasources/   # Hive local database
├── domain/
│   └── entities/      # Puzzle, UserProgress models
├── l10n/              # Localization (EN, ID)
├── levels/            # Puzzle generator
└── presentation/
    ├── providers/     # Riverpod state providers
    ├── router/        # GoRouter configuration
    ├── screens/       # All app screens
    └── widgets/       # Reusable widgets
```

## Getting Started

```bash
# Clone
git clone https://github.com/imamsatya/cryptiq.git
cd cryptiq

# Install dependencies
flutter pub get

# Generate localization files
flutter gen-l10n

# Run
flutter run
```

## Build Release

```bash
flutter build appbundle --release
```

## License

All rights reserved. © 2026 CryptiQ.
