import 'dart:io'; // Untuk menangani platform
import 'package:Florist/controller/user_controller.dart';
import 'package:Florist/controller/user_service.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Untuk autentikasi
import 'package:firebase_core/firebase_core.dart'; // Untuk inisialisasi Firebase
import 'package:flutter/material.dart'; // Untuk menangani tampilan
import 'package:flutter/services.dart'; // Untuk menangani platform
import 'package:get/get.dart'; // Untuk menangani routing
import 'package:shared_preferences/shared_preferences.dart'; // Untuk menyimpan data persisten
import './views/pages.dart'; // Untuk menangani routing
// Import halaman

// Deklarasikan variabel global seenOnboard
bool? seenOnboard;

// Fungsi main, titik masuk utama ke dalam aplikasi Flutter
void main() async {
  Get.put(UserController());
  // baruu
  WidgetsFlutterBinding
      .ensureInitialized(); // Pastikan inisialisasi widgets telah selesai

  // Inisialisasi Firebase sesuai dengan platform
  try {
    if (Platform.isAndroid) {
      await Firebase.initializeApp(
        // Inisialisasi Firebase
        options: const FirebaseOptions(
          // Konfigurasi Firebase
          apiKey: 'AIzaSyCa91jiB5zeZpgZy8iLdIJf9hSYBfr0O_4',
          appId: '1:757640831794:android:4852d85aa2727377352d2b',
          messagingSenderId: '757640831794',
          projectId: 'gardenapp-4eca3',
          storageBucket: 'gardenapp-4eca3.appspot.com',
        ),
      );
    } else {
      await Firebase.initializeApp(); // Inisialisasi Firebase
    }
  } catch (e) {
    print('Error initializing Firebase: $e'); // Cetak pesan error
  }

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.bottom,
    SystemUiOverlay.top
  ]); // Mengaktifkan overlay pada aplikasi

  // Mendapatkan instance dari SharedPreferences untuk menyimpan dan mengambil data persisten
  SharedPreferences pref = await SharedPreferences.getInstance();
  // Mendapatkan nilai boolean dari SharedPreferences, jika tidak ada, gunakan false
  seenOnboard = pref.getBool('seenOnboard') ?? false;

  // Menjalankan aplikasi dengan widget MyApp()
  runApp(MyApp());
}

// Kelas MyApp adalah widget utama yang mewakili seluruh aplikasi
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  // State<MyApp> adalah state yang mewakili seluruh aplikasi
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance; // Inisialisasi FirebaseAuth
  var isLogin = false; // Variabel untuk menandakan apakah pengguna sedang login

  @override
  // Fungsi ini dipanggil ketika aplikasi dijalankan
  void initState() {
    super.initState();
    checkIfLogin(); // Memeriksa apakah pengguna sedang login
  }

  // Fungsi ini dipanggil ketika aplikasi dijalankan
  checkIfLogin() async {
    bool loginStatus = await checkLoginStatus(); // Panggil fungsi cek login status
    
    if (loginStatus && mounted) {
      setState(() {
        isLogin = true; // Ubah variabel isLogin menjadi true jika sudah login
      });
    }
  }

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
          : (seenOnboard == true
              ? Login()
              : OnboardingPage()), // Memanggil halaman NavbarPage jika pengguna sedang login
    );
  }
}
