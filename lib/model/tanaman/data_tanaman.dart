// Perbaikan pada model DataTanaman
class DataTanaman {
  int? id;
  String? namaTanaman;
  String? imageTanaman;
  String? kategoriTanaman;
  String? deskripsiTanaman;
  int? sizeTanaman;
  int? suhuTanaman;
  int? kelembapanTanaman;
  int? hargaTanaman;
  int? stokTanaman;

  DataTanaman({
    this.id,
    this.namaTanaman,
    this.imageTanaman,
    this.kategoriTanaman,
    this.deskripsiTanaman,
    this.sizeTanaman,
    this.suhuTanaman,
    this.kelembapanTanaman,
    this.hargaTanaman,
    this.stokTanaman,
  });

  // Tambahkan factory method fromJson untuk mengonversi JSON menjadi objek DataTanaman
  factory DataTanaman.fromJson(Map<String, dynamic> json) {
    return DataTanaman(
      id: json['id'],
      namaTanaman: json['nama_tanaman'],
      imageTanaman: json['image_tanaman'],
      kategoriTanaman: json['kategori_tanaman'],
      deskripsiTanaman: json['deskripsi_tanaman'],
      sizeTanaman: json['size_tanaman'],
      suhuTanaman: json['suhu_tanaman'],
      kelembapanTanaman: json['kelembapan_tanaman'],
      hargaTanaman: json['harga_tanaman'],
      stokTanaman: json['stok_tanaman'],
    );
  }
}
