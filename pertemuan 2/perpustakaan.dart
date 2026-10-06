// =============================================
// Perpustakaan
// Nama : Muhamad Ubaydilah
// NIM  : 1124160011
// =============================================

// ---------- ABSTRACTION ----------

enum BukuStatus {
  tersedia,
  sedangDipinjam,
}

enum PinjamStatus {
  success,
  maxBook,
  bookNotAvailable,
}

class Buku {
  final String judul;
  final String penulis;
  BukuStatus status;

  Buku(this.judul, this.penulis, this.status);
}

class Peminjaman {
  final String namaPeminjam;
  final Buku buku;
  final int hariTerlambat;

  Peminjaman(
    this.namaPeminjam,
    this.buku,
    this.hariTerlambat,
  );
}

// ---------- DATA ----------

const int maksimalBuku = 3;
const double dendaPerHari = 1000;

final List<Peminjaman> peminjaman = [];

// ---------- DECOMPOSITION ----------

// BR-01 : Maksimal peminjaman adalah 3 buku
bool isMaxBookReached(String namaPeminjam) {
  int jumlahBuku = 0;

  for (final pinjam in peminjaman) {
    if (pinjam.namaPeminjam == namaPeminjam) {
      jumlahBuku++;
    }
  }

  return jumlahBuku >= maksimalBuku;
}

// BR-02 : Buku yang sedang dipinjam tidak dapat dipinjam kembali
bool isBookAvailable(Buku buku) {
  return buku.status == BukuStatus.tersedia;
}

// BR-03 : Denda Rp1.000 per hari keterlambatan
double hitungDenda(int hariTerlambat) {
  return hariTerlambat * dendaPerHari;
}

// ---------- ALGORITHM ----------

PinjamStatus prosesPeminjaman(
  String namaPeminjam,
  Buku buku,
  int hariTerlambat,
) {
  // Validasi maksimal buku
  if (isMaxBookReached(namaPeminjam)) {
    print('Nama Peminjam : $namaPeminjam');
    print('Judul Buku    : ${buku.judul}');
    print('Status        : Maksimal peminjaman adalah 3 buku');

    return PinjamStatus.maxBook;
  }

  // Validasi ketersediaan buku
  if (!isBookAvailable(buku)) {
    print('Nama Peminjam : $namaPeminjam');
    print('Judul Buku    : ${buku.judul}');
    print('Status        : Buku sedang dipinjam');

    return PinjamStatus.bookNotAvailable;
  }

  // Mengubah status buku
  buku.status = BukuStatus.sedangDipinjam;

  // Menghitung denda
  final denda = hitungDenda(hariTerlambat);

  // Menyimpan data peminjaman
  peminjaman.add(
    Peminjaman(
      namaPeminjam,
      buku,
      hariTerlambat,
    ),
  );

  print('Nama Peminjam : $namaPeminjam');
  print('Judul Buku    : ${buku.judul}');
  print('Penulis       : ${buku.penulis}');

  if (hariTerlambat > 0) {
    print('Keterlambatan : $hariTerlambat hari');
    print('Denda         : Rp${denda.toStringAsFixed(0)}');
  } else {
    print('Keterlambatan : Tidak ada');
    print('Denda         : Rp0');
  }

  print('Status        : Peminjaman berhasil');

  return PinjamStatus.success;
}

// ---------- STATUS MESSAGE ----------

String toMessage(PinjamStatus status) {
  switch (status) {
    case PinjamStatus.success:
      return 'Peminjaman Berhasil';

    case PinjamStatus.maxBook:
      return 'Maksimal Peminjaman 3 Buku';

    case PinjamStatus.bookNotAvailable:
      return 'Buku Sedang Dipinjam';
  }
}

// ---------- TEST SCENARIO ----------

void main() {
  // ===========================================
  // DATA BUKU
  // ===========================================

  final buku1 = Buku(
    'Pemrograman Dart',
    'John Doe',
    BukuStatus.tersedia,
  );

  final buku2 = Buku(
    'Dasar-Dasar Flutter',
    'Jane Doe',
    BukuStatus.tersedia,
  );

  final buku3 = Buku(
    'Algoritma dan Pemrograman',
    'Andi',
    BukuStatus.tersedia,
  );

  final buku4 = Buku(
    'Basis Data',
    'Budi',
    BukuStatus.tersedia,
  );

  final buku5 = Buku(
    'Sistem Informasi',
    'Citra',
    BukuStatus.tersedia,
  );

  // ===========================================
  // SKENARIO 1
  // Peminjaman normal
  // ===========================================

  print('=== Skenario 1 (Peminjaman Normal) ===');

  final status1 = prosesPeminjaman(
    'Nia',
    buku1,
    0,
  );

  print(toMessage(status1));
  print('');

  // ===========================================
  // SKENARIO 2 - BR-03
  // Terlambat 3 hari
  // 3 x Rp1.000 = Rp3.000
  // ===========================================

  print('=== Skenario 2 (Denda - BR-03) ===');

  final status2 = prosesPeminjaman(
    'Nisa',
    buku2,
    3,
  );

  print(toMessage(status2));
  print('');

  // ===========================================
  // SKENARIO 3 - BR-01
  // Peminjaman buku 1, 2, dan 3
  // ===========================================

  print('=== Skenario 3 (Maksimal 3 Buku - BR-01) ===');

  prosesPeminjaman(
    'Nina',
    buku3,
    0,
  );

  prosesPeminjaman(
    'Nina',
    buku4,
    0,
  );

  prosesPeminjaman(
    'Nina',
    buku5,
    0,
  );

  print('');

  // ===========================================
  // SKENARIO 4 - BR-01
  // Mencoba meminjam buku ke-4
  // ===========================================

  final buku6 = Buku(
    'Pemrograman Web',
    'Doni',
    BukuStatus.tersedia,
  );

  print('=== Skenario 4 (Melebihi Maksimal - BR-01) ===');

  final status4 = prosesPeminjaman(
    'Nina',
    buku6,
    0,
  );

  print(toMessage(status4));
  print('');

  // ===========================================
  // SKENARIO 5 - BR-02
  // Buku yang sedang dipinjam
  // tidak bisa dipinjam kembali
  // ===========================================

  print('=== Skenario 5 (Buku Sedang Dipinjam - BR-02) ===');

  final status5 = prosesPeminjaman(
    'Nani',
    buku1,
    0,
  );

  print(toMessage(status5));
  print('');

  // ===========================================
  // DATA PEMINJAMAN
  // ===========================================

  print('=== Data Peminjaman Berhasil ===');

  for (final pinjam in peminjaman) {
    final denda = hitungDenda(pinjam.hariTerlambat);

    print(
      'Nama: ${pinjam.namaPeminjam}, '
      'Buku: ${pinjam.buku.judul}, '
      'Keterlambatan: ${pinjam.hariTerlambat} hari, '
      'Denda: Rp${denda.toStringAsFixed(0)}',
    );
  }

  print('Total Peminjaman Berhasil: ${peminjaman.length}');
}
