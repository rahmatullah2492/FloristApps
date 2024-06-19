import 'dart:io';
import 'package:Florist/controller/user_service.dart';
import 'package:Florist/model/users/api_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../popup/pop_up.dart';
import '../views/pages.dart';
import '../widgets/widgets.dart';
import '../profile/page_profile.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _imageFile;
  String? _imageUrl;
  String? _name;
  String? _email;
  final UserService _userService = UserService();
  final String _imageKey = 'profile_image';

  @override
  void initState() {
    super.initState();
    _getUserProfile();
    _loadImageFromPreferences();
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _saveImageToPreferences(pickedFile.path);
      _uploadProfilePicture(_imageFile!);
    }
  }

  Future<void> _saveImageToPreferences(String imagePath) async {
    final prefs =
        await SharedPreferences.getInstance(); // Membuat SharedPreferences
    await prefs.setString(_imageKey, imagePath);
  }

  Future<void> _loadImageFromPreferences() async {
    final prefs =
        await SharedPreferences.getInstance(); // Membuat SharedPreferences
    final imagePath = prefs.getString(_imageKey);
    if (imagePath != null) {
      setState(() {
        _imageFile = File(imagePath);
      });
    }
  }

  Future<ApiResponseUsers> _uploadProfilePicture(File imageFile) async {
    ApiResponseUsers response =
        await _userService.uploadProfilePicture(imageFile);
    if (response.error == null) {
      snackBarLoginRegister('Profile picture uploaded successfully!');
      _getUserProfile();
    } else {
      showToast(message: response.error ?? 'An error occurred');
    }
    return response;
  }

  Future<void> _getUserProfile() async {
    ApiResponseUsers response = await _userService.getUser();
    print('Response data: ${response.data}');
    if (response.error == null && response.data != null) {
      setState(() {
        _imageUrl = response.data!.image;
        _name = response.data!.name; // Mengambil nilai name dari DataUser
        _email = response.data!.email; // Mengambil nilai email dari DataUser
      });
      print('Image URL: $_imageUrl');
    } else {
      showToast(message: response.error ?? 'An error occurred');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Profile'),
        elevation: 4,
        shadowColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(maxHeight: size.height),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              const SizedBox(height: 30),
              GestureDetector(
                onTap: () => _pickImage(ImageSource.gallery),
                child: Stack(
                  children: [
                    // Placeholder icon (icon person)
                    Container(
                      width: 120, // Sesuaikan ukuran dengan radius avatar
                      height: 120, // Sesuaikan ukuran dengan radius avatar
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey[300], // Warna latar belakang
                      ),
                      child: Icon(
                        Icons.person,
                        size: 60, // Sesuaikan ukuran dengan avatar
                        color: Colors.white, // Warna ikon
                      ),
                    ),
                    // Avatar image
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.transparent,
                      backgroundImage: _imageFile != null
                          ? FileImage(_imageFile!)
                          : _imageUrl != null
                              ? NetworkImage(_imageUrl!)
                                  as ImageProvider<Object>
                              : null,
                    ),
                    // Camera button
                    Positioned(
                      top: 80,
                      right: 55,
                      left: 40,
                      child: Opacity(
                        opacity: 0.7,
                        child: Container(
                          child: IconButton(
                            icon: Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            onPressed: () => _pickImage(ImageSource.camera),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _name ?? 'Nama',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                _email ?? 'Email',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileWidget(
                      icon: Icons.person,
                      title: 'Akun Saya',
                      onTap: () {
                        Get.to(
                          AkunSaya(),
                          transition: Transition.downToUp,
                        );
                      },
                    ),
                    ProfileWidget(
                      icon: Icons.location_on,
                      title: 'Alamat Saya',
                      onTap: () {
                        Get.to(
                          AlamatSaya(),
                          transition: Transition.downToUp,
                        );
                      },
                    ),
                    ProfileWidget(
                      icon: Icons.logout,
                      title: 'Log Out',
                      onTap: () async {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Confirm Logout'),
                              content: Text('Are you sure you want to logout?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    Navigator.of(context).pop();

                                    bool loggedOut = await logout();

                                    if (loggedOut) {
                                      showSuccessToast(
                                          message: 'Logout successful!');
                                      Get.offAll(Login());
                                    } else {
                                      showToast(
                                          message: 'Failed to logout from API');
                                    }
                                  },
                                  child: Text('Logout'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
