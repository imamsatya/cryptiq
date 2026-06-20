# Complete Localization Fix — CryptiQ

Fix semua teks yang belum diterjemahkan ke semua bahasa target.

## Temuan Audit

### Masalah 1: 91 Missing Keys di 9 Bahasa
Semua bahasa kecuali EN dan ID **hanya punya ~110 dari 223 key**. Berikut bahasa yang terdampak:
- 🇸🇦 Arabic (ar) — 91 key hilang
- 🇩🇪 German (de) — 91 key hilang
- 🇪🇸 Spanish (es) — 91 key hilang
- 🇫🇷 French (fr) — 91 key hilang
- 🇮🇳 Hindi (hi) — 91 key hilang
- 🇯🇵 Japanese (ja) — 91 key hilang
- 🇰🇷 Korean (ko) — 91 key hilang
- 🇧🇷 Portuguese (pt) — 91 key hilang
- 🌐 Chinese (zh) — 91 key hilang

### Masalah 2: ~30 Hardcoded Strings di Dart Files
Teks yang **belum pakai l10n sama sekali** (masih hardcoded English):

| File | Baris | Hardcoded String | New Key |
|------|-------|------------------|---------|
| `home_screen.dart` | 113 | `'Select Level'` | Sudah ada `l10n.selectLevel` |
| `game_screen.dart` | 182 | `'Level ${widget.levelNumber}'` | Sudah ada `l10n.level()` |
| `game_screen.dart` | 481-484 | `'EASY'`, `'MEDIUM'`, `'HARD'`, `'EXPERT'` | Sudah ada `l10n.easy` dst |
| `result_screen.dart` | 265 | `'Level ${widget.levelNumber}'` | Sudah ada `l10n.level()` |
| `result_screen.dart` | 440 | `'All Done!'` | Baru: `allDone` |
| `daily_result_screen.dart` | 210 | `'$streak Day Streak!'` | Sudah ada `l10n.dayStreak()` |
| `daily_result_screen.dart` | 269 | `'I solved today\'s CryptiQ...'` | Baru: `shareDaily` |
| `daily_challenge_screen.dart` | 215 | `'Hint (${gameState.hintsUsed})'` | Baru: `hintCount` |
| `multiplayer_game_screen.dart` | 229 | `'❌ Incorrect — try again!'` | Baru: `incorrectTryAgain` |
| `multiplayer_game_screen.dart` | 353-354 | `'$playerName scored $score pts'` | Baru: `playerScored` |
| `multiplayer_game_screen.dart` | 361 | `'$_hintsUsed hints'` | Baru: `hintsCount` |
| `multiplayer_game_screen.dart` | 391 | `'Round X of Y'` | Baru: `roundOf` |
| `multiplayer_game_screen.dart` | 457 | `"I'm Ready!"` | Baru: `imReady` |
| `multiplayer_game_screen.dart` | 647 | `'${l10n.hint} ($_hintsUsed)'` | Baru: `hintCount` |
| `multiplayer_result_screen.dart` | 140 | `'${winner.name} Wins!'` | Baru: `playerWins` |
| `multiplayer_result_screen.dart` | 317 | `'X/Y solved • time • hints'` | Baru: `playerStats` |
| `multiplayer_result_screen.dart` | 353 | `'Round ${round + 1}'` | Sudah ada `l10n.roundNumber()` |
| `multiplayer_result_screen.dart` | 384 | `'${pr.hintsUsed}h'` | Baru: `hintsShort` |
| `multiplayer_result_screen.dart` | 393 | `'${pr.score}pts'` | Baru: `pts` |
| `multiplayer_lobby_screen.dart` | 16-17 | `'Player 1'`, `'Player 2'` | Sudah ada `l10n.playerName()` |
| `multiplayer_lobby_screen.dart` | 25-37 | `_difficulties` & `_operations` maps | Harus override dgn l10n |
| `multiplayer_lobby_screen.dart` | 162 | `'Player name'` | Baru: `playerNameHint` |
| `multiplayer_lobby_screen.dart` | 214 | `'Rounds: $_rounds'` | Sudah ada `l10n.roundsLabel()` |
| `multiplayer_lobby_screen.dart` | 256 | `'ℹ️ Multi-step puzzles...'` | Baru: `multiStepNote` |
| `statistics_screen.dart` | 174 | `'Multi-step'` | Sudah ada `l10n.multiStepLabel` |
| `achievements_screen.dart` | 85 | `'X% unlocked'` | Baru: `percentUnlocked` |
| `achievement_service.dart` | 62+ | All 25 achievement titles & descriptions | Baru: 50 keys |
| `daily_result_screen.dart` | 117-119 | Month names `'Jan'...'Dec'` | Intl or new keys |
| `home_screen.dart` | 267 | Month names `'Jan'...'Dec'` | Same |

## Proposed Changes

### Phase 1: Add New l10n Keys to `app_en.arb`
Tambahkan ~20 key baru untuk hardcoded strings + format yang lebih baik di file ARB (termasuk terjemahannya ke `app_id.arb`).

### Phase 2: Fix Hardcoded Strings di 10 Dart Files
Modifikasi 10 file Dart yang disebutkan di atas untuk menggunakan `AppLocalizations.of(context)`.

### Phase 3: Tambah 91 Missing Keys ke 9 Bahasa
Tambahkan semua 91 key yang hilang dengan terjemahan yang benar di semua file ARB bahasa lain (ar, de, es, fr, hi, ja, ko, pt, zh).

---

## Catatan
- **Achievement Titles & Descriptions**: Bisa dipertimbangkan untuk diterjemahkan jika tidak ingin tetap menggunakan bahasa Inggris.
- **Nama Bulan**: Menggunakan format bulan dari paket `intl` agar otomatis mengikuti locale bahasa.
