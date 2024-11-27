# 🚀 #JagaPilkada2024: Analisis Data Hasil Suara [Open Source] 🚀

## Latar Belakang Proyek
Inisiatif `#JagaPilkada2024` bertujuan untuk menganalisis data pemilu sirekap pilkada dengan menyajikan gambaran yang lebih jelas tentang hasil pemilu. Dengan membuat proyek ini open source, kami mendorong individu untuk menerapkan dan menganalisis data di perangkat mereka sendiri, mendukung transparansi dan pengawasan kolektif dalam proses demokrasi.

## Alat yang Digunakan
- **Benthos** (https://www.benthos.dev/): Untuk pemrosesan stream dan manipulasi data.
- **ClickHouse** (https://clickhouse.com/): Sebagai database analitik untuk menyimpan dan menanyakan data pemilu dengan efisien.
- **Superset** (https://superset.apache.org/): Untuk visualisasi dan penyaringan data.


## Pernyataan Tanggung Jawab

Kami, tim pengembang proyek #JagaPilkada2024, menyediakan alat ini dengan tujuan baik untuk mendukung transparansi dan keadilan dalam pemilihan umum. Namun, kami ingin menegaskan bahwa:

- Proses crawling atau pengambilan data dari situs KPU dilakukan dengan asumsi bahwa pengguna telah memahami dan menerima segala risiko yang terkait, termasuk potensi beban tambahan pada server KPU.
- Kami mendorong penggunaan proyek ini secara bertanggung jawab dan dengan mempertimbangkan etika pengambilan data publik. Kami merekomendasikan pengguna untuk membatasi frekuensi permintaan mereka untuk menghindari dampak negatif pada kinerja situs KPU.
- Segala macam dampak yang timbul dari penggunaan proyek ini, termasuk namun tidak terbatas pada beban berlebih pada infrastruktur KPU atau konsekuensi hukum dari pengambilan data, adalah di luar tanggung jawab tim pengembang.
- Kami tidak bertanggung jawab atas penggunaan alat ini dalam cara yang melanggar kebijakan, hukum, atau regulasi yang berlaku terkait dengan data dan akses internet.

Kami berharap proyek ini digunakan sebagai sarana untuk meningkatkan kesadaran dan partisipasi dalam proses demokrasi, dengan menghormati batasan dan ketentuan yang ditetapkan oleh sumber data.

Dengan menggunakan proyek ini, Anda, sebagai pengguna, menyetujui bahwa Anda memahami dan menerima kondisi yang telah disebutkan di atas.


## Mencoba menjalankan sendiri

Langkah 1: Persiapan
- Pastikan anda memiliki Docker yang terinstall.
- Pastikan anda memiliki benthos yang terinstall. `brew install benthos`


### Membangun Gambar Docker Superset
Untuk membangun gambar Docker Superset, jalankan:

```bash
make build-superset-image
```

### Menjalankan Aplikasi

Untuk memulai aplikasi, jalankan perintah berikut:

```bash
make start-containers
```

### Crawling Data Hasil Pilkada

```
make ambil-hasil
```

### Berhentikan Aplikasi

Untuk mengakhiri aplikasi, jalankan perintah berikut:

```bash
make stop-containers
```

## Bergabung dan Kontribusi
Kami mengundang siapa saja untuk bergabung dalam inisiatif ini dan bersama-sama mengawal proses pemilu di Indonesia. Mari bergabung dalam upaya kami untuk mendukung demokrasi Indonesia yang lebih baik!
