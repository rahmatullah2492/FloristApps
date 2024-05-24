import 'package:Florist/controller/user_service.dart';
import 'package:Florist/model/users/data_users.dart';
import 'package:Florist/popup/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:Florist/model/users/api_response.dart'; // Import ApiResponseUsers
import 'package:Florist/views/pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false; // loading
  bool showPassword = false; // show or hide password

  // fungsi login
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool rememberUser = false; // Tambahkan variabel rememberUser

  // controller
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Align(
              alignment: Alignment.center,
              child: _buildForm(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 18.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // _buildJudul(),
              _buildGambar(),
              // SizedBox(height: 30),
              _buildInputAddress('Email', _emailController, Icons.email),
              SizedBox(height: 10),
              _buildInputPassword('Password', _passwordController,
                  isPassword: true),
              SizedBox(height: 10),
              _buildRememberUserLupaPassword(),
              SizedBox(height: 40),
              _buttomLogin(),
              SizedBox(height: 10),
              _teksBawah(),
            ],
          ),
        ),
      ),
    );
  }

  // Widget _buildJudul() {
  //   return SizedBox(
  //     child: Padding(
  //       padding: const EdgeInsets.only(top: 2.0, left: 2),
  //       child: Text(
  //         'Sign In!',
  //         style: TextStyle(
  //           fontSize: 20,
  //           fontWeight: FontWeight.bold,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _buildGambar() {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Center(
        child: SizedBox(
          height: 190,
          child: Lottie.asset('assets/img/login.json'),
        ),
      ),
    );
  }

  Widget _buildInputAddress(
      String labelText, TextEditingController controller, IconData? emailIcon) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        suffixIcon: emailIcon != null ? Icon(emailIcon) : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          // Jika email kosong
          return 'Silakan masukkan email Anda';
        }
        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
          // Jika email tidak valid
          return 'Silakan masukkan alamat email yang valid';
        }
        return null;
      },
    );
  }

  Widget _buildInputPassword(String labelText, TextEditingController controller,
      {bool isPassword = false}) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black, width: 2),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: Colors.black,
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    showPassword = !showPassword;
                  });
                },
              )
            : null,
      ),
      obscureText: isPassword && !showPassword,
      validator: (value) {
        if (value == null || value.isEmpty) {
          // Jika password kosong
          return 'Silakan masukkan kata sandi Anda';
        } else {
          if (value.length < 6) {
            // Jika password kurang dari 6 karakter
            return 'Kata sandi minimal 6 karakter';
          }
        }
        return null;
      },
    );
  }

  Widget _buttomLogin() {
    return InkWell(
      onTap: _signIn, // Panggil fungsi login
      child: Center(
        child: Container(
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(
            color: BgTumbuhan.primaryColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: _isLoading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    'Sign In',
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

  void _signIn() async {
    if (!_formKey.currentState!.validate()) {
      // Jika form tidak valid
      return;
    }
    setState(() {
      _isLoading = true; // Mengaktifkan loading
    });
    // Panggil fungsi login dari user_service.dart
    ApiResponseUsers response =
        await login(_emailController.text, _passwordController.text);
    if (response.error == null) {
      // Jika login sukses
      showSuccessToast(message: 'Berhasil Login');
      _saveAndRedirectToHome(response.data as DataUser);
    } else {
      setState(() {
        _isLoading = false; // Menonaktifkan loading
      });
      // Jika gagal, tampilkan pesan error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  // Save and redirect to home
  void _saveAndRedirectToHome(DataUser user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Get.off(NavbarPage());
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
                Get.to(RegisterPage(),
                    transition:
                        Transition.downToUp, // Animasi dari kanan ke kiri
                    duration: Duration(milliseconds: 800));
              },
              child: Text(
                'Sign Up',
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

  Widget _buildRememberUserLupaPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Checkbox(
                value: rememberUser,
                onChanged: (value) {
                  setState(() {
                    rememberUser = value!;
                  });
                },
              ),
              Text("Remember me", style: TextStyle(fontSize: 15)),
            ],
          ),
          TextButton(
              onPressed: () {
                Get.to(LupaPassword(),
                    transition:
                        Transition.downToUp, // Animasi dari kanan ke kiri
                    duration: Duration(milliseconds: 800));
              },
              child: Text("Lupa Password", style: TextStyle(fontSize: 15)))
        ],
      ),
    );
  }
}





// import 'package:Florist/constant.dart';
// import 'package:Florist/views/pages.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//  import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:lottie/lottie.dart';

// class Login extends StatefulWidget {
//   const Login({Key? key}) : super(key: key);

//   @override
//   _LoginState createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   bool _isLoading = false;
//   bool showPassword = false; // show or hide password

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();

//   void _loginUser() async {

//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Align(
//               child: _buildForm(),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildForm() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: EdgeInsets.symmetric(horizontal: 18.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildJudul(),
//               _buildGambar(),
//               SizedBox(height: 10),
//               _buildInputAddress('Email', _emailController, Icons.email),
//               SizedBox(height: 10),
//               _buildInputPassword('Password', _passwordController,
//                   isPassword: true),
//               SizedBox(height: 40),
//               _buttomLogin(),
//               SizedBox(height: 20),
//               _teksBawah(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildJudul() {
//     return SizedBox(
//       child: Padding(
//         padding: const EdgeInsets.only(top: 40.0, left: 2),
//         child: Text(
//           'Sign In!',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildGambar() {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 2),
//       child: Center(
//         child: SizedBox(
//           height: 250,
//           child: Lottie.asset('assets/img/login.json'),
//         ),
//       ),
//     );
//   }

//   Widget _buildInputAddress(
//       String labelText, TextEditingController controller, IconData? emailIcon) {
//     return TextFormField(
//       controller: controller,
//       cursorColor: Colors.black,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.black),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.black, width: 2),
//         ),
//         labelText: labelText,
//         labelStyle: TextStyle(
//           color: Colors.black,
//         ),
//         suffixIcon: emailIcon != null ? Icon(emailIcon) : null,
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Silakan masukkan email Anda';
//         }
//         if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
//           return 'Silakan masukkan alamat email yang valid';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buildInputPassword(String labelText, TextEditingController controller,
//       {bool isPassword = false}) {
//     return TextFormField(
//       controller: controller,
//       cursorColor: Colors.black,
//       decoration: InputDecoration(
//         border: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.black),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.black, width: 2),
//         ),
//         labelText: labelText,
//         labelStyle: TextStyle(
//           color: Colors.black,
//         ),
//         suffixIcon: isPassword
//             ? IconButton(
//                 icon: Icon(
//                   showPassword ? Icons.visibility : Icons.visibility_off,
//                 ),
//                 onPressed: () {
//                   setState(() {
//                     showPassword = !showPassword;
//                   });
//                 },
//               )
//             : null,
//       ),
//       obscureText: isPassword && !showPassword,
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Silakan masukkan kata sandi Anda';
//         }
//         return null;
//       },
//     );
//   }

//   Widget _buttomLogin() {
//     return InkWell(
//       onTap: _signIn,
//       child: Center(
//         child: Container(
//           height: 55,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: BgTumbuhan.primaryColor,
//             borderRadius: BorderRadius.circular(5),
//           ),
//           child: Center(
//             child: _isLoading
//                 ? CircularProgressIndicator(
//                     color: Colors.white,
//                   )
//                 : Text(
//                     'Sign In',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20,
//                       color: Colors.white,
//                     ),
//                   ),
//           ),
//         ),
//       ),
//     );
//   }

//   // Fungsi login
//   Future<void> _signIn() async {
//     if (!_formKey.currentState!.validate()) {
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     // Ambil data email dan password
//     String email = _emailController.text;
//     String password = _passwordController.text;

//     // Buat payload untuk dikirim ke API
//     Map<String, String> payload = {
//       'email': email,
//       'password': password,
//     };

//     // Buat permintaan HTTP POST ke endpoint login
//     final response = await http.post(Uri.parse(loginUrl), body: payload);

//     setState(() {
//       _isLoading = false;
//     });

//     if (response.statusCode == 200) {
//       // Jika permintaan sukses, parse respons JSON
//       Map<String, dynamic> responseData = json.decode(response.body);
//       String token = responseData['token'];
//       // Lakukan sesuatu setelah berhasil masuk, seperti menyimpan token dan navigasi ke halaman beranda
//       print('Token: $token');
//       print(response.body);
//       Get.off(NavbarPage()); // Navigasi ke halaman NavbarPage menggunakan GetX
//     } else {
//       setState(() {
//         _isLoading = false;
//       });

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Failed to sign in. Please check your credentials.'),
//         ),
//       );

//       // Jika permintaan gagal, tampilkan pesan kesalahan
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: Text('Error'),
//           content: Text(
//               '$response.statusCode: ${json.decode(response.body)['message']}'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   Widget _teksBawah() {
//     return Align(
//       alignment: Alignment.bottomCenter,
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 20.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Tidak punya akun?',
//               style: TextStyle(
//                 fontSize: 15,
//                 color: Colors.black,
//               ),
//             ),
//             TextButton(
//               onPressed: () {
//                 Get.to(RegisterPage(),
//                     transition:
//                         Transition.rightToLeft, // Animasi dari kanan ke kiri
//                     duration: Duration(milliseconds: 800));
//               },
//               child: Text(
//                 'Sign Up',
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 15,
//                   color: Color(0xffB81736),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
