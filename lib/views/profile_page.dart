import 'package:Florist/controller/user_controller.dart';
import 'package:Florist/controller/user_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Import Get
import '../popup/pop_up.dart';
import '../views/pages.dart';
import '../widgets/widgets.dart';
import '../profile/page_profile.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final showdataController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Text('Profile'),
        elevation: 4,
        // Gunakan warna langsung jika BgTumbuhan tidak didefinisikan
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
              // Builder(
              //   builder: (context) {
              //     return FutureBuilder(
              //       future: showdataController.showDataUser(),
              //       // mainAxisAlignment: MainAxisAlignment.center,
              //       builder: (BuildContext context,
              //           AsyncSnapshot<UserData> snapshot) {
              //         if (snapshot.connectionState == ConnectionState.waiting) {
              //           return Center(
              //             child: CircularProgressIndicator(),
              //           );
              //         } else if (snapshot.hasError) {
              //           return Text('Error: ${snapshot.error}');
              //         } else {
              //           final user = snapshot.data as UserData;
              //           return Column(
              //             children: [
              //               Container(
              //                 width: 150,
              //                 child: const CircleAvatar(
              //                   radius: 60,
              //                   backgroundImage: NetworkImage(
              //                       "https://avatars.githubusercontent.com/u/63160888?v=8"),
              //                 ),
              //               ),
              //               ListTile(
              //                 title: Text(
              //                   user.data!.namaLengkap.toString(),
              //                   style: TextStyle(fontSize: 20),
              //                   textAlign: TextAlign.center,
              //                 ),
              //                 subtitle: Text(
              //                   user.data!.email.toString(),
              //                   textAlign: TextAlign.center,
              //                 ),
              //               ),
              //             ],
              //           ); // Ubah tipe data snapshot.data menjadi User
              //         }
              //       },
              //     );
              //   },
              // ),
              const SizedBox(height: 30),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ProfileWidget(
                      icon: Icons.person,
                      title: 'Akun Saya',
                      onTap: () {
                        //showdata.showPengguna(1);
                        // Gunakan Get.to di sini
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
                        // Gunakan Get.to di sini
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
                          // Tampilkan dialog konfirmasi untuk keluar dari aplikasi
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

                                      // Panggil fungsi logout API
                                      bool loggedOut = await logout();

                                      if (loggedOut) {
                                        // Tampilkan pesan berhasil logout
                                        showSuccessToast(message: 'Logout successful!');
                                        // Pindah ke halaman login setelah logout
                                        Get.offAll(Login());
                                      } else {
                                        // Tangani kesalahan jika logout gagal
                                        showToast(message: 'Failed to logout from API');
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
