import 'package:Florist/popup/pop_up.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Florist/controller/user_service.dart'; // Ubah path sesuai dengan lokasi AuthService
import 'package:Florist/model/users/api_response.dart'; // Ubah path sesuai dengan lokasi ApiResponse
import 'package:Florist/model/users/data_users.dart'; // Ubah path sesuai dengan lokasi DataUser

import 'pages.dart'; // Ubah path sesuai dengan lokasi LoginPage

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isLoading = false;

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  bool showPassword = false;
  late Size mediaSize;

  @override
  void dispose() {
    
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: _buildForm(),
          ),
        ],
      ),
    );
  }

  Widget _buildJudul() {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.only(top: 40.0, left: 1),
        child: Text(
          'Sign Up!',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildGambar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1),
      child: Center(
        child: SizedBox(
          height: 190,
          child: Lottie.asset('assets/img/register.json'),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 18.0, right: 18),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildJudul(),
              _buildGambar(),
              _buildInputTextField('Name', _nameController, Icons.person),
              SizedBox(height: 10),
              _buildInputTextField('Email', _emailController, Icons.email),
              SizedBox(height: 10),
              _buildInputPassword('Password', _passwordController,
                  isPassword: true),
              SizedBox(height: 10),
              _buildInputPassword('Confirm Password', _confirmPasswordController,
                  isPassword: true),
              SizedBox(height: 40),
              _buttomRegister(),
              SizedBox(height: 10),
              _teksBawah(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttomRegister() {
    return InkWell(
      onTap: _buttonregister,
      child: Center(
        child: Container(
          height: 55,
          width: 400,
          decoration: BoxDecoration(
            color: BgTumbuhan.primaryColor, // Sesuaikan warna sesuai kebutuhan
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: _isLoading
                ? CircularProgressIndicator(
                    color: Colors.white,
                  )
                : Text(
                    'Sign Up',
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

  Widget _buildInputTextField(
      String labelText, TextEditingController controller, IconData? emailIcon) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        labelText: labelText,
        suffixIcon: emailIcon != null ? Icon(emailIcon) : null,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field tidak boleh kosong';
        }
        return null;
      },
    );
  }

  Widget _buildInputPassword(
    String labelText,
    TextEditingController controller, {
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      obscureText: isPassword && !showPassword,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
        ),
        labelText: labelText,
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
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Field tidak boleh kosong';
        }
        return null;
      },
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
              'Sudah punya akun?',
              style: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                Get.to(Login(),duration: Duration(milliseconds: 800),transition: Transition.downToUp);
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

  void _buttonregister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    ApiResponseUsers response = await register(
        _nameController.text,
        _emailController.text, 
        _passwordController.text,
        _confirmPasswordController.text);
    if (response.error== null) { // Jika login sukses
      showSuccessToast(message: 'Berhasil Register');
      _saveAndRedirectToLogin(response.data as DataUser);
  } else {
    setState(() {
      _isLoading = false;
    });
    //

    // Jika gagal, tampilkan pesan error
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${response.error}'),
      ),
    );
  }
  }

  void _saveAndRedirectToLogin(DataUser user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString('token', user.token ?? '');
    await pref.setInt('userId', user.id ?? 0);
    Get.offAll(Login());
  }

  
}
