import 'package:Florist/controller/user_controller.dart';
import 'package:Florist/model/user/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/pages.dart';

class AkunSaya extends StatefulWidget {
  const AkunSaya({Key? key}) : super(key: key);

  @override
  State<AkunSaya> createState() => _AkunSayaState();
}

class _AkunSayaState extends State<AkunSaya> {
  final showdataController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: _buildHomeNotification(),
          ),
          Positioned.fill(
            child: _tampilData(),
          ),
          // Positioned(child: _buildSearch()),
        ],
      ),
    );
  }

  Widget _buildHomeNotification() {
    return AppBar(
      backgroundColor:
          Colors.white, // Membuat AppBar dengan latar belakang putih
      shadowColor: BgTumbuhan.blackColor,
      elevation: 4, // bayangan AppBar
      title: Text(
        'Akun Saya',
        textAlign: TextAlign.center, // Menyusun teks ke tengah
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.message,
            color: Colors.black,
          ),
          onPressed: () {
            Get.to(ChatPage()); // Navigasi ke halaman ChatPage menggunakan GetX
          },
        ),
      ],
    );
  }

  Widget _tampilData() {
    return Padding(
      padding: const EdgeInsets.only(top: 86),
      child: FutureBuilder(
        future: showdataController.showDataUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final user = snapshot.data
                as UserData; // Ubah tipe data snapshot.data menjadi User
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage:
                      NetworkImage(user.data!.fotoProfil.toString()),
                  child: user.data!.fotoProfil ==
                          null // Periksa apakah URL kosong atau null
                      ? null
                      : ErrorWidget(
                          Icon(
                            Icons.error,
                            color: Colors.white,
                          ),
                        ),
                ), // Akses properti fotoProfil
                title: Text(user.data!.namaLengkap.toString()),
                subtitle: Text(user.data!.email.toString()),
              ),
            );
          }
        },
      ),
    );
  }

  //Start Api Users

  // Widget _buildBackground() {
  //   return Padding(
  //     padding: const EdgeInsets.only(top: 90),
  //     child: Scaffold(
  //       body: _isLoading
  //           ? Center(
  //               child: CircularProgressIndicator(),
  //             )
  //           : ListView.builder(
  //               itemCount: users.length,
  //               itemBuilder: (context, index) {
  //                 final user = users[index];
  //                 return Card(
  //                     child: ListTile(
  //                   leading: CircleAvatar(
  //                       backgroundImage: NetworkImage(user.avatar)),
  //                   title: Text('${user.firstName} ${user.lastName}'),
  //                   subtitle: Text(user.email),
  //                 ));
  //               }),
  //     ),
  //   );
  // }
  //End Api Users
}
