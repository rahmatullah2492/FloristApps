import 'dart:convert';

import 'detail_pesanan.dart';

class DataPesanan {
  int? id;
  int? userId;
  int? totalHarga;
  String? buktiBayar;
  String? status;
  List<DetailPesanan>? detailPesanan;

  DataPesanan({
    this.id,
    this.userId,
    this.totalHarga,
    this.buktiBayar,
    this.status,
    this.detailPesanan,
  });

  factory DataPesanan.fromMap(Map<String, dynamic> data) => DataPesanan(
        id: data['id'] as int?,
        userId: data['user_id'] as int?,
        totalHarga: data['total_harga'] as int?,
        buktiBayar: data['bukti_bayar'] as String?,
        status: data['status'] as String?,
        detailPesanan: (data['detail_pesanan'] as List<dynamic>?)
            ?.map((e) => DetailPesanan.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user_id': userId,
        'total_harga': totalHarga,
        'bukti_bayar': buktiBayar,
        'status': status,
        'detail_pesanan': detailPesanan?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory DataPesanan.fromJson(String data) {
    return DataPesanan.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}
