# Traceability Perpustakaan

| No | Use Case | Business Rule | Source Code | Test Scenario |
|---|---|---|---|---|
| 1 | Meminjam Buku | BR-01 Maksimal peminjaman 3 buku | `isMaxBookReached()` | Skenario 3 dan 4 |
| 2 | Meminjam Buku | BR-02 Buku yang sedang dipinjam tidak dapat dipinjam kembali | `isBookAvailable()` | Skenario 5 |
| 3 | Mengembalikan Buku | BR-03 Denda Rp1.000 per hari keterlambatan | `hitungDenda()` | Skenario 2 |
