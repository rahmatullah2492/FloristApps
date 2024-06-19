import 'dart:convert';

class DetailPesanan {
  int? tanamanId;
  String? namaTanaman;
  int? quantity;
  int? subHarga;

  DetailPesanan({
    this.tanamanId,
    this.namaTanaman,
    this.quantity,
    this.subHarga,
  });

  factory DetailPesanan.fromMap(Map<String, dynamic> data) => DetailPesanan(
        tanamanId: data['tanaman_id'] as int?,
        namaTanaman: data['nama_tanaman'] as String?,
        quantity: data['quantity'] as int?,
        subHarga: data['sub_harga'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'tanaman_id': tanamanId,
        'nama_tanaman': namaTanaman,
        'quantity': quantity,
        'sub_harga': subHarga,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DetailPesanan].
  factory DetailPesanan.fromJson(String data) {
    return DetailPesanan.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DetailPesanan] to a JSON string.
  String toJson() => json.encode(toMap());
}
