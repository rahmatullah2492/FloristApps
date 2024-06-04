import 'dart:convert';

class DataDetailPesanan {
  int? id;
  String? namaTanaman;
  int? tanamanId;
  int? quantity;
  int? subHarga;

  DataDetailPesanan({
    this.id,
    this.namaTanaman,
    this.tanamanId,
    this.quantity,
    this.subHarga,
  });

  factory DataDetailPesanan.fromMap(Map<String, dynamic> data) =>
      DataDetailPesanan(
        id: data['id'] as int?,
        namaTanaman: data['nama_tanaman'] as String?,
        tanamanId: data['tanaman_id'] as int?,
        quantity: data['quantity'] as int?,
        subHarga: data['sub_harga'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nama_tanaman': namaTanaman,
        'tanaman_id': tanamanId,
        'quantity': quantity,
        'sub_harga': subHarga,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [DetailPesanan].
  factory DataDetailPesanan.fromJson(String data) {
    return DataDetailPesanan.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [DetailPesanan] to a JSON string.
  String toJson() => json.encode(toMap());
}
