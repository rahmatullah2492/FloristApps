import 'package:Florist/controller/user_service.dart';
import 'package:Florist/model/users/api_response.dart';
import 'package:flutter/material.dart';
import '../views/pages.dart';

class AkunSaya extends StatefulWidget {
  const AkunSaya({Key? key}) : super(key: key);

  @override
  State<AkunSaya> createState() => _AkunSayaState();
}

UserService _userService = UserService(); // Deklarasi variabel _userService

class _AkunSayaState extends State<AkunSaya> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _noHpController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _jeniskelaminController = TextEditingController();
  //TextEditingController _gantiPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            top: 22,
            left: 0,
            right: 0,
            child: _tampilData(),
          ),
          Positioned(
            bottom: 160,
            left: 0,
            right: 0,
            child: _buttomBuyer(),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeNotification() {
    return AppBar(
      backgroundColor: Colors.white,
      shadowColor: Colors.black,
      elevation: 4,
      title: Text(
        'Akun Saya',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.normal,
        ),
      ),
      // actions: [
      //   IconButton(
      //     icon: Icon(
      //       Icons.message,
      //       color: Colors.black,
      //     ),
      //     onPressed: () {
      //       Get.to(ChatPage());
      //     },
      //   ),
      // ],
    );
  }

  Widget _tampilData() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 86),
          child: FutureBuilder<ApiResponseUsers>(
            future: _userService.getUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (snapshot.data == null || snapshot.data!.data == null) {
                return Center(child: Text('No user data found'));
              } else {
                final user = snapshot.data!.data!;
                _nameController.text = user.name ?? '';
                _noHpController.text = user.noTelp ?? '';
                _emailController.text = user.email ?? '';
                _jeniskelaminController.text = user.jenisKelamin ?? '';
                return Card(
                  color: Colors.white,
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 16.0,
                      bottom: 16.0,
                      left: 16.0,
                      right: 16.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTextField(
                          labelText: 'Nama',
                          controller: _nameController,
                          icon: Icons.person,
                        ),
                        _buildTextField(
                          labelText: 'Nomor Hp',
                          controller: _noHpController,
                          icon: Icons.phone,
                        ),
                        _buildTextField(
                          labelText: 'Email',
                          controller: _emailController,
                          icon: Icons.email,
                        ),
                        _buildTextField(
                          labelText: 'Jenis Kelamin',
                          controller: _jeniskelaminController,
                          icon: Icons.accessibility,
                        ),
                        _buildTextField(
                          labelText: 'Ganti Password',
                          controller: TextEditingController(text: '**********'),
                          icon: Icons.lock,
                        ),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buttomBuyer() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
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

  Widget _buildTextField({
    required String labelText,
    required TextEditingController controller,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        keyboardType: TextInputType.text,
        style: TextStyle(color: Colors.black),
        controller: controller,
        decoration: InputDecoration(
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
// //End Api Users
