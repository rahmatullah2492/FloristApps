import 'package:Florist/model/user/user.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UserController extends GetxController {
  final String apiUrl = "http://10.10.181.60:80/api/posts_pengguna/1";

  // Properti loading untuk menandai status pengambilan data
  RxBool loading = true.obs;

  // Properti untuk menampung data pengguna
  Rx<UserData?> user = Rx<UserData?>(null);

  // Properti untuk menampung pesan kesalahan jika ada
  RxString error = RxString('Data Tidak Ditemukan');

  Future<UserData> showDataUser() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      print(response.body);
      if (response.statusCode == 200) {
        final jsonData = response.body;
        final user = UserData.fromJson(jsonData);
        return user;
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('Failed to load data');
    }
  }

// Future<UserData> showDataUser() async {
//   try {
//     final response = await http.get(Uri.parse(apiUrl));
//     print(response.body);
//     if (response.statusCode == 200) {
//       final jsonData = response.body;
//       final user = UserData.fromJson(jsonData);
//       if (user.data != null) {
//         user.data!.namaLengkap = user.data!.namaLengkap ?? '';
//         user.data!.email = user.data!.email ?? '';
//         user.data!.alamatRumah = user.data!.alamatRumah ?? '';
//         user.data!.noTelp = user.data!.noTelp ?? '';
//         user.data!.fotoProfil = user.data!.fotoProfil ?? '';
//       }
//       return user;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   } catch (e) {
//     print(e.toString());
//     throw Exception('Failed to load data');
//   }
// }
}
