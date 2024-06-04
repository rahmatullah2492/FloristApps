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
      data: json.containsKey('user') && json.containsKey('token')
          ? DataUser.fromJson({
              'id': json['user']['id'],
              'name': json['user']['name'],
              'image': json['user']['image'],
              'email': json['user']['email'],
              'token': json['token'],
            })
          : null,
      error: json['error'],
    );
  }

  DataUser? getUser() {
    return data;
  }

  getDataUser() {
    return data;
  }
}
