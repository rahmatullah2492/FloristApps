import 'dart:convert';

import 'data.dart';

class Pesanan {
  DataPesanan? data;

  Pesanan({this.data});

  factory Pesanan.fromMap(Map<String, dynamic> data) => Pesanan(
        data: data['data'] == null
            ? null
            : DataPesanan.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pesanan].
  factory Pesanan.fromJson(String data) {
    return Pesanan.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pesanan] to a JSON string.
  String toJson() => json.encode(toMap());
}
