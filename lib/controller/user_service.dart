import 'dart:convert';
import 'dart:io';
import 'package:Florist/constant.dart';
import 'package:Florist/model/users/api_response.dart';
import 'package:Florist/model/users/data_users.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<ApiResponseUsers> login(String email, String password) async {
  ApiResponseUsers apiResponse = ApiResponseUsers();
  try {
    final response = await http.post(Uri.parse(loginUrl),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});

    switch (response.statusCode) {
      case 200:
        apiResponse.data = DataUser.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
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

class UserService {
  Future<ApiResponseUsers> uploadProfilePicture(File imageFile) async {
    try {
      final token = await getToken();
      final request =
          http.MultipartRequest('POST', Uri.parse(uploadProfileUrl));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'multipart/form-data';

      final fileField =
          await http.MultipartFile.fromPath('image', imageFile.path);
      request.files.add(fileField);

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody =
            await response.stream.transform(utf8.decoder).join();
        final jsonData = jsonDecode(responseBody);
        return ApiResponseUsers.fromJson(jsonData);
      } else {
        return ApiResponseUsers(error: 'Failed to update profile image');
      }
    } catch (e) {
      return ApiResponseUsers(error: 'An error occurred: $e');
    }
  }

  Future<ApiResponseUsers> getUserProfile() async {
    try {
      final token = await getToken();
      final response = await http.get(
        Uri.parse(getProfileUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );
      print('Response status: ${response.statusCode}'); // Debugging
      print('Response body: ${response.body}'); // Debugging

      if (response.statusCode == 200) {
        // Jika respons berhasil (status code 200), kembalikan respons JSON
        final jsonData = jsonDecode(response.body);
        return ApiResponseUsers.fromJson(jsonData);
      } else {
        // Jika respons tidak berhasil, kembalikan objek ApiResponseUsers dengan pesan kesalahan yang sesuai
        print(
            'Failed to load user profile. Status code: ${response.statusCode}'); // Debugging
        return ApiResponseUsers(error: 'Failed to load user profile');
      }
    } catch (e) {
      // Tangani kesalahan yang terjadi selama proses
      print('Error occurred: $e'); // Debugging
      return ApiResponseUsers(error: 'An error occurred: $e');
    }
  }

// lama
  Future<ApiResponseUsers> getUser() async {
    ApiResponseUsers apiResponse = ApiResponseUsers();
    try {
      String token = await getToken();
      final response = await http.get(Uri.parse(userUrl), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      });
      print(response.body);
      switch (response.statusCode) {
        case 200:
          apiResponse = ApiResponseUsers.fromJson(jsonDecode(response.body));
          break;
        default:
          apiResponse.error = 'Something went wrong';
          break;
      }
    } catch (e) {
      apiResponse.error = 'An error occurred: $e';
    }
    return apiResponse;
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

Future<void> sendPasswordResetEmail(String email) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    print('Password reset email sent');
  } catch (e) {
    print('Error sending password reset email: $e');
  }
}
