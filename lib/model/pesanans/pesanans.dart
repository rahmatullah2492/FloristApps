import 'dart:convert';

import 'data.dart';

class Pesanans {
  Data? data;

  Pesanans({this.data});

  factory Pesanans.fromMap(Map<String, dynamic> data) => Pesanans(
        data: data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Pesanans].
  factory Pesanans.fromJson(String data) {
    return Pesanans.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Pesanans] to a JSON string.
  String toJson() => json.encode(toMap());
}
