// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:Florist/constant.dart';
// import 'package:Florist/model/keranjang/api_response.dart';
// import 'package:Florist/model/keranjang/data_keranjang.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// Future<String> getToken() async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   return pref.getString('token') ?? '';
// }

// Future<ApiResponseKeranjang> getKeranjang() async {
//   ApiResponseKeranjang apiResponse = ApiResponseKeranjang();
//   try {
//     String token = await getToken();
//     final response = await http.get(
//       Uri.parse(keranjangUrl),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//     print(response.body);
//     switch (response.statusCode) {
//       case 200:
//         // Decode the response body
//         dynamic decodedBody = jsonDecode(response.body);
//         List<dynamic> dataList = decodedBody['data'];
//         List<DataKeranjang> keranjangList =
//             dataList.map((e) => DataKeranjang.fromJson(e)).toList();
//         apiResponse.keranjang = keranjangList;
//         apiResponse.message = 'Keranjang fetched successfully';
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   } catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }

// Future<ApiResponseKeranjang> addToKeranjang(
//     String namaTanaman, String quantity) async {
//   ApiResponseKeranjang apiResponse = ApiResponseKeranjang();
//   try {
//     String token = await getToken();
//     final response = await http.post(
//       Uri.parse(keranjangUrl),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode(<String, String>{
//         'nama_tanaman': namaTanaman,
//         'quantity': quantity,
//       }),
//     );
//     print(response.body);
//     switch (response.statusCode) {
//       case 201:
//         apiResponse.message = 'Berhasil ditambahkan ke keranjang';
//         break;
//       default:
//         apiResponse.error = 'Gagal menambahkan ke keranjang';
//         break;
//     }
//   } catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }

// Future<ApiResponseKeranjang> deleteKeranjang(int id) async {
//   ApiResponseKeranjang apiResponse = ApiResponseKeranjang();
//   try {
//     String token = await getToken();
//     final response = await http.delete(
//       Uri.parse('$keranjangUrl/$id'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Accept': 'application/json',
//       },
//     );
//     print(response.body);
//     switch (response.statusCode) {
//       case 200:
//         apiResponse.message = 'Keranjang deleted successfully';
//         break;
//       case 404:
//         apiResponse.error = 'Keranjang not found';
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   } catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Florist/constant.dart';
import 'package:Florist/model/keranjang/api_response.dart';
import 'package:Florist/model/keranjang/data_keranjang.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  String? token = pref.getString('token');
  if (token == null || token.isEmpty) {
    throw Exception('Token not found or empty');
  }
  return token;
}

Future<ApiResponseKeranjang> getKeranjang() async {
  ApiResponseKeranjang apiResponse = ApiResponseKeranjang();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(keranjangUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    print(response.body);
    switch (response.statusCode) {
      case 200:
        // Decode the response body
        dynamic decodedBody = jsonDecode(response.body);
        List<dynamic> dataList = decodedBody['data'];
        List<DataKeranjang> keranjangList =
            dataList.map((e) => DataKeranjang.fromJson(e)).toList();
        apiResponse.keranjang = keranjangList;
        apiResponse.message = 'Keranjang fetched successfully';
        break;
      default:
        apiResponse.error = 'Failed to fetch keranjang';
        break;
    }
  } catch (e) {
    apiResponse.error = 'Error: $e';
  }
  return apiResponse;
}


Future<ApiResponseKeranjang> addToKeranjang(
    String namaTanaman, String quantity, int userId) async {
  ApiResponseKeranjang apiResponse = ApiResponseKeranjang();
  try {
    String token = await getToken();

    final response = await http.post(
      Uri.parse(keranjangUrl),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        'nama_tanaman': namaTanaman,
        'quantity': quantity,
        'user_id': userId,
      }),
    );
    print(response.body);
    
    switch (response.statusCode) {
      case 201:
        apiResponse.message = 'Berhasil ditambahkan ke keranjang';
        break;
      default:
        apiResponse.error = 'Gagal menambahkan ke keranjang';
        break;
    }
  } catch (e) {
    apiResponse.error = 'Error: $e';
  }
  return apiResponse;
}


Future<ApiResponseKeranjang> deleteKeranjang(int id) async {
  ApiResponseKeranjang apiResponse = ApiResponseKeranjang();
  try {
    String token = await getToken();
    final response = await http.delete(
      Uri.parse('$keranjangUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );
    print(response.body);
    switch (response.statusCode) {
      case 200:
        apiResponse.message = 'Keranjang deleted successfully';
        break;
      case 404:
        apiResponse.error = 'Keranjang not found';
        break;
      default:
        apiResponse.error = 'Failed to delete keranjang';
        break;
    }
  } catch (e) {
    apiResponse.error = 'Error: $e';
  }
  return apiResponse;
}




// Future<ApiResponseKeranjang> addToKeranjang(
//     String namaTanaman, String quantity) async {
//   ApiResponseKeranjang apiResponse = ApiResponseKeranjang();
//   try {
//     String token = await getToken();
//     final response = await http.post(
//       Uri.parse(keranjangUrl),
//       headers: {
//         'Content-Type': 'application/json; charset=UTF-8',
//         'Authorization': 'Bearer $token',
//       },
//       body: jsonEncode(<String, String>{
//         'nama_tanaman': namaTanaman,
//         'quantity': quantity,
//       }),
//     );
//     print(response.body);
//     switch (response.statusCode) {
//       case 201:
//         apiResponse.message = 'Added to keranjang successfully';
//         break;
//       default:
//         apiResponse.error = 'Failed to add to keranjang';
//         break;
//     }
//   } catch (e) {
//     apiResponse.error = 'Error: $e';
//   }
//   return apiResponse;
// }








// class ApiHelper {
//   static Future<ApiResponseKeranjang> addToKeranjang(
//       String namaTanaman, String quantity) async {

//     final http.Response response = await http.post(
//       Uri.parse(keranjangUrl),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//         'nama_tanaman': namaTanaman,
//         'quantity': quantity,
//       }),
//     );

//     if (response.statusCode == 201) {
//       final Map<String, dynamic> responseData = jsonDecode(response.body);
//       return ApiResponseKeranjang.fromJson(responseData);
//     } else {
//       return ApiResponseKeranjang(
//         message: 'Failed to add to keranjang: ${response.statusCode}',
//       );
//     }
//   }
// }


// kode percobaaan bisa ini
// class ApiHelper {
//   // static const baseUrl = "http://192.168.1.3:80/api";
//   static Future<ApiResponseKeranjang> addToKeranjang(
//       String namaTanaman, String quantity) async {

//     final String apiUrl = '$baseUrl/keranjang';
//     final Map<String, dynamic> requestData = {
//       'nama_tanaman': namaTanaman,
//       'quantity': quantity,
//     };

//     final http.Response response = await http.post(
//       Uri.parse(apiUrl),
//       body: requestData,
//     );

//     if (response.statusCode == 201) {
//       final Map<String, dynamic> responseData = jsonDecode(response.body);
//       return ApiResponseKeranjang.fromJson(responseData);
//     } else {
//       return ApiResponseKeranjang(
//         message: 'Failed to add to keranjang: ${response.statusCode}',
//       );
//     }
//   }
// }

// kode percobaaan bisa ini













// Start kode berikut bisa , kode aslinya

// Future<ApiResponseKeranjang> addKeranjang(
//     String tanamanId, String quantity) async {
//   try {
//     final response = await http.post(
//       Uri.parse(keranjangUrl),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, dynamic>{
//         'tanaman_id': tanamanId,
//         'quantity': quantity,
//       }),
//     );

//     if (response.statusCode == 201) {
//       final jsonData = jsonDecode(response.body);
//       return ApiResponseKeranjang(
//           keranjang: (jsonData['keranjang'] as List)
//               .map((e) => DataKeranjang.fromJson(e))
//               .toList());
//     } else {
//       throw Exception(
//           'Gagal menambahkan item ke keranjang: ${response.statusCode}');
//     }
//   } catch (e) {
//     throw Exception('Error: $e');

//   }
// }

// End kode diatas bisa , kode aslinya


// class ApiHelper {
//   static Future<ApiResponseKeranjang> addToKeranjang(
//       String keranjangUrl, String namaTanaman, String quantity) async {
//     final Map<String, dynamic> requestData = {
//       'nama_tanaman': namaTanaman,
//       'quantity': quantity,
//     };

//     try {
//       final http.Response response = await http.post(
//         Uri.parse(keranjangUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(requestData),
//       );

//       if (response.statusCode == 201) {
//         final Map<String, dynamic> responseData = jsonDecode(response.body);
//         return ApiResponseKeranjang.fromJson(responseData);
//       } else {
//         return ApiResponseKeranjang(
//           message: 'Failed to add to keranjang: ${response.statusCode}',
//         );
//       }
//     } catch (e) {
//       return ApiResponseKeranjang(
//         message: 'An error occurred: $e',
//       );
//     }
//   }
// }


// end kode percobaaan

// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:Florist/constant.dart';
// import 'package:Florist/model/keranjang/api_response.dart';
// import 'package:Florist/model/keranjang/data_keranjang.dart';

// Future<ApiResponseKeranjang> getKeranjang() async {
//   ApiResponseKeranjang apiResponse = ApiResponseKeranjang();
//   try {
//     final response = await http.get(Uri.parse(keranjangUrl));
//     print(response.body);
//     switch (response.statusCode) {
//       case 200:
//         // Convert JSON response to List<DataKeranjang>
//         List<dynamic> jsonList = jsonDecode(response.body)['data'];
//         List<DataKeranjang> keranjangList =
//             jsonList.map((e) => DataKeranjang.fromJson(e)).toList();
//         apiResponse.keranjang = keranjangList;
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   } catch (e) {
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }
