import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// Fungsi konfirmasi keluar
class KonfirmasiKeluarAplikasi {
  static void showExitConfirmation(BuildContext context, VoidCallback onYes) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi Keluar'),
          content: Text('Apakah anda yakin ingin keluar dari aplikasi?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                onYes();
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}

// Fungsi untuk menampilkan pesan kesalahan
void showToast({required String message}) {
  // Tambahkan parameter message
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}

// Fungsi untuk menampilkan pesan sukses
void showSuccessToast({required String message}) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.green, // Warna hijau untuk sukses
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
