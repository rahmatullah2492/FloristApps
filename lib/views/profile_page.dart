import 'dart:io';
import 'package:Florist/controller/user_service.dart';
import 'package:Florist/model/users/api_response.dart';
import 'package:Florist/profile/coba.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart'; // Import ImagePicker
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
  final UserService _userService = UserService();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      _uploadProfilePicture(_imageFile!);
    }
  }

  Future<ApiResponseUsers> _uploadProfilePicture(File imageFile) async {
    ApiResponseUsers response =
        await _userService.uploadProfilePicture(imageFile);
    if (response.error == null) {
      showSuccessToast(message: 'Profile picture uploaded successfully!');
      _getUserProfile();
    } else {
      showToast(message: response.error ?? 'An error occurred');
    }
    return response;
  }

  @override
  void initState() {
    super.initState();
    _getUserProfile();
  }

  Future<void> _getUserProfile() async {
    ApiResponseUsers response = await _userService.getUserProfile();
    print('Response data: ${response.data}');
    if (response.error == null) {
      setState(() {
        
        // Asumsikan `DataUser` memiliki properti `image_url`
        _imageUrl = response.data?.image;
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
              CircleAvatar(
                radius: 60,
                backgroundColor:
                    Colors.grey[300], // Background color if no image
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : _imageUrl != null
                        ? NetworkImage(_imageUrl!) as ImageProvider<Object>
                        : null,
                child: _imageFile == null && _imageUrl == null
                    ? Icon(Icons.person,
                        size: 60, color: Colors.white) // Icon if no image
                    : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text('Pick Image from Gallery'),
              ),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: Text('Take a Photo'),
              ),
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
                          TanamanListPage(),
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


// import 'package:Florist/controller/user_service.dart';
// import 'package:Florist/profile/coba.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart'; // Import Get
// import '../popup/pop_up.dart';
// import '../views/pages.dart';
// import '../widgets/widgets.dart';
// import '../profile/page_profile.dart';

// class ProfilePage extends StatelessWidget {
//   ProfilePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Text('Profile'),
//         elevation: 4,
//         // Gunakan warna langsung jika BgTumbuhan tidak didefinisikan
//         shadowColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           constraints: BoxConstraints(maxHeight: size.height),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 5),
//               // Builder(
//               //   builder: (context) {
//               //     return FutureBuilder(
//               //       future: showdataController.showDataUser(),
//               //       // mainAxisAlignment: MainAxisAlignment.center,
//               //       builder: (BuildContext context,
//               //           AsyncSnapshot<UserData> snapshot) {
//               //         if (snapshot.connectionState == ConnectionState.waiting) {
//               //           return Center(
//               //             child: CircularProgressIndicator(),
//               //           );
//               //         } else if (snapshot.hasError) {
//               //           return Text('Error: ${snapshot.error}');
//               //         } else {
//               //           final user = snapshot.data as UserData;
//               //           return Column(
//               //             children: [
//               //               Container(
//               //                 width: 150,
//               //                 child: const CircleAvatar(
//               //                   radius: 60,
//               //                   backgroundImage: NetworkImage(
//               //                       "https://avatars.githubusercontent.com/u/63160888?v=8"),
//               //                 ),
//               //               ),
//               //               ListTile(
//               //                 title: Text(
//               //                   user.data!.namaLengkap.toString(),
//               //                   style: TextStyle(fontSize: 20),
//               //                   textAlign: TextAlign.center,
//               //                 ),
//               //                 subtitle: Text(
//               //                   user.data!.email.toString(),
//               //                   textAlign: TextAlign.center,
//               //                 ),
//               //               ),
//               //             ],
//               //           ); // Ubah tipe data snapshot.data menjadi User
//               //         }
//               //       },
//               //     );
//               //   },
//               // ),
//               const SizedBox(height: 30),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ProfileWidget(
//                       icon: Icons.person,
//                       title: 'Akun Saya',
//                       onTap: () {
//                         //showdata.showPengguna(1);
//                         // Gunakan Get.to di sini
//                         Get.to(
//                           AkunSaya(),
//                           transition: Transition.downToUp,
//                         );
//                       },
//                     ),
//                     ProfileWidget(
//                       icon: Icons.location_on,
//                       title: 'Alamat Saya',
//                       onTap: () {
//                         // Gunakan Get.to di sini
//                         Get.to(
//                           TanamanListPage(),
//                           transition: Transition.downToUp,
//                         );
//                       },
//                     ),
//                     ProfileWidget(
//                       icon: Icons.logout,
//                       title: 'Log Out',
//                       onTap: () async {
//                         // Tampilkan dialog konfirmasi untuk keluar dari aplikasi
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               title: Text('Confirm Logout'),
//                               content: Text('Are you sure you want to logout?'),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text('Cancel'),
//                                 ),
//                                 TextButton(
//                                   onPressed: () async {
//                                     Navigator.of(context).pop();

//                                     // Panggil fungsi logout API
//                                     bool loggedOut = await logout();

//                                     if (loggedOut) {
//                                       // Tampilkan pesan berhasil logout
//                                       showSuccessToast(
//                                           message: 'Logout successful!');
//                                       // Pindah ke halaman login setelah logout
//                                       Get.offAll(Login());
//                                     } else {
//                                       // Tangani kesalahan jika logout gagal
//                                       showToast(
//                                           message: 'Failed to logout from API');
//                                     }
//                                   },
//                                   child: Text('Logout'),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



// import 'dart:io';

// import 'package:Florist/controller/user_service.dart';
// import 'package:Florist/profile/coba.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart'; // Import Get
// import '../popup/pop_up.dart';
// import '../views/pages.dart';
// import '../widgets/widgets.dart';
// import '../profile/page_profile.dart';

// class ProfilePage extends StatelessWidget {
//   ProfilePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     File? _imageFile;

    
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         automaticallyImplyLeading: false,
//         title: Text('Profile'),
//         elevation: 4,
//         // Gunakan warna langsung jika BgTumbuhan tidak didefinisikan
//         shadowColor: Colors.black,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           constraints: BoxConstraints(maxHeight: size.height),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 5),
//               Builder(
//                 builder: (context) {
//                   return FutureBuilder(
//                     future: showdataController.showDataUser(),
//                     // mainAxisAlignment: MainAxisAlignment.center,
//                     builder: (BuildContext context,
//                         AsyncSnapshot<UserData> snapshot) {
//                       if (snapshot.connectionState == ConnectionState.waiting) {
//                         return Center(
//                           child: CircularProgressIndicator(),
//                         );
//                       } else if (snapshot.hasError) {
//                         return Text('Error: ${snapshot.error}');
//                       } else {
//                         final user = snapshot.data as UserData;
//                         return Column(
//                           children: [
//                             Container(
//                               width: 150,
//                               child: const CircleAvatar(
//                                 radius: 60,
//                                 backgroundImage: NetworkImage(
//                                     "https://avatars.githubusercontent.com/u/63160888?v=8"),
//                               ),
//                             ),
//                             ListTile(
//                               title: Text(
//                                 user.data!.namaLengkap.toString(),
//                                 style: TextStyle(fontSize: 20),
//                                 textAlign: TextAlign.center,
//                               ),
//                               subtitle: Text(
//                                 user.data!.email.toString(),
//                                 textAlign: TextAlign.center,
//                               ),
//                             ),
//                           ],
//                         ); // Ubah tipe data snapshot.data menjadi User
//                       }
//                     },
//                   );
//                 },
//               ),
//               const SizedBox(height: 30),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ProfileWidget(
//                       icon: Icons.person,
//                       title: 'Akun Saya',
//                       onTap: () {
//                         //showdata.showPengguna(1);
//                         // Gunakan Get.to di sini
//                         Get.to(
//                           AkunSaya(),
//                           transition: Transition.downToUp,
//                         );
//                       },
//                     ),
//                     ProfileWidget(
//                       icon: Icons.location_on,
//                       title: 'Alamat Saya',
//                       onTap: () {
//                         // Gunakan Get.to di sini
//                         Get.to(
//                           TanamanListPage(),
//                           transition: Transition.downToUp,
//                         );
//                       },
//                     ),
//                     ProfileWidget(
//                       icon: Icons.logout,
//                       title: 'Log Out',
//                       onTap: () async {
//                         // Tampilkan dialog konfirmasi untuk keluar dari aplikasi
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return AlertDialog(
//                               title: Text('Confirm Logout'),
//                               content: Text('Are you sure you want to logout?'),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                   child: Text('Cancel'),
//                                 ),
//                                 TextButton(
//                                   onPressed: () async {
//                                     Navigator.of(context).pop();

//                                     // Panggil fungsi logout API
//                                     bool loggedOut = await logout();

//                                     if (loggedOut) {
//                                       // Tampilkan pesan berhasil logout
//                                       showSuccessToast(
//                                           message: 'Logout successful!');
//                                       // Pindah ke halaman login setelah logout
//                                       Get.offAll(Login());
//                                     } else {
//                                       // Tangani kesalahan jika logout gagal
//                                       showToast(
//                                           message: 'Failed to logout from API');
//                                     }
//                                   },
//                                   child: Text('Logout'),
//                                 ),
//                               ],
//                             );
//                           },
//                         );
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

