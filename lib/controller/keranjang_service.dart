import 'dart:convert';
import 'package:Florist/model/keranjang/data_keranjang.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:Florist/constant.dart';
import 'package:Florist/model/keranjang/api_response.dart';
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
    print(response.body); // Cetak respons API untuk debugging
    switch (response.statusCode) {
      case 200:
        dynamic decodedBody = jsonDecode(response.body);
        apiResponse = ApiResponseKeranjang.fromJson(decodedBody);
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
    String namaTanaman, String quantity, int userId, int tanamanId) async {
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
        'tanaman_id': tanamanId,
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

class KeranjangService extends GetxService {
  var cartItems = <DataKeranjang>[].obs;

  void addToCart(DataKeranjang item) {
    cartItems.add(item);
  }

  List<DataKeranjang> getCartItems() {
    return cartItems;
  }
}

























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
//         apiResponse.error = 'Failed to fetch keranjang';
//         break;
//     }
//   } catch (e) {
//     apiResponse.error = 'Error: $e';
//   }
//   return apiResponse;
// }
