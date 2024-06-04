import 'package:Florist/model/pesanan/pesanan.dart';

class ApiResponsePesanan {
  List<DataPesanan>? pesanan;
  String? message;
  String? error;

  ApiResponsePesanan({this.pesanan, this.error});

  factory ApiResponsePesanan.fromJson(Map<String, dynamic> json) {
    return ApiResponsePesanan(
      pesanan: json.containsKey('pesanan')
          ? (json['pesanan'] as List<dynamic>)
              .map((e) => DataPesanan.fromMap(e as Map<String, dynamic>))
              .toList()
          : null,
      error: json['error'],
    );
  }
}
