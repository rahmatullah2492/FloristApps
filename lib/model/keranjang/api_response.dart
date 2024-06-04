// import 'package:Florist/model/keranjang/data_keranjang.dart';

// class ApiResponseKeranjang {
//   List<DataKeranjang>? keranjang;
//   String? error;
//   String? message;

//   ApiResponseKeranjang({this.keranjang, this.error});

//   Future<List<DataKeranjang>> getKeranjang() {
//     return Future<List<DataKeranjang>>.value(keranjang!);
//   }
// }

import 'package:Florist/model/keranjang/data_keranjang.dart';

class ApiResponseKeranjang {
  List<DataKeranjang>? keranjang;
  String? error;
  String? message;

  ApiResponseKeranjang({this.keranjang, this.error, this.message});

  factory ApiResponseKeranjang.fromJson(Map<String, dynamic> json) {
    return ApiResponseKeranjang(
      keranjang: json['keranjang'] != null
          ? List<DataKeranjang>.from(
              json['keranjang'].map((item) => DataKeranjang.fromJson(item)))
          : null,
      error: json['error'],
      message: json['message'],
    );
  }

  // Method untuk mendapatkan daftar keranjang dari respons
  List<DataKeranjang> getKeranjangList() {
    return keranjang ?? [];
  }
}
