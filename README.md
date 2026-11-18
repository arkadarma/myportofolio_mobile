
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

## Struktur Proyek tugas 7

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

Aplikasi sudah dicoba dijalankan pada  Chrome dan tampilannya sudah seuai secara visual. 



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




---

# Tugas 8 — Formulir Education dan Navigasi

Pada Tugas 8, saya menambahkan halaman formulir Education ke aplikasi portofolio. Formulir ini digunakan untuk mengisi informasi pendidikan dan menampilkan ringkasan setelah semua input berhasil divalidasi.

## Fitur yang Dibuat

- Membuat halaman Education Form menggunakan `StatefulWidget`.
- Menambahkan input nama institusi, jenjang, jurusan, tahun masuk, dan tahun lulus.
- Menambahkan validasi pada setiap input.
- Menambahkan pilihan status pendidikan masih berlangsung.
- Menambahkan penghitung karakter deskripsi maksimal 400 karakter.
- Menambahkan tombol Reset dengan konfirmasi.
- Menampilkan ringkasan data menggunakan `AlertDialog`.
- Menambahkan kartu Education pada halaman Home.
- Menambahkan menu Add Education pada Drawer.
- Menggunakan Drawer yang sama pada halaman terkait.

Data pendidikan saat ini hanya ditampilkan melalui dialog dan belum disimpan secara permanen.

## Cara Menggunakan Education Form

1. Buka formulir melalui kartu Tambah Pendidikan pada Home atau menu Add Education pada Drawer.
2. Isi informasi pendidikan yang diminta.
3. Aktifkan pilihan pendidikan masih berlangsung apabila belum lulus.
4. Isi tahun lulus apabila pendidikan sudah selesai.
5. Tekan Simpan untuk melihat ringkasan data.
6. Gunakan Reset untuk mengosongkan formulir setelah konfirmasi.

## Pertanyaan Reflektif Tugas 8

**1. Apa perbedaan Navigator.push(), Navigator.pushReplacement(), dan Navigator.pop()?**

`Navigator.push()` digunakan untuk membuka halaman baru tanpa menghapus halaman sebelumnya. `Navigator.pushReplacement()` membuka halaman baru sekaligus menggantikan halaman yang sedang aktif. Sementara itu, `Navigator.pop()` digunakan untuk menutup halaman atau dialog yang sedang terbuka.

Pada project ini, kartu Education menggunakan `Navigator.push()` untuk membuka formulir. Menu Home pada Drawer menggunakan `Navigator.pushAndRemoveUntil()` agar pengguna dapat kembali ke halaman utama tanpa menumpuk halaman sebelumnya.

**2. Bagaimana Scaffold, AppBar, dan Drawer membantu menjaga konsistensi halaman?**

`Scaffold` digunakan sebagai kerangka utama halaman, `AppBar` menampilkan bagian atas halaman, dan `Drawer` menyediakan menu navigasi. Project menggunakan komponen `LeftDrawer` yang sama pada halaman Home dan formulir. Warna indigo dari tema aplikasi juga digunakan pada beberapa halaman agar tampilannya tetap konsisten.

**3. Mengapa tata letak tersebut dipilih untuk formulir?**

Formulir menggunakan `SingleChildScrollView` agar pengguna tetap dapat mengakses seluruh input dan tombol ketika layar terbatas atau keyboard muncul.

`SafeArea` menjaga konten dari area sistem, `Padding` memberikan jarak dari tepi layar, dan `SizedBox` mengatur jarak antarinput. Dengan susunan ini, formulir lebih nyaman digunakan pada berbagai ukuran layar.

**4. Apa peran GlobalKey\<FormState>, validator, dan validate()?**

`GlobalKey<FormState>` digunakan untuk mengakses state dari widget `Form`. Setiap `validator` memeriksa nilai input dan memberikan pesan kesalahan apabila data tidak sesuai aturan.

Ketika tombol Simpan ditekan, `validate()` menjalankan seluruh validator. Contohnya, tahun masuk yang lebih besar daripada tahun lulus akan ditolak.

Keyboard numerik saja tidak cukup karena tidak memastikan angka yang dimasukkan memiliki format dan rentang yang benar. Oleh karena itu, validasi tetap diperlukan.

## Pengujian Tugas 8

Pemeriksaan :

- `flutter pub get` berhasil.
- `dart format .` berhasil.
- `flutter analyze` menghasilkan `No issues found!`.
- Seluruh 16 test berhasil dijalankan.
- Aplikasi diperiksa melalui Chrome pada ukuran normal dan 320 × 480 piksel.
- Pengujian widget mencakup validasi, navigasi, dialog, reset, dan tampilan layar kecil.


Untuk menjalankan pemeriksaan kembali:

```bash
dart format .
flutter analyze
flutter test
```

## Penggunaan AI dan Pemeriksaan Mandiri

Dalam pengerjaan Tugas 8, saya menggunakan Codex sebagai alat bantu untuk memahami instruksi tugas, memeriksa struktur project, mengembangkan formulir Education, menambahkan validasi dan navigasi, serta membantu membuat pengujian.

Hasil dari AI tetap perlu diperiksa karena AI dapat melakukan kesalahan dalam memahami struktur project atau aturan validasi. Selama proses pengerjaan, ditemukan masalah tampilan pada layar kecil dan posisi notifikasi yang menutupi bagian formulir. Perubahan untuk memperbaiki masalah tersebut dilakukan selama proses pengembangan dengan bantuan Codex.

Hal yang masih perlu saya periksa sendiri:

- [ ] Mencoba input kosong dan input yang hanya berisi spasi.
- [ ] Memeriksa validasi tahun masuk dan tahun lulus.
- [ ] Mencoba status pendidikan masih berlangsung.
- [ ] Mencoba tombol Reset dan konfirmasinya.
- [ ] Memastikan dialog menampilkan data yang benar.
- [ ] Mencoba navigasi dari Home dan Drawer.
- [ ] Memeriksa tampilan pada layar kecil atau perangkat fisik.
- [ ] Membaca kembali kode agar memahami alur program.

### Catatan Perbaikan Manual

- **Bagian yang diperiksa:** education_form.dart dan education_form_validators.dart.
- **Perubahan yang dilakukan:** Saya memeriksa kembali proses validasi formulir, terutama input kosong, spasi yang tidak diperlukan, dan urutan tahun masuk serta tahun lulus. Saya juga memastikan data dibersihkan sebelum ditampilkan pada ringkasan.
- **Alasan:** Agar data yang dimasukkan lebih konsisten dan kesalahan input dapat dicegah sebelum ditampilkan.

Setelah melakukan pemeriksaan, saya memastikan validasi berjalan sesuai aturan yang digunakan pada formulir Education.

## Rencana Pengembangan

Beberapa fitur yang masih dapat dikembangkan adalah penyimpanan data pendidikan, halaman daftar proyek, fitur edit proyek, dan autentikasi pengguna. Saat ini, data Education belum disimpan secara permanen.
