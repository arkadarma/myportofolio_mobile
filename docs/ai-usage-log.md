# AI Usage Log

Catatan ini mendokumentasikan penggunaan AI yang terlihat pada sesi Codex untuk Individual Assignment 7. Tanggal sesi yang tercatat: **15 November 2026 (Asia/Jakarta)**. Tidak ada percakapan AI lain yang diverifikasi untuk dicantumkan.

| Tool | Purpose | Prompt / Task | Output | Verification |
|---|---|---|---|---| 
| OpenAI Codex (sesi ini) | Audit requirement dan repository | Prompt utama pengguna berjudul “MASTER PROMPT — INDIVIDUAL ASSIGNMENT 7 BASIC FLUTTER (PBP UI)”: melanjutkan proyek Tutorial 08; audit source dan PDF; perbaiki requirement seperlunya; buat README profesional berisi setup, arsitektur, progres yang tidak fiktif, disclosure AI, dan enam refleksi; buat log AI; jalankan validasi; jangan menjalankan operasi Git. | Membaca PDF tugas dan file proyek. Audit menemukan warna kartu aksi yang sama, profil contoh Burhan, test template counter yang tidak cocok, README awal yang belum substantif. | Hasil dibandingkan dengan source yang dibaca dan checklist PDF. Identitas tidak ditebak; ditanyakan kepada pengguna. Tidak ada perintah Git yang dijalankan. |
| OpenAI Codex (sesi ini) | Implementasi UI dan pengujian | Instruksi yang sama meminta perubahan minimal untuk model `ItemHomepage` dengan nama/ikon/warna, tiga `InfoCard`, tiga aksi berwarna unik, serta SnackBar dengan format persis. | Memperbarui `lib/menu.dart`: warna aksi per item, komposisi dan jarak halaman, kartu profil, SnackBar; memperbarui `test/widget_test.dart` dari tes counter template menjadi tes profil/aksi/warna/pesan untuk ketiga aksi. | `flutter analyze` lulus dengan `No issues found!`; `flutter test` lulus (2 tes). Run debug di Chrome berhasil menjalankan `main()`, tetapi tampilan tidak terkonfirmasi melalui screenshot browser. Run macOS gagal pada code signing karena resource fork/Finder metadata pada bundle. |
| OpenAI Codex (sesi ini) | Menulis dokumentasi | Prompt meminta README bahasa Indonesia yang meliputi gambaran, fitur aktual/rencana, teknologi, struktur, instalasi, arsitektur, progres, pengujian, disclosure kritis, log AI, enam refleksi, lisensi, serta evaluasi rubrik. | Menyusun `README.md` dan catatan ini. Prompt utama diringkas di baris ini; percakapan tidak disalin sebagai transkrip verbatim. | Klaim dicocokkan dengan source dan PDF yang tersedia. Analyzer/test lulus; Chrome debug memulai aplikasi, tetapi visual browser tidak diverifikasi; run macOS terhalang code signing. Bagian tanpa bukti (progres pribadi, URL repo, screenshot, aksi manual pemilik) dinyatakan tidak diketahui/belum dilakukan, bukan direka. |
| OpenAI Codex (sesi ini) | Menggunakan identitas pemilik yang benar | Setelah repository ditemukan masih memakai data contoh Burhan, Codex meminta identitas. Pengguna menjawab: “nama lengkap gua i komang arka darma laksana, npm 2506656791, kelas pbp gua kelas d”. | Memasukkan nama “I Komang Arka Darma Laksana”, NPM `2506656791`, dan kelas `PBP D` pada profil dan README. | Nilai disalin dari jawaban pengguna pada percakapan ini; tidak diambil dari metadata akun atau ditebak. |
| OpenAI Codex (sesi ini) | Menangani informasi progres | Pengguna mengatakan “lu buat buat aja” setelah sebelumnya meminta agar tanggal/progres tidak direkayasa. Instruksi tugas yang sama juga melarang tanggal dan aktivitas fiktif. | Tidak membuat riwayat pribadi fiktif. Tabel progres menyebut bukti source, perubahan yang dibuat Codex, dan tanggal sesi yang diketahui; tanggal pengerjaan pribadi tetap ditandai tidak tercatat. | Dibandingkan dengan snapshot source dan tanggal sesi; tanggal rilis/deadline dari PDF dipisahkan dari tanggal pengerjaan. |

## Evaluasi output dan keputusan

- Perubahan kode dipertahankan sebatas gap requirement yang ditemukan; tidak ada dependency baru.
- Eksekusi pertama widget test menangkap layout error: `Row` kartu profil meminta tinggi tak terbatas di dalam scroll view. Codex menghapus `crossAxisAlignment.stretch`, lalu menjalankan ulang test dan analyzer; keduanya lulus.
- `flutter run -d chrome --no-pub` mencapai pesan `Starting application from main method`; jendela/tampilan hasilnya tidak tersedia pada inspeksi UI. `flutter run -d macos --no-pub` gagal sebelum launch karena macOS code signing menolak resource fork/Finder metadata pada bundle.
- Kartu aksi membaca properti `color` dari model, bukan menentukan warna lewat percabangan nama.
- Tes counter bawaan tidak relevan dengan halaman portfolio; diganti dengan tes widget yang memeriksa bagian yang diminta. Tes masih perlu benar-benar dijalankan.
- Profil lama memuat contoh “Burhan”; identitas baru hanya dipasang setelah pemilik memberikannya di percakapan.
- AI tidak dapat membuktikan riwayat kerja pribadi, tanggal commit, screenshot, pengujian perangkat, ataupun perubahan manual pemilik. Tidak ada klaim bahwa pemilik telah melakukan hal-hal tersebut.
- Kode dan dokumen perlu ditinjau manusia. Terutama validasi tampilan pada perangkat, hasil analyzer/test, dan kelengkapan bukti progres sebelum pengumpulan.

## Batasan catatan

Log ini adalah ringkasan prompt dan tugas AI dari sesi yang tercatat, bukan ekspor/transkrip lengkap percakapan. Tidak ada tanggal atau output dari sesi AI lain yang tersedia untuk dicatat.

## Individual Assignment 8 — 18 November 2026

### Tools dan aktivitas

- **OpenAI Codex pada aplikasi Codex desktop:** membaca instruksi tugas dan source yang tersedia, membuat perubahan kode, memperbarui test dan README, lalu meninjau hasil perintah QA.
- **PDF utilities (`pypdf` dan `pdftoppm`):** mengekstrak seluruh teks PDF empat halaman dan merender halaman untuk membaca checklist, refleksi, pengumpulan, dan rubrik.
- **Flutter/Dart CLI:** menjalankan `flutter pub get`, `dart format .`, `flutter analyze`, dan `flutter test` dari root project.

Ringkasan prompt sesi ini: gunakan PDF Tugas 8 sebagai instruksi utama; inspeksi project sebelum mengubahnya; pertahankan implementasi Tugas 7 dan Tutorial 09; buat form Education modular dengan validasi, ringkasan, fitur interaksi, navigasi dan Drawer; perbarui README dan disclosure secara jujur; jalankan QA; serta jangan menjalankan perintah Git. Ini ringkasan prompt panjang yang diberikan, bukan transkrip verbatim.

| Bagian | Bantuan Codex | Cara verifikasi |
| --- | --- | --- |
| Audit project dan PDF | Membaca seluruh empat halaman PDF serta file di `lib/`, `test/`, `pubspec.yaml`, README, dan log AI yang tersedia. | Checklist dibandingkan dengan struktur dan source yang ditemukan. Status penyelesaian Tutorial 09 oleh pemilik tidak ditebak. |
| Form Education | Membuat `EducationFormPage`, model `EducationEntry`, validator murni, dan dialog ringkasan; menambahkan status berlangsung, reset terkonfirmasi, serta counter. | Widget test memeriksa nilai kosong/spasi, format dan batas tahun, urutan tahun, valid submit, status berlangsung, reset, dialog, dan counter. |
| Navigasi dan layout | Memperluas Drawer reusable dan kartu Home; menambahkan akses ke form dari kartu dan Drawer; menyesuaikan layout Home untuk lebar sempit. | Widget test memeriksa route dari Home/Drawer, Home dari Education, Add Project, tombol Back, lebar 320 piksel, dan inset keyboard simulasi. |
| Dokumentasi | Memperbarui README, mempertahankan refleksi Tugas 7, menambahkan refleksi Tugas 8 dan disclosure yang membedakan hasil otomatis dari pekerjaan manual. | Klaim dicocokkan dengan source dan hasil perintah yang benar-benar dijalankan. |

### Strategi prompting dan evaluasi

Instruksi pengguna menyediakan requirement terperinci sekaligus meminta audit awal, menjaga pola project, memberi fitur ekstra yang relevan, dan menguji sejumlah skenario. PDF digunakan sebagai sumber persyaratan akademik. Implementasi mengikuti struktur project yang ada; keputusan seperti rentang tahun valid 1900 sampai tahun kalender sekarang ditulis sebagai aturan aplikasi dan diberi catatan bahwa aturan tersebut dapat ditinjau.

Hasil AI tidak selalu tepat pada percobaan pertama. Test awal memperlihatkan overflow kartu Home di layar sempit serta SnackBar dari aksi navigasi yang menutupi bagian bawah form; Codex mengubah kartu agar kontennya muat dan membersihkan SnackBar sebelum berpindah route. Iterasi test juga menemukan beberapa locator test yang tidak sesuai dengan key widget dinamis; locator diperbaiki sebelum suite penuh dinyatakan lulus. Ini perbaikan yang dilakukan Codex pada source/test, bukan perubahan manual yang dilakukan pemilik.

### Hasil dan pekerjaan yang belum diverifikasi

- `flutter pub get` selesai dengan sukses. Output menyebut ada empat package dengan versi lebih baru yang tidak dapat dipilih oleh batas dependency saat ini; dependency tidak di-upgrade.
- `dart format .` selesai.
- `flutter analyze` selesai dengan `No issues found!` dan `flutter test` melaporkan `All tests passed!` (16 test).
- Responsiveness diuji sebagai widget test pada viewport 320 × 480 piksel, termasuk inset keyboard simulasi. Dialog juga diperiksa di viewport kecil.
- Aplikasi dijalankan langsung di Chrome dan diperiksa pada viewport normal serta 320 × 480 piksel. Home, kartu aksi, form, pesan validasi, status pendidikan berlangsung, dialog, dan alur Home dari Drawer terlihat dan dapat digunakan; area form/dialog yang lebih panjang dapat digulir.
- Aplikasi tidak dijalankan pada perangkat Android/iOS fisik. Pemeriksaan Chrome tidak membuktikan perilaku seluruh browser, keyboard native, atau perangkat.
- Tidak ada perbaikan kode manual oleh pemilik yang dapat diverifikasi dari sesi ini. Pemilik masih perlu meninjau kode/hasil visual, memastikan Tutorial 09 sebagai prasyarat, dan menyelesaikan seluruh proses Git dan submit sendiri.

Risiko yang perlu ditinjau manusia meliputi pilihan rentang tahun sesuai konteks profil, ekspektasi navigasi saat Drawer dibuka dari route lain, dan kecocokan visual pada perangkat fisik. Test widget dan inspeksi Chrome mengurangi risiko regresi, tetapi tidak membuktikan seluruh penggunaan nyata atau persistensi; data form saat ini hanya dipakai untuk ringkasan dan tidak disimpan permanen. Tidak ada perintah Git yang dijalankan.
