import 'dart:convert';

import 'detail_pesanan.dart';

class Data {
  String? userId;
  String? totalHarga;
  String? buktiBayar;
  String? status;
  List<DetailPesanan>? detailPesanan;

  Data({
    this.userId,
    this.totalHarga,
    this.buktiBayar,
    this.status,
    this.detailPesanan,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        userId: data['user_id'] as String?,
        totalHarga: data['total_harga'] as String?,
        buktiBayar: data['bukti_bayar'] as String?,
        status: data['status'] as String?,
        detailPesanan: (data['detail_pesanan'] as List<dynamic>?)
            ?.map((e) => DetailPesanan.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'user_id': userId,
        'total_harga': totalHarga,
        'bukti_bayar': buktiBayar,
        'status': status,
        'detail_pesanan': detailPesanan?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());
}
