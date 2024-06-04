import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Florist/constant.dart';
import 'package:Florist/model/tanaman/api_respone.dart';
import 'package:Florist/model/tanaman/data_tanaman.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<ApiResponseTanaman> getTanaman({String? searchQuery, String? category}) async {
  ApiResponseTanaman apiResponse = ApiResponseTanaman();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  try {
    // Membuat URL dengan parameter pencarian dan kategori
    String url = '$tanamanUrl?';
    if (searchQuery != null && searchQuery.isNotEmpty) {
      url += 'searchQuery=$searchQuery&';
    }
    if (category != null && category.isNotEmpty) {
      url += 'category=$category';
    }

    // Mengambil data terbaru dari server
    final response = await http.get(Uri.parse(url));
    print(response.body);
    switch (response.statusCode) {
      case 200:
        // Convert JSON response to List<DataTanaman>
        List<dynamic> jsonList = jsonDecode(response.body)['data'];
        List<DataTanaman> tanamanList =
            jsonList.map((e) => DataTanaman.fromJson(e)).toList();
        apiResponse.tanaman = tanamanList;

        // Simpan hasil pencarian ke SharedPreferences
        await prefs.setString(url, response.body);

        break;
      default:
        apiResponse.error = somethingWentWrong;
        break;
    }

    // Mendapatkan userId dari server
    final userIdResponse = await http.get(Uri.parse(userUrl));
    print(userIdResponse.body);
    switch (userIdResponse.statusCode) {
      case 200:
        apiResponse.userId = jsonDecode(userIdResponse.body)['userId'];
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




// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:Florist/constant.dart';
// import 'package:Florist/model/tanaman/api_respone.dart';
// import 'package:Florist/model/tanaman/data_tanaman.dart';

// Future<ApiResponseTanaman> getTanaman({String? searchQuery, String? category}) async {
//   ApiResponseTanaman apiResponse = ApiResponseTanaman();
//   try {
//     // Mengambil data tanaman
//     final response = await http.get(Uri.parse(tanamanUrl));
//     print(response.body);
//     switch (response.statusCode) {
//       case 200:
//         // Convert JSON response to List<DataTanaman>
//         List<dynamic> jsonList = jsonDecode(response.body)['data'];
//         List<DataTanaman> tanamanList =
//             jsonList.map((e) => DataTanaman.fromJson(e)).toList();

//         // Set tanamanList to ApiResponseTanaman
//         apiResponse.tanaman = tanamanList;
//         break;
//       default:
//         apiResponse.error = somethingWentWrong;
//         break;
//     }

//     // Tambahan: Mendapatkan userId dari server
//     final userIdResponse = await http.get(Uri.parse(userUrl));
//     print(userIdResponse.body);
//     switch (userIdResponse.statusCode) {
//       case 200:
//         // Mendapatkan userId dari respons JSON dan menyimpannya di dalam apiResponse
//         apiResponse.userId = jsonDecode(userIdResponse.body)['userId'];
//         break;
//       default:
//         // Tangani kesalahan jika tidak berhasil mendapatkan userId
//         apiResponse.error = somethingWentWrong;
//         break;
//     }
//   } catch (e) {
//     // Tangani kesalahan jaringan atau server
//     apiResponse.error = serverError;
//   }
//   return apiResponse;
// }




