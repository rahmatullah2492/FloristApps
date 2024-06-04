// import 'dart:convert';

// import 'data.dart';

// class UserData {
//   bool? success;
//   String? message;
//   Data? data;

//   UserData({this.success, this.message, this.data});

//   factory UserData.fromMap(Map<String, dynamic> data) => UserData(
//         success: data['success'] as bool?,
//         message: data['message'] as String?,
//         data: data['data'] == null
//             ? null
//             : Data.fromMap(data['data'] as Map<String, dynamic>),
//       );

//   Map<String, dynamic> toMap() => {
//         'success': success,
//         'message': message,
//         'data': data?.toMap(),
//       };

//   /// `dart:convert`
//   ///
//   /// Parses the string and returns the resulting Json object as [User].
//   factory UserData.fromJson(String data) {
//     return UserData.fromMap(json.decode(data) as Map<String, dynamic>);
//   }

//   /// `dart:convert`
//   ///
//   /// Converts [User] to a JSON string.
//   String toJson() => json.encode(toMap());
// }
