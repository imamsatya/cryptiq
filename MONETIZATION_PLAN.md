# 💰 Rencana Monetisasi CryptiQ (Serverless)

Dokumen ini memuat rancangan strategi monetisasi untuk game CryptiQ yang **100% dapat berjalan tanpa server backend khusus**. Semua data pembelian dan iklan akan dikelola secara lokal di perangkat pengguna atau melalui layanan pihak ketiga (App Store, Google Play, dan AdMob).

> [!TIP]
> **Konsep "Serverless" di Game Kasual:**
> Pada game kasual *offline-first*, kita bisa menggunakan *local database* (Hive) untuk menyimpan saldo item. Agar pemain tidak kehilangan item yang sudah dibeli saat ganti HP, kita akan mengandalkan fitur **Android Auto Backup** dan **iCloud Backup** bawaan sistem operasi.

---

## 1. In-App Purchases (IAP) — Pembelian Dalam Aplikasi

Pembelian ditangani langsung menggunakan *library* `in_app_purchase` bawaan Flutter.

### A. Pembelian Sekali Pakai (Non-Consumable)
Status pembelian ini akan melekat selamanya pada akun Google/Apple pengguna dan **bisa dipulihkan (Restore Purchases)** di HP mana saja secara otomatis.
- **Produk:** **CryptiQ Pro** (Harga Rekomendasi: $2.99 / Rp49.000)
- **Keuntungan:**
  1. Menghapus semua iklan Banner & Interstitial.
  2. Membuka semua Tema Visual Premium (Glassmorphism, dsb).
  3. Membuka opsi *Infinite Hints* (Pemain Pro tidak akan kehabisan batas petunjuk gratis).
- **Status Saat Ini:** ✅ Kodenya sudah kita buat sepenuhnya!

### B. Barang Sekali Pakai (Consumable)
Barang yang bisa dibeli berkali-kali. Karena kita tidak menggunakan server, saldo item akan disimpan di *local storage* (Hive).
- **Produk:** **Paket Koin/Hint (Hint Packs)**
  - *Small Pack* (20 Hints) — $0.99
  - *Mega Pack* (100 Hints) — $3.99
  - *Pro Pack* (Infinite Hints/Upgrade to Pro) — $5.99
- **Produk:** **Penyelamat Runtutan (Streak Freeze)**
  - Item seharga $0.99 untuk menyelamatkan *Daily Challenge Streak* yang terputus (mirip sistem Duolingo). 

> [!WARNING]
> **Resiko Consumable Tanpa Server:** Jika pemain menghapus instalasi game (Uninstall) lalu mengunduhnya lagi, *saldo Hint* yang mereka beli bisa hilang jika mereka mematikan fitur "Auto Backup" di HP mereka. Pastikan kita menambahkan teks pemberitahuan kecil saat pembelian.

---

## 2. Jaringan Iklan (Google AdMob)

Menghasilkan uang dari pemain gratisan (*Free-to-play users*). AdMob menangani semua penayangan dan inventaris iklan secara otomatis tanpa butuh server kita sendiri.

### A. Iklan Layar Penuh (Interstitial Ads)
Muncul sebagai jeda antar level setelah sebuah puzzle selesai.
- **Logika Penayangan Pintar (Smart Trigger):** Iklan tidak muncul di setiap level. Hanya muncul jika pemain sudah bermain **lebih dari 3 menit** DAN **melewati minimal 3 level** sejak iklan terakhir. Hal ini mencegah pengguna frustrasi dan menghapus aplikasi.
- **Status:** ✅ Sudah diimplementasikan dengan sangat baik di kode kita.

### B. Iklan Berhadiah (Rewarded Ads)
Pemain dengan sukarela menonton video iklan 30 detik untuk mendapatkan hadiah. Ini adalah format iklan yang **paling disukai pengguna** dan memiliki bayaran tertinggi (eCPM tertinggi).
- **Reward 1: "Get 1 Hint"**. Saat hint habis, pemain bisa menekan tombol Hint untuk menonton video dan membuka 1 huruf gratis. (✅ *Sudah kita buat kodenya*)
- **Reward 2: "Daily Free Hints"**. Di dalam toko (Store), sediakan kotak spesial di mana pemain bisa menonton iklan untuk mendapatkan +3 Hints yang masuk ke saldo mereka. Dibatasi 5 kali sehari.
- **Reward 3: "Revive Streak"**. Pemain yang bolong *Daily Challenge* bisa menonton 2 Iklan berturut-turut untuk memperbaiki rekor apinya secara gratis.

### C. Iklan Spanduk (Banner Ads)
Iklan kecil yang terus diam di layar. Karena game kita mengandalkan desain visual premium (*Glassmorphism*), kita **TIDAK AKAN** menaruh Banner Ad di layar utama permainan (Game Screen) agar tidak merusak keindahan desain.
- **Lokasi Penempatan yang Disarankan:**
  1. Bagian bawah **Layar Statistik** (Statistics Screen).
  2. Layar Pemilihan Level (Level Select Screen).
  3. Layar Hasil Akhir (Result Screen) setelah menang.

---

## 3. Ekosistem Rekomendasi: RevenueCat (Opsional)

Meskipun kamu tidak ingin menyewa atau membuat server backend (seperti Node.js, PHP, dll), untuk urusan In-App Purchase di tingkat *Production*, sangat disarankan menggunakan **RevenueCat**.

> [!IMPORTANT]
> **Kenapa RevenueCat?**
> Validasi resi (Receipt Validation) IAP wajib dilakukan menggunakan server untuk mencegah peretasan (seperti *Lucky Patcher* di Android). RevenueCat menyediakan Backend validasi yang bisa kamu sambungkan langsung ke Flutter **secara gratis** (sebelum meraup $10,000/bulan). Ini menjamin sistem serverless kamu aman dari pembajakan tanpa kamu perlu pusing mengurus infrastruktur.

---

## Langkah Eksekusi Selanjutnya (Jika Ingin Diterapkan)
1. **AdMob**: Mendaftar akun AdMob, membuat 3 jenis Ad Unit (Banner, Interstitial, Rewarded), dan mengganti Test ID yang ada di `app_constants.dart`.
2. **Google Play Console / App Store Connect**: Menambahkan produk In-App Purchase (`cryptiq_pro`) dan menentukan harganya.
3. **UI Toko (Store Screen)**: Membuat satu layar khusus "Store" untuk menjual Hint Packs dan menampilkan paket Pro.
