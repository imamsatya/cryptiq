// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Indonesian (`id`).
class AppLocalizationsId extends AppLocalizations {
  AppLocalizationsId([String locale = 'id']) : super(locale);

  @override
  String get appTitle => 'CryptiQ';

  @override
  String get play => 'Main';

  @override
  String get dailyChallenge => 'Tantangan Harian';

  @override
  String get statistics => 'Statistik';

  @override
  String get settings => 'Pengaturan';

  @override
  String level(int number) {
    return 'Level $number';
  }

  @override
  String get easy => 'Mudah';

  @override
  String get medium => 'Sedang';

  @override
  String get hard => 'Sulit';

  @override
  String get expert => 'Ahli';

  @override
  String get hint => 'Petunjuk';

  @override
  String get check => 'Periksa';

  @override
  String get clear => 'Hapus';

  @override
  String get clearAll => 'Hapus Semua';

  @override
  String get congratulations => 'Selamat!';

  @override
  String get puzzleSolved => 'Puzzle Terpecahkan!';

  @override
  String get nextLevel => 'Level Berikutnya';

  @override
  String get replay => 'Ulangi';

  @override
  String get share => 'Bagikan';

  @override
  String get time => 'Waktu';

  @override
  String get hints => 'Petunjuk';

  @override
  String get bestTime => 'Waktu Terbaik';

  @override
  String get levelsCompleted => 'Level Selesai';

  @override
  String get totalTime => 'Total Waktu';

  @override
  String get averageTime => 'Rata-rata Waktu';

  @override
  String get hintsUsed => 'Petunjuk Digunakan';

  @override
  String get currentStreak => 'Streak Saat Ini';

  @override
  String get bestStreak => 'Streak Terbaik';

  @override
  String get sound => 'Suara';

  @override
  String get haptics => 'Getaran';

  @override
  String get language => 'Bahasa';

  @override
  String get about => 'Tentang';

  @override
  String get privacyPolicy => 'Kebijakan Privasi';

  @override
  String get rateApp => 'Nilai Aplikasi';

  @override
  String get removeAds => 'Hapus Iklan';

  @override
  String get restorePurchase => 'Pulihkan Pembelian';

  @override
  String get tryAgain => 'Coba Lagi';

  @override
  String get wrongAnswer => 'Jawaban Salah';

  @override
  String get someDigitsWrong => 'Beberapa digit tidak benar. Coba lagi!';

  @override
  String get allLevelsFree => 'Semua level GRATIS!';

  @override
  String get noLockedLevels => 'Tidak ada level terkunci, selamanya.';

  @override
  String get home => 'Beranda';

  @override
  String get back => 'Kembali';

  @override
  String get resume => 'Lanjutkan';

  @override
  String stars(int count) {
    return '$count Bintang';
  }
}
