
# MyPortfolio Mobile

MyPortfolio Mobile adalah aplikasi portofolio pribadi sederhana yang dibuat menggunakan Flutter. Aplikasi ini menampilkan informasi pemilik serta tiga tombol aksi, yaitu Lihat Portofolio, Tambah Proyek, dan Logout.

Proyek ini dibuat untuk memenuhi Individual Assignment 7 mata kuliah Pemrograman Berbasis Platform (PBP) Universitas Indonesia.

**Informasi Pemilik**
- Nama: I Komang Arka Darma Laksana
- NPM: 2506656791
- Kelas: PBP D

## Fitur

Beberapa fitur yang tersedia dalam aplikasi ini:

- Menampilkan informasi NPM, nama, dan kelas menggunakan InfoCard.
- Menampilkan tiga tombol aksi menggunakan ItemCard.
- Setiap tombol memiliki ikon dan warna yang berbeda.
- Menampilkan SnackBar sesuai tombol yang ditekan.
- Menggunakan layout yang dapat digulir.

Saat ini, tombol aksi masih berupa interaksi sederhana. Fitur daftar proyek, penambahan proyek, dan autentikasi belum diimplementasikan.

## Teknologi

Proyek ini menggunakan Flutter sebagai framework dan Dart sebagai bahasa pemrograman. Selain itu, terdapat beberapa dependency pendukung seperti flutter_test untuk pengujian widget dan flutter_lints untuk membantu menjaga kualitas kode.

## Struktur Proyek

```text
myportofolio_mobile/
├── lib/
│   ├── main.dart
│   └── menu.dart
├── test/
│   └── widget_test.dart
├── docs/
│   └── ai-usage-log.md
├── pubspec.yaml
└── README.md
```

`main.dart` digunakan sebagai titik masuk aplikasi, sedangkan `menu.dart` berisi halaman utama, model data, dan komponen antarmuka. Folder `test` berisi pengujian aplikasi dan folder `docs` menyimpan dokumentasi penggunaan AI.

## Instalasi dan Menjalankan Aplikasi

Pastikan Flutter SDK sudah terpasang dan emulator atau perangkat sudah siap digunakan.

Clone repository:

```bash
git clone <repository-url>
cd myportofolio_mobile
```

Instal dependency:

```bash
flutter pub get
```

Jalankan aplikasi:

```bash
flutter run
```

Untuk memeriksa kode dan menjalankan pengujian:

```bash
flutter analyze
flutter test
```

## Cara Kerja Aplikasi

Aplikasi dimulai dari fungsi `main()` pada `main.dart`, kemudian menjalankan `MyApp` yang menggunakan `MaterialApp`. Halaman utama ditampilkan melalui `MyHomePage`.

Di dalam halaman tersebut, `Scaffold` menjadi kerangka utama. Konten disusun menggunakan `Column`, `Row`, dan `GridView`. Komponen `InfoCard` digunakan untuk menampilkan informasi profil, sedangkan `ItemCard` digunakan untuk menampilkan tombol aksi.

Setiap tombol menggunakan model `ItemHomepage` yang menyimpan nama, ikon, dan warna. Ketika tombol ditekan, `InkWell` menjalankan callback yang menampilkan SnackBar melalui `ScaffoldMessenger`.

## Progres Pengerjaan

Proyek ini dikembangkan dengan melanjutkan struktur aplikasi Flutter dari Tutorial 08. Struktur tersebut kemudian disesuaikan untuk memenuhi kebutuhan Individual Assignment 7.

Pada tahap pengembangan, informasi profil disesuaikan dengan identitas pemilik aplikasi. Tiga tombol aksi juga dibuat dengan ikon dan warna berbeda serta dilengkapi SnackBar.

Pengujian bawaan yang sebelumnya menggunakan contoh counter kemudian diganti dengan pengujian yang sesuai dengan aplikasi portofolio.

Pada tahap akhir, README dan dokumentasi penggunaan AI ditambahkan. Penyempurnaan pada sesi 15 November 2026 dilakukan dengan bantuan Codex. Tanggal tersebut merupakan tanggal sesi finalisasi, bukan tanggal seluruh proses pengerjaan.

## Pengujian

Pemeriksaan kode dilakukan menggunakan `flutter analyze` dan menghasilkan `No issues found!`.

Pengujian menggunakan `flutter test` juga berhasil dengan dua widget test lulus. Pengujian mencakup informasi profil, warna kartu, dan interaksi tombol.

Aplikasi sudah dicoba dijalankan pada  Chrome, tetapi tampilannya sudah seuai secara visual. 



## Penggunaan AI

Dalam pengerjaan tugas ini, saya menggunakan ChatGPT dan OpenAI Codex sebagai alat bantu.

ChatGPT membantu memahami requirement tugas, menyusun instruksi, dan meninjau dokumentasi. Sementara itu, Codex digunakan untuk memeriksa struktur proyek, membantu implementasi kode, memperbarui pengujian, dan menyusun README.

Penggunaan AI dilakukan dengan memberikan konteks repository dan requirement tugas agar hasil yang diberikan sesuai dengan kebutuhan proyek.

Namun, hasil AI tidak selalu langsung benar. AI dapat menghasilkan kode yang kurang sesuai dengan struktur proyek, melewatkan requirement, atau memberikan solusi yang belum teruji.

Salah satu contohnya adalah masalah layout yang ditemukan saat pengujian awal. Setelah diperbaiki, analyzer dan pengujian dijalankan kembali hingga berhasil.

Oleh karena itu, hasil AI tetap perlu diperiksa melalui source code dan pengujian. Pemeriksaan visual secara langsung juga masih perlu dilakukan sebelum pengumpulan.



## Pertanyaan Reflektif Tugas 7

### 1. Apa yang dimaksud dengan widget tree dan bagaimana hubungan parent-child bekerja?

Widget tree adalah struktur hierarki yang menggambarkan susunan widget dalam aplikasi Flutter. Parent merupakan widget yang menampung child, sedangkan child merupakan widget yang berada di dalam parent.

Dalam proyek ini, `MaterialApp` menampilkan `MyHomePage`, yang kemudian menggunakan `Scaffold` untuk menyusun halaman. Di dalamnya terdapat `Column`, `Row`, dan `GridView` untuk mengatur posisi komponen.

Hubungan parent-child membantu Flutter menentukan posisi, ukuran, dan susunan setiap elemen pada layar.

### 2. Sebutkan widget yang digunakan dan jelaskan fungsinya!

Beberapa widget yang digunakan dalam proyek ini antara lain:

- `MaterialApp`: mengatur konfigurasi dasar aplikasi.
- `Scaffold`: menyediakan struktur utama halaman.
- `AppBar`: menampilkan bagian atas halaman.
- `SingleChildScrollView`: memungkinkan halaman digulir.
- `Column`: menyusun widget secara vertikal.
- `Row`: menyusun widget secara horizontal.
- `Expanded`: membagi ruang yang tersedia.
- `GridView`: menyusun tombol aksi dalam bentuk grid.
- `Padding` dan `SizedBox`: mengatur jarak antarwidget.
- `Card`: menyediakan tampilan kartu.
- `Text`: menampilkan tulisan.
- `Icon`: menampilkan ikon.
- `Material`: menyediakan latar kartu.
- `InkWell`: menangani interaksi ketika kartu ditekan.
- `SnackBar`: menampilkan pesan sementara.

Selain widget bawaan, terdapat `InfoCard` dan `ItemCard` sebagai custom widget untuk menampilkan informasi profil dan tombol aksi. `ItemHomepage` merupakan model data yang menyimpan nama, ikon, dan warna tombol.

### 3. Apa fungsi MaterialApp dan mengapa digunakan sebagai root widget?

`MaterialApp` menyediakan konfigurasi dasar aplikasi dengan Material Design. Widget ini dapat mengatur tema, halaman awal, dan navigasi aplikasi.

Dalam proyek ini, `MaterialApp` digunakan di dalam `MyApp` untuk mengatur tema dan menampilkan `MyHomePage` sebagai halaman utama. Dengan demikian, widget di bawahnya dapat menggunakan konfigurasi Material yang sudah disediakan.

### 4. Apa perbedaan StatelessWidget dan StatefulWidget?

`StatelessWidget` digunakan untuk widget yang tidak memiliki state lokal yang berubah selama penggunaannya. Sementara itu, `StatefulWidget` digunakan ketika sebuah widget perlu menyimpan dan mengelola data yang dapat berubah.

Pada `StatefulWidget`, perubahan state dapat ditampilkan melalui `setState()`, yang meminta Flutter membangun ulang bagian UI terkait.

Dalam proyek ini, `MyHomePage` menggunakan `StatelessWidget` karena informasi dan susunan halaman berasal dari data yang sudah ditentukan. Interaksi tombol tetap dapat dilakukan menggunakan callback tanpa harus membuat halaman utama menjadi StatefulWidget.

### 5. Apa itu BuildContext dan mengapa penting?

`BuildContext` merupakan referensi terhadap posisi sebuah widget dalam widget tree. Context memungkinkan widget mengakses informasi atau layanan yang disediakan oleh widget di atasnya.

Dalam proyek ini, `Theme.of(context)` digunakan untuk mengambil informasi tema aplikasi. Sementara itu, `ScaffoldMessenger.of(context)` digunakan untuk mengakses layanan yang menampilkan SnackBar.

Posisi BuildContext penting agar widget dapat menemukan ancestor yang menyediakan layanan tersebut.

### 6. Apa perbedaan hot reload dan hot restart?

Hot reload memungkinkan perubahan kode Dart diterapkan tanpa menjalankan ulang seluruh aplikasi. State yang sedang digunakan umumnya tetap dipertahankan sehingga fitur ini cocok untuk melihat perubahan tampilan dengan cepat.

Hot restart menjalankan ulang aplikasi Dart dari awal sehingga state sementara akan direset. Fitur ini berguna ketika perubahan kode membutuhkan proses inisialisasi ulang.

Full restart dilakukan dengan menghentikan dan menjalankan kembali aplikasi. Biasanya diperlukan ketika terdapat perubahan konfigurasi platform, kode native, atau plugin yang tidak dapat diperbarui melalui hot reload.

Contohnya, perubahan warna kartu biasanya cukup diuji menggunakan hot reload. Namun, perubahan konfigurasi native Android atau iOS memerlukan proses build dan restart ulang.

## Rencana Pengembangan

Ke depannya, aplikasi dapat dikembangkan dengan menambahkan halaman daftar proyek, fitur tambah dan edit proyek, penyimpanan data, serta integrasi backend.

Navigasi antarhalaman dan autentikasi juga dapat ditambahkan agar setiap tombol mempunyai fungsi yang lebih lengkap.

Fitur-fitur tersebut masih berupa rencana dan belum tersedia dalam implementasi saat ini.

## Lisensi

Proyek ini dibuat untuk keperluan akademik mata kuliah Pemrograman Berbasis Platform di Fakultas Ilmu Komputer, Universitas Indonesia.

Lisensi proyek belum ditentukan.
