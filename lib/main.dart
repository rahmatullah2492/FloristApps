import 'package:Florist/controller/keranjang_service.dart';
import 'package:Florist/controller/tanaman_service.dart';
import 'package:flutter/material.dart'; // Untuk menangani tampilan
import 'package:flutter/services.dart'; // Untuk menangani platform
import 'package:get/get.dart'; // Untuk menangani routing
import 'package:shared_preferences/shared_preferences.dart'; // Untuk menyimpan data persisten
import './views/pages.dart'; // Untuk menangani routing

//Variabel global seenOnboard digunakan untuk
//melacak apakah pengguna telah melihat halaman onboarding.
bool? seenOnboard;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  getTanaman();
  Get.put(KeranjangService()); // Initialize the service

  // try {
  //   if (Platform.isAndroid) {
  //     await Firebase.initializeApp(
  //       options: const FirebaseOptions(
  //         apiKey: 'AIzaSyCa91jiB5zeZpgZy8iLdIJf9hSYBfr0O_4',
  //         appId: '1:757640831794:android:4852d85aa2727377352d2b',
  //         messagingSenderId: '757640831794',
  //         projectId: 'gardenapp-4eca3',
  //         storageBucket: 'gardenapp-4eca3.appspot.com',
  //       ),
  //     );
  //   } else {
  //     await Firebase.initializeApp();
  //   }
  // } catch (e) {
  //   print('Error initializing Firebase: $e');
  // }

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);

  //SharedPreferences digunakan untuk mendapatkan nilai seenOnboard,
  //yang menentukan apakah pengguna telah melihat halaman onboarding
  SharedPreferences pref = await SharedPreferences.getInstance();
  seenOnboard = pref.getBool('seenOnboard') ?? false;

  runApp(MyApp()); //menjalankan aplikasi dengan widget MyApp.
}

//Kelas MyApp adalah widget utama aplikasi yang memiliki state.
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //var auth = FirebaseAuth.instance;
  var isLogin = false; //adalah variabel yang menunjukkan status login pengguna.

  @override
  void initState() {
    super.initState();
    checkIfLogin();
  }

//adalah fungsi yang memeriksa apakah pengguna sudah login
//dengan memeriksa token yang disimpan di SharedPreferences.
  Future<bool> checkLoginStatus() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    return token != null;
  }

// checkIfLogin() memanggil checkLoginStatus()
//dan memperbarui state isLogin jika pengguna sudah login.

  void checkIfLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool loginStatus = pref.getString('token') != null;
    if (loginStatus && mounted) {
      setState(() {
        isLogin =
            true; //adalah variabel yang menunjukkan status login pengguna.
      });
    }
  }

  // void checkIfLogin() async {
  //   bool loginStatus = await checkLoginStatus();
  //   if (loginStatus && mounted) {
  //     setState(() {
  //       isLogin =
  //           true; //adalah variabel yang menunjukkan status login pengguna.
  //     });
  //   }
  // }

//build(BuildContext context) mengembalikan GetMaterialApp
//dengan pengaturan tema dan menentukan halaman awal berdasarkan
//status login (isLogin) dan apakah pengguna sudah melihat halaman onboarding (seenOnboard).

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Garden',
      theme: ThemeData(
        textTheme: Theme.of(context).textTheme,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: isLogin
          ? NavbarPage()
          : (seenOnboard == true ? Login() : OnboardingPage()),
    );
  }
}

// Penjelasan Fungsi checkLoginStatus dan checkIfLogin
// checkLoginStatus: Fungsi ini memeriksa SharedPreferences untuk token yang disimpan.
//Jika token ada, fungsi mengembalikan true (pengguna sudah login), jika tidak, mengembalikan false.
// checkIfLogin: Fungsi ini memanggil checkLoginStatus dan jika hasilnya true
// serta widget masih aktif (mounted), maka isLogin diubah menjadi true menggunakan
// setState untuk memperbarui UI.
