import 'package:Florist/model/users/data_users.dart';

class ApiResponseUsers {
  DataUser? data;
  String? error;

  ApiResponseUsers({
    this.data,
    this.error,
  });

  factory ApiResponseUsers.fromJson(Map<String, dynamic> json) {
    return ApiResponseUsers(
      data: json['user'] != null ? DataUser.fromJson(json['user']) : null,
      error: json['error'],
    );
  }
}
