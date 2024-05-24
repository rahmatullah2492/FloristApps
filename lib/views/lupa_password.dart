import 'package:flutter/material.dart';
import 'package:Florist/views/pages.dart';
import 'package:get/get.dart';
import '../popup/pop_up.dart';
import '../providers/auth.dart';

class LupaPassword extends StatefulWidget {
  const LupaPassword({Key? key}) : super(key: key);

  @override
  State<LupaPassword> createState() => _LupaPasswordState();
}

class _LupaPasswordState extends State<LupaPassword> {
  
  final FirebaseAuthService _auth = FirebaseAuthService();
  bool _isLoading = false;

  TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  bool rememberUser = false;
  bool showPassword = false;
  late Size mediaSize;

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Ganti BackgroundPutih.build() dengan widget BackgroundPutih yang sesuai
          Positioned.fill(
            child: Align(
              child: _buildForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJudul() {
    return SizedBox(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 2),
          child: Text(
            'Forgot Password!',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black, // Ganti dengan warna yang sesuai
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDescription() {
    return SizedBox(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 2),
          child: Text(
            'Silahkan masukkan email yang terdaftar',
            style: TextStyle(
              fontSize: 15,
              color: Colors.black, // Ganti dengan warna yang sesuai
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 18.0, right: 18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildJudul(),
            _buildDescription(),
            SizedBox(height: 50),
            _buildInputAddress('Email', _emailController, Icons.email),
            SizedBox(height: 30),
            _buttomLogin(),
            SizedBox(height: 20),
            _teksBawah(),
          ],
        ),
      ),
    );
  }

  Widget _buildInputAddress(
      String labelText, TextEditingController controller, IconData? emailIcon) {
    return TextField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.black), // Ganti dengan warna yang sesuai
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.black, width: 2), // Ganti dengan warna yang sesuai
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black, // Ganti dengan warna yang sesuai
        ),
        suffixIcon: emailIcon != null ? Icon(emailIcon) : null,
      ),
    );
  }

  Widget _buttomLogin() {
    return InkWell(
      onTap: _forgotPassword,
      child: Center(
        child: Container(
          height: 55,
          width: 480,
          decoration: BoxDecoration(
            color: BgTumbuhan.primaryColor, // Ganti dengan warna yang sesuai
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: _isLoading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    'Send Password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _teksBawah() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tidak punya akun?',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(
                  Login(),
                  transition:
                      Transition.downToUp, // Animasi dari kanan ke kiri
                  duration: Duration(milliseconds: 800),
                );
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: Color(0xffB81736),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _forgotPassword() async { // Tambahkan fungsi _forgotPassword
    setState(() {
      _isLoading = true;
    });

    String email = _emailController.text;
    try {
      setState(() {
        _isLoading = false;
      });

      await _auth.forgotPassword(email);
      showSuccessToast(message: "Reset password email sent successfully");
    } catch (e) {
      showSuccessToast(message: "Failed to send reset password email: $e");
      // Tambahkan logika untuk menampilkan pesan kesalahan kepada pengguna
    }
  }
}
