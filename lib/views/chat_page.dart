import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'pages.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
            child: _buildBackground(),
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
        'Chat',
        textAlign: TextAlign.center, // Menyusun teks ke tengah
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.black,
          ),
          onPressed: () {
            // Aksi ketika tombol notifikasi ditekan
          },
        ),
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

  Widget _buildBackground() {
    return Padding(
      padding: const EdgeInsets.only(top: 86),
      child: SizedBox(
        child: Container(
          height: 10,
          child: Lottie.asset('assets/img/chat_animation.json'),
        ),
      ),
      //child: _buildForm(),
    );
  }
}
