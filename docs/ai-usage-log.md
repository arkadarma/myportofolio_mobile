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
