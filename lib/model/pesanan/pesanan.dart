import 'dart:convert';
import 'detail_pesanan.dart';

class DataPesanan {
  int? userId;
  int? totalHarga;
  String? buktiBayar;
  String? status;
  List<DataDetailPesanan>? detailPesanans;

  DataPesanan({
    this.userId,
    this.totalHarga,
    this.buktiBayar,
    this.status,
    this.detailPesanans,
  });

  factory DataPesanan.fromMap(Map<String, dynamic> data) => DataPesanan(
        userId: data['user_id'] as int?,
        totalHarga: data['total_harga'] as int?,
        buktiBayar: data['bukti_bayar'] as String?,
        status: data['status'] as String?,
        detailPesanans: (data['detail_pesanans'] as List<dynamic>?)
            ?.map((e) => DataDetailPesanan.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'user_id': userId,
        'total_harga': totalHarga,
        'bukti_bayar': buktiBayar,
        'status': status,
        'detail_pesanans': detailPesanans?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pesanan].
  factory DataPesanan.fromJson(String data) {
    return DataPesanan.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pesanan] to a JSON string.
  String toJson() => json.encode(toMap());
}






















// import 'package:Florist/model/pesanan/detail_pesanan.dart';

// class DataPesanan {
//   int? userId;
//   int? totalHarga;
//   String? buktiBayar;
//   String? status;
//   DateTime? updatedAt;
//   DateTime? createdAt;
//   int? id;
//   List<DetailPesanan>? detailPesanans;

//   DataPesanan({
//     this.userId,
//     this.totalHarga,
//     this.buktiBayar,
//     this.status,
//     this.updatedAt,
//     this.createdAt,
//     this.id,
//     this.detailPesanans,
//   });

//   factory DataPesanan.fromJson(Map<String, dynamic> json) {
//     return DataPesanan(
//       userId: json['user_id'],
//       totalHarga: json['total_harga'],
//       buktiBayar: json['bukti_bayar'],
//       status: json['status'],
//       updatedAt: DateTime.parse(json['updated_at']),
//       createdAt: DateTime.parse(json['created_at']),
//       id: json['id'],
//       detailPesanans: json['detail_pesanans'] != null
//           ? List<DetailPesanan>.from(
//               json['detail_pesanans'].map((x) => DetailPesanan.fromJson(x)))
//           : null,
//     );
//   }
// }

//}
