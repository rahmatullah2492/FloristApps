import 'package:Florist/controller/user_service.dart';
import 'package:Florist/model/users/api_response.dart';
import 'package:flutter/material.dart';
import '../views/pages.dart';

class AlamatSaya extends StatefulWidget {
  const AlamatSaya({Key? key}) : super(key: key);

  @override
  State<AlamatSaya> createState() => _AlamatSayaState();
}

class _AlamatSayaState extends State<AlamatSaya> {
  TextEditingController _alamatRumahController = TextEditingController();
  List<dynamic> listItems = [];

  final UserService _userService =
      UserService(); // Deklarasi variabel _userService

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
      // actions: [
      //   IconButton(
      //     icon: Icon(
      //       Icons.message,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {
      //       Get.to(ChatPage()); // Navigasi ke halaman ChatPage menggunakan GetX
      //     },
      //   ),
      // ],
    );
  }

  Widget _buildForm() {
    return Padding(
      padding: const EdgeInsets.only(top: 86),
      child: Column(
        children: [
          _buildList(
            'Alamat Rumah',
            _alamatRumahController,
            Icons.location_on,
          ),
          _buttomBuyer(),
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
          FutureBuilder<ApiResponseUsers>(
            future: _userService.getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                final user = snapshot.data!;
                _alamatRumahController.text = user.data!.alamatRumah ?? '';
                // Set the initial value of the controller to the user's address
                // controller.text = user.toString();
                return Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 0.0,
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField(
                          labelText: 'Alamat Rumah',
                          controller: _alamatRumahController,
                          icon: Icons.location_on,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0, left: 0, right: 0),
      child: TextField(
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: labelText,
          prefixIcon: Icon(icon),
          suffixIcon: IconButton(
            icon: Icon(Icons.edit, color: Colors.red),
            onPressed: () {
              // Aksi ketika tombol edit ditekan
            },
          ),
        ),
      ),
    );
  }

  Widget _buttomBuyer() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0, left: 16.0, right: 16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: BgTumbuhan.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(7.0), // Sudut tumpul
          ),
          minimumSize: Size(double.infinity, 60), // Ukuran minimum tombol
        ),
        onPressed: () {
          // Aksi ketika tombol "Buyer" ditekan
        },
        child: Text(
          'Update',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  // Widget _buttomTambahAlamat() {
  //   return Padding(
  //     padding: const EdgeInsets.all(16.0),
  //     child: InkWell(
  //       child: Container(
  //         height: 55,
  //         width: 480,
  //         decoration: ShapeDecoration(
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.circular(5),
  //             side: BorderSide(
  //                 // color: BgTumbuhan.primaryColor, // Pastikan import BackgroundPutih dan BgTumbuhan sudah dilakukan dengan benar
  //                 ),
  //           ),
  //         ),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             SizedBox(width: 10),
  //             ImageIcon(
  //               AssetImage('assets/img/google.png'),
  //               size: 24,
  //               // color: BgTumbuhan.primaryColor, // Pastikan import BackgroundPutih dan BgTumbuhan sudah dilakukan dengan benar
  //             ),
  //             SizedBox(width: 10),
  //             Text(
  //               'Tambah Alamat',
  //               style: TextStyle(
  //                 fontWeight: FontWeight.bold,
  //                 fontSize: 20,
  //                 // color: BgTumbuhan.blackColor, // Pastikan import BackgroundPutih dan BgTumbuhan sudah dilakukan dengan benar
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
