import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../views/pages.dart';

class AlamatSaya extends StatefulWidget {
  const AlamatSaya({Key? key}) : super(key: key);

  @override
  State<AlamatSaya> createState() => _AlamatSayaState();
}

class _AlamatSayaState extends State<AlamatSaya> {
  TextEditingController _alamatRumahController = TextEditingController();
  // final showdataController = Get.find<UserController>();
  List<dynamic> listItems = [];

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
            child: _buildForm(),
          ),
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
        'Alamat Saya',
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

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 125),
      child: Column(
        children: [
          _buildList(
            'Alamat Rumah',
            _alamatRumahController,
            Icons.location_on,
          ),
          _buttomTambahAlamat(),
        ],
      ),
    );
  }

  Widget _buildList(
      String labelText, TextEditingController controller, IconData? emailIcon) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // FutureBuilder<UserData>(
          //   future: showdataController.showDataUser(),
          //   builder: (BuildContext context, AsyncSnapshot<UserData> snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     } else if (snapshot.hasError) {
          //       return Text('Error: ${snapshot.error}');
          //     } else {
          //       final user = snapshot.data!;
          //       // Set the initial value of the controller to the user's address
          //       controller.text = user.data!.alamatRumah.toString();
          //       return TextField(
          //         controller: controller,
          //         decoration: InputDecoration(
          //           labelText: labelText,
          //           labelStyle: TextStyle(color: Colors.black),
          //           prefixIcon: Icon(emailIcon),
          //           enabledBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(10),
          //             borderSide: BorderSide(color: Colors.black),
          //           ),
          //           focusedBorder: OutlineInputBorder(
          //             borderRadius: BorderRadius.circular(10),
          //             borderSide: BorderSide(color: Colors.black),
          //           ),
          //         ),
          //         maxLines: null, // allow unlimited lines
          //         minLines: 1,
          //         // onChanged: (value) {
          //         //   setState(() {
          //         //     user.data!.alamatRumah = value;
          //         //   });
          //         // },
          //       );
          //     }
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buttomTambahAlamat() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: InkWell(
        child: Container(
          height: 55,
          width: 480,
          decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
              side: BorderSide(
                  // color: BgTumbuhan.primaryColor, // Pastikan import BackgroundPutih dan BgTumbuhan sudah dilakukan dengan benar
                  ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: 10),
              ImageIcon(
                AssetImage('assets/img/google.png'),
                size: 24,
                // color: BgTumbuhan.primaryColor, // Pastikan import BackgroundPutih dan BgTumbuhan sudah dilakukan dengan benar
              ),
              SizedBox(width: 10),
              Text(
                'Tambah Alamat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  // color: BgTumbuhan.blackColor, // Pastikan import BackgroundPutih dan BgTumbuhan sudah dilakukan dengan benar
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
