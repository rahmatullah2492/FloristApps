import 'dart:convert';
import 'dart:io';
import 'package:Florist/constant.dart';
import 'package:Florist/model/users/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<ApiResponseUsers> login(String email, String password) async {
  try {
    final response = await http.post(Uri.parse(loginUrl),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});

    if (response.statusCode == 200) {
      return ApiResponseUsers.fromJson(jsonDecode(response.body));
    } else {
      return ApiResponseUsers(
        data: null,
        error: 'Login failed',
      );
    }
  } catch (e) {
    return ApiResponseUsers(
      data: null,
      error: 'An error occurred',
    );
  }
}

// register
Future<ApiResponseUsers> register(
    String name, String email, String password, String text) async {
  ApiResponseUsers apiResponse = ApiResponseUsers();
  try {
    final response = await http.post(Uri.parse(registerUrl), headers: {
      'Accept': 'application/json'
    }, body: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': password
    });
    switch (response.statusCode) {
      case 200:
        //apiResponse.data = DataUser.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// get user
Future<ApiResponseUsers> getUserDetail() async {
  ApiResponseUsers apiResponse = ApiResponseUsers();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(detailUserUrl), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });
    switch (response.statusCode) {
      case 200:
        // apiResponse.data = DataUser.fromJson(jsonDecode(response.body));
        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }
  } catch (e) {
    apiResponse.error = serverError;
  }
  return apiResponse;
}

// fungsi untuk memeriksa status login menggunakan API
Future<bool> checkLoginStatus() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString('token');

  if (token == null) {
    return false; // Token tidak ada, pengguna belum login
  }
  final response = await http.get(Uri.parse(userUrl), headers: {
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  });
  if (response.statusCode != 200) {
    return true; // Token tidak valid, pengguna belum login
  } else {
    return false;
  }
}

Future<void> sendPasswordResetEmail(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    print('Password reset email sent');
  } catch (e) {
    print('Error sending password reset email: $e');
  }
}

// get token
Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getString('token') ?? '';
}

Future<int> getUserId() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return pref.getInt('id') ?? 0;
}

Future<bool> logout() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  return await pref.remove('token');
}

String? getStringImage(File? file) {
  if (file == null) return null;
  return base64Encode(file.readAsBytesSync());
}


Future<ApiResponseUsers> uploadProfilePicture(File imageFile) async {
  ApiResponseUsers apiResponse = ApiResponseUsers();
  try {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(uploadProfileUrl),
    );

    // Tambahkan token otentikasi pengguna ke header permintaan
    String token = await getToken();
    request.headers['Authorization'] = 'Bearer $token';

    // Tambahkan file gambar ke permintaan multipart
    request.files.add(await http.MultipartFile.fromPath('image', imageFile.path));

    var response = await request.send();

    if (response.statusCode == 200) {
      // Jika unggah berhasil, tidak ada pembaruan yang diperlukan dalam data pengguna
      apiResponse = ApiResponseUsers();
    } else {
      apiResponse.error = 'Failed to upload profile picture: ${response.reasonPhrase}';
    }
  } catch (e) {
    apiResponse.error = 'An error occurred: $e';
  }
  return apiResponse;
}
