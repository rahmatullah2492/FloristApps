import 'package:Florist/model/pesanan/detail_pesanan.dart';

class ApiResponseDetailPesanan {
  DataDetailPesanan? detailPesanan;
  String? message;
  String? error;

  ApiResponseDetailPesanan({this.detailPesanan, this.error});

  factory ApiResponseDetailPesanan.fromJson(Map<String, dynamic> json) {
    return ApiResponseDetailPesanan(
      detailPesanan: json.containsKey('detail_pesanans')
          ? DataDetailPesanan.fromJson(json['detail_pesanans'])
          : null,
      error: json['error'],
    );
  }
}
