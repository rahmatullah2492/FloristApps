import 'dart:convert';

class DetailPesanan {
  String? namaTanaman;
  int? tanamanId;
  int? quantity;
  int? subHarga;

  DetailPesanan({
    this.namaTanaman,
    this.tanamanId,
    this.quantity,
    this.subHarga,
  });

  factory DetailPesanan.fromMap(Map<String, dynamic> data) => DetailPesanan(
        namaTanaman: data['nama_tanaman'] as String?,
        tanamanId: data['tanaman_id'] as int?,
        quantity: data['quantity'] as int?,
        subHarga: data['sub_harga'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'nama_tanaman': namaTanaman,
        'tanaman_id': tanamanId,
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
