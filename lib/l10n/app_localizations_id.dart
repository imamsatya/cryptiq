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
  String get allowHints => 'Izinkan Bantuan (Hints)';

  @override
  String get bestTime => 'Waktu Terbaik';

  @override
  String levelsCompleted(int count, int total) {
    return '$count/$total selesai';
  }

  @override
  String get totalTime => 'Total Waktu';

  @override
  String get averageTime => 'Rata-rata';

  @override
  String get hintsUsed => 'Hint Digunakan';

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
  String get fillAllLetters => 'Harap isi semua huruf terlebih dahulu!';

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

  @override
  String get selectLevel => 'Pilih Level';

  @override
  String get badges => 'Lencana';

  @override
  String get passAndPlay => 'Main Bergantian (2-4)';

  @override
  String get decodeTheLogic => 'Pecahkan Logika';

  @override
  String continueLevel(int number) {
    return 'Lanjutkan (Level $number)';
  }

  @override
  String get selectDifficulty => 'Pilih Kesulitan';

  @override
  String get all => 'Semua';

  @override
  String get completed => 'Selesai';

  @override
  String get locked => 'Terkunci';

  @override
  String get unlocked => 'Terbuka';

  @override
  String get theme => 'Tema';

  @override
  String get replayTutorial => 'Ulangi Tutorial';

  @override
  String get version => 'Versi';

  @override
  String get contactUs => 'Hubungi Kami';

  @override
  String get resetProgress => 'Reset Progres';

  @override
  String get correct => 'Benar!';

  @override
  String get incorrect => 'Salah';

  @override
  String get round => 'Ronde';

  @override
  String get player => 'Pemain';

  @override
  String get score => 'Skor';

  @override
  String get winner => 'Pemenang';

  @override
  String get draw => 'Seri';

  @override
  String get players => 'Pemain';

  @override
  String get rounds => 'Ronde';

  @override
  String get difficulty => 'Kesulitan';

  @override
  String get operation => 'Operasi';

  @override
  String get mixed => 'Campuran';

  @override
  String get startGame => 'Mulai';

  @override
  String get achievements => 'Pencapaian';

  @override
  String get streak => 'Beruntun';

  @override
  String get solvedIn => 'Selesai dalam';

  @override
  String get seconds => 'detik';

  @override
  String get noHintsUsed => 'Tanpa petunjuk';

  @override
  String get playAgain => 'Main Lagi';

  @override
  String get results => 'Hasil';

  @override
  String get dailyStreak => 'Streak Harian';

  @override
  String get giveUp => 'Menyerah';

  @override
  String get rematch => 'Tanding Ulang';

  @override
  String get achievementUnlocked => 'Pencapaian Terbuka!';

  @override
  String get noHintsAvailable => 'Hint habis untuk puzzle ini';

  @override
  String get overallProgress => 'Progres Keseluruhan';

  @override
  String roundNumber(int number) {
    return 'Ronde $number';
  }

  @override
  String dayStreak(int count) {
    return '$count Hari Beruntun!';
  }

  @override
  String get shareResult => 'Bagikan Hasil';

  @override
  String get dailyComplete => 'Tantangan Harian Selesai!';

  @override
  String get completeMoreLevels => 'Selesaikan level lagi untuk replay';

  @override
  String get viewSolution => 'Lihat Jawaban';

  @override
  String get attempts => 'Percobaan';

  @override
  String get close => 'Tutup';

  @override
  String get game => 'Permainan';

  @override
  String get soundEffects => 'Efek Suara';

  @override
  String get hapticFeedback => 'Umpan Balik Haptic';

  @override
  String get dailyReminder => 'Pengingat Harian';

  @override
  String get appearance => 'Tampilan';

  @override
  String get upgradeToPro => 'Upgrade ke Pro';

  @override
  String get noAds => 'Tanpa Iklan';

  @override
  String get allThemes => 'Semua Tema';

  @override
  String get bonusHint => '+1 Petunjuk Bonus';

  @override
  String get goPro => 'Jadi Pro';

  @override
  String get proActive => 'CryptiQ Pro ✓';

  @override
  String get byDifficulty => 'Per Kesulitan';

  @override
  String get totalStars => 'Total Bintang';

  @override
  String get avgTime => 'Rata-rata Waktu';

  @override
  String get enjoyingApp => 'Suka CryptiQ?';

  @override
  String get rateAppBody =>
      'Jika kamu suka aplikasi ini, luangkan waktu untuk menilai!';

  @override
  String get levelSelectHint =>
      '💡 Tips: Tekan untuk main, tahan (hold) level yang selesai untuk detail.';

  @override
  String get noThanks => 'Tidak, Terima Kasih';

  @override
  String get later => 'Nanti';

  @override
  String get rateNow => 'Nilai Sekarang ⭐';

  @override
  String get undo => 'Undo';

  @override
  String get overview => 'Ringkasan';

  @override
  String get dataCollection => 'Pengumpulan Data';

  @override
  String get thirdPartyServices => 'Layanan Pihak Ketiga';

  @override
  String get dataStorage => 'Penyimpanan Data';

  @override
  String get childrenPrivacy => 'Privasi Anak';

  @override
  String get changes => 'Perubahan';

  @override
  String get contact => 'Kontak';

  @override
  String get lastUpdated => 'Terakhir Diperbarui';

  @override
  String levelsOf(int completed, int total) {
    return '$completed dari $total level selesai';
  }

  @override
  String get tutorialWelcomeTitle => 'Selamat Datang di CryptiQ!';

  @override
  String get tutorialWelcomeBody =>
      'Setiap huruf mewakili satu digit unik (0-9).\nTugas kamu: temukan digit untuk setiap huruf\nagar persamaan menjadi benar.';

  @override
  String get tutorialSelectTitle => 'Langkah 1: Pilih Huruf';

  @override
  String get tutorialSelectBody =>
      'Ketuk huruf di persamaan.\nHuruf yang dipilih akan menyala.';

  @override
  String get tutorialAssignTitle => 'Langkah 2: Pilih Angka';

  @override
  String get tutorialAssignBody =>
      'Gunakan keypad untuk memilih digit (0-9)\nuntuk huruf yang dipilih.\nSetiap digit hanya bisa dipakai sekali!';

  @override
  String get tutorialCheckTitle => 'Langkah 3: Periksa Jawaban';

  @override
  String get tutorialCheckBody =>
      'Setelah semua huruf terisi, ketuk \"Periksa\".\nHuruf salah berubah merah — perbaiki!\nGunakan Petunjuk atau Undo jika buntu.';

  @override
  String get tutorialGoTitle => 'Kamu Siap!';

  @override
  String get tutorialGoBody =>
      'Selesaikan cepat tanpa hint untuk ⭐⭐⭐!\nSelamat bermain! 🧩';

  @override
  String get next => 'Lanjut';

  @override
  String get autoFillNext => 'Otomatis Pilih Huruf Berikutnya';

  @override
  String get onboardingWelcomeTitle => 'Selamat Datang di CryptiQ!';

  @override
  String get onboardingWelcomeSubtitle => 'Decode the Logic';

  @override
  String get onboardingWelcomeBody =>
      'CryptiQ adalah game teka-teki kriptaritma di mana setiap huruf mewakili digit unik (0-9).\n\nTujuanmu: cari tahu digit mana untuk setiap huruf agar persamaan menjadi benar!';

  @override
  String get onboardingHowToPlay => 'Cara Bermain';

  @override
  String get onboardingSelectAssign => 'Pilih & Isi';

  @override
  String get onboardingExample => 'Jika S=9, E=5, N=6, D=7\nmaka SEND = 9567';

  @override
  String get onboardingNeedHelp => 'Butuh Bantuan?';

  @override
  String get onboardingDailyTitle => 'Tantangan Harian';

  @override
  String get onboardingDailySubtitle => 'Kembali Setiap Hari!';

  @override
  String get onboardingReady => 'Siap? Ayo mulai! 🚀';

  @override
  String get skip => 'Lewati';

  @override
  String get startPlaying => 'Mulai Bermain';

  @override
  String playerName(int number) {
    return 'Pemain $number';
  }

  @override
  String get addPlayer => 'Tambah Pemain';

  @override
  String roundsLabel(int count) {
    return 'Ronde: $count';
  }

  @override
  String get addition => 'Penjumlahan (+)';

  @override
  String get subtraction => 'Pengurangan (−)';

  @override
  String get multiply => 'Perkalian (×)';

  @override
  String get multiStep => 'Multi-langkah';

  @override
  String get passDevice => 'Berikan perangkat ke pemain ini';

  @override
  String get roundDetails => 'Detail Ronde';

  @override
  String get gaveUp => 'Menyerah';

  @override
  String get beatMyTime => 'Bisakah kamu mengalahkan waktuku?';

  @override
  String get allLevelsFreeTitle => 'Semua 1200 Level GRATIS';

  @override
  String get allLevelsFreeBody => 'Tidak ada level terkunci. Nikmati!';

  @override
  String get privacyOverviewBody =>
      'Kami menghormati privasi Anda dan berkomitmen melindungi informasi pribadi Anda.';

  @override
  String get privacyDataBody =>
      'Semua progress game disimpan secara lokal di perangkat Anda menggunakan penyimpanan offline (Hive). Kami tidak memerlukan pembuatan akun atau login.';

  @override
  String get privacyStorageBody =>
      'Semua data (progress game, pengaturan, pencapaian) disimpan secara lokal di perangkat Anda. Menghapus aplikasi akan menghapus semua data lokal.';

  @override
  String get privacyChangesBody =>
      'Kami dapat memperbarui kebijakan ini. Penggunaan berkelanjutan setelah perubahan dianggap sebagai persetujuan.';

  @override
  String privacyContactBody(String email) {
    return 'Untuk pertanyaan, email: $email';
  }

  @override
  String get multiStepLabel => 'Multi-langkah';

  @override
  String get stars3 => 'Bintang';

  @override
  String get onboardingHowToPlayBody =>
      '1. Ketuk huruf untuk memilihnya\n2. Ketuk angka (0-9) untuk mengisinya\n3. Setiap huruf harus memiliki digit unik\n4. Tekan lama huruf untuk menghapus';

  @override
  String get onboardingHelpSubtitle => 'Petunjuk & Pemeriksaan';

  @override
  String get onboardingHelpBody =>
      '• Ketuk 💡 Petunjuk untuk membuka satu huruf\n• Ketuk ✓ Periksa untuk cek jawaban\n• Huruf salah merah, benar hijau\n• Selesaikan tanpa hint untuk ⭐ lebih banyak!';

  @override
  String get onboardingDailyBody =>
      '• Puzzle baru setiap hari\n• Bangun streak 🔥 dengan bermain harian\n• Buka pencapaian saat bermain\n• 1200 level dari Mudah ke Ahli — semua GRATIS!';

  @override
  String get onboardingStarExample =>
      '⭐⭐⭐  Tanpa hint, cepat\n⭐⭐     1-2 hint\n⭐       3+ hint';

  @override
  String usedBy(String letter) {
    return 'Dipakai oleh: $letter';
  }

  @override
  String get notUsed => 'Belum dipakai';

  @override
  String get replayConfirmTitle => 'Ulangi level ini?';

  @override
  String get replayConfirmBody =>
      'Kamu sudah punya ⭐⭐⭐ di level ini. Skor terbaikmu akan tetap tersimpan.';

  @override
  String get cancel => 'Batal';

  @override
  String get newBadge => 'BARU';

  @override
  String get themePicker => 'Tema';

  @override
  String get proThemeHint => 'Buka lebih banyak tema dengan Pro';

  @override
  String get shareStats => 'Bagikan Statistik';

  @override
  String get updateAvailable => 'Pembaruan Tersedia';

  @override
  String get updateBody =>
      'Versi terbaru CryptiQ tersedia. Perbarui sekarang untuk pengalaman terbaik!';

  @override
  String get updateNow => 'Perbarui Sekarang';

  @override
  String get puzzlesSolved => 'Puzzle Diselesaikan';

  @override
  String get allDone => 'Selesai Semua!';

  @override
  String hintCount(int count) {
    return 'Petunjuk ($count)';
  }

  @override
  String get incorrectTryAgain => 'Salah — coba lagi!';

  @override
  String playerScored(String player, int score) {
    return '$player meraih $score poin';
  }

  @override
  String hintsCount(int count) {
    return '$count petunjuk';
  }

  @override
  String roundOf(int current, int total) {
    return 'Ronde $current dari $total';
  }

  @override
  String get imReady => 'Saya Siap!';

  @override
  String playerWins(String player) {
    return '$player Menang!';
  }

  @override
  String playerStatsLine(int solved, int total, String time, int hints) {
    return '$solved/$total selesai • $time • $hints petunjuk';
  }

  @override
  String scorePts(int score) {
    return '${score}poin';
  }

  @override
  String get playerNameHint => 'Nama pemain';

  @override
  String get multiStepNote =>
      'Puzzle multi-langkah hanya untuk Sulit/Ahli. Kesulitan akan diabaikan.';

  @override
  String percentUnlocked(String percent) {
    return '$percent% terbuka';
  }

  @override
  String shareDailyText(String time, int streak) {
    return 'Saya menyelesaikan Tantangan Harian CryptiQ dalam $time! 🔥 $streak hari beruntun! Bisakah kamu mengalahkannya?\n\n#CryptiQ #TantanganHarian';
  }

  @override
  String get achvNoHints10Title => 'Pikiran Tajam';

  @override
  String get achvStreak30Title => 'Tuan Beruntun';

  @override
  String get achvStreak14Desc => 'Tantangan harian 14 hari berturut-turut';

  @override
  String get achvPerfect50Desc => 'Dapatkan 3 bintang di 50 level';

  @override
  String get achvFiveHundredLevelsTitle => 'Setengah Jalan Ke Sana';

  @override
  String get achvExpertMasterTitle => 'Ahli Kriptografi';

  @override
  String get achvLightningDesc =>
      'Pecahkan teka-teki dalam waktu kurang dari 10 detik';

  @override
  String get achvFirstSolveDesc => 'Pecahkan teka-teki pertama Anda';

  @override
  String get achvExpertMasterDesc => 'Selesaikan semua level Pakar';

  @override
  String get achvPerfect50Title => 'Tanpa cela';

  @override
  String get achvHundredLevelsDesc => 'Selesaikan 100 level';

  @override
  String get achvHundredStarsDesc => 'Hasilkan 100 bintang';

  @override
  String get achvHardMasterDesc => 'Selesaikan semua level Sulit';

  @override
  String get achvHundredStarsTitle => 'Pemburu Bintang';

  @override
  String get achvStreak14Title => 'Juara Dua Minggu';

  @override
  String get achvPerfect10Desc => 'Dapatkan 3 bintang di 10 level';

  @override
  String get achvHundredLevelsTitle => 'Perwira';

  @override
  String get achvHardMasterTitle => 'Mengeras';

  @override
  String get achvLightningTitle => 'Secepat Kilat';

  @override
  String get achvTenStarsDesc => 'Hasilkan 10 bintang';

  @override
  String get achvFirstSolveTitle => 'Langkah Pertama';

  @override
  String get achvStreak7Desc => 'Tantangan harian 7 hari berturut-turut';

  @override
  String get achvPerfect10Title => 'Perfeksionis';

  @override
  String get achvMediumMasterDesc => 'Selesaikan semua level Medium';

  @override
  String get achvSpeedDemonDesc =>
      'Pecahkan teka-teki dalam waktu kurang dari 15 detik';

  @override
  String get achvTenStarsTitle => 'Kolektor Bintang';

  @override
  String get achvFiftyLevelsDesc => 'Selesaikan 50 level';

  @override
  String get achvStreak7Title => 'Pejuang Minggu';

  @override
  String get achvNoHints50Desc => 'Pecahkan 50 teka-teki tanpa petunjuk';

  @override
  String get achvMediumMasterTitle => 'Sedang Langka';

  @override
  String get achvSpeedDemonTitle => 'Jago ngebut';

  @override
  String get achvThousandLevelsDesc => 'Selesaikan 1000 level';

  @override
  String get achvFiftyLevelsTitle => 'Penggemar Teka-teki';

  @override
  String get achvNoHints50Title => 'Jenius Murni';

  @override
  String get achvThousandStarsDesc => 'Hasilkan 1000 bintang';

  @override
  String get achvThousandLevelsTitle => 'Tuan Besar';

  @override
  String get achvStreak3Desc => 'Tantangan harian 3 hari berturut-turut';

  @override
  String get achvEasyMasterDesc => 'Selesaikan semua level Mudah';

  @override
  String get achvNoHints10Desc => 'Pecahkan 10 teka-teki tanpa petunjuk';

  @override
  String get achvStreak100Title => 'Tak terhentikan';

  @override
  String get achvStreak3Title => 'Berputar';

  @override
  String get achvThousandStarsTitle => 'Konstelasi';

  @override
  String get achvTenLevelsTitle => 'Melakukan Pemanasan';

  @override
  String get achvEasyMasterTitle => 'Mudah sekali';

  @override
  String get achvTenLevelsDesc => 'Selesaikan 10 level';

  @override
  String get achvStreak30Desc => 'Tantangan harian 30 hari berturut-turut';

  @override
  String get achvFiveHundredLevelsDesc => 'Selesaikan 500 level';

  @override
  String get achvStreak100Desc => 'Tantangan harian 100 hari berturut-turut';

  @override
  String get achvMultiStepFirstTitle => 'Reaksi berantai';

  @override
  String get achvMultiStepFirstDesc =>
      'Pecahkan teka-teki multi-langkah pertama Anda';

  @override
  String get achvMultiStepAllDesc =>
      'Selesaikan semua 200 teka-teki multi-langkah';

  @override
  String get achvMultiStepAllTitle => 'Raja Bertingkat';
}
