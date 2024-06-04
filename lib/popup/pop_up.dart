import 'package:Florist/views/color.dart';
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

SnackBar snackBarLoginRegister(String message,
    {EdgeInsetsGeometry margin = const EdgeInsets.all(16),
    double top = 0.3,
    double left = 0.1}) {
  return SnackBar(
    content: Text(message),
    backgroundColor: BgTumbuhan.primaryColor,
    duration: const Duration(seconds: 1),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(bottom: 689, right: 14, left: 14, top: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    action: SnackBarAction(
      label: 'Dismiss',
      textColor: Colors.white,
      onPressed: () {},
    ),
  );
}


SnackBar customSnackBar(String message,
    {EdgeInsetsGeometry margin = const EdgeInsets.all(16),
    double top = 0.3,
    double left = 0.1}) {
  return SnackBar(
    content: Text(message),
    backgroundColor: BgTumbuhan.primaryColor,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.only(bottom: 600, right: 14, left: 14, top: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    action: SnackBarAction(
      label: 'Dismiss',
      textColor: Colors.white,
      onPressed: () {},
    ),
  );
}

class PopUpKerajang {
  showCustomSnackbar(BuildContext context, String message) {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (BuildContext context) => Positioned(
        top: MediaQuery.of(context).size.height *
            0.3, // Ubah posisi vertikal sesuai kebutuhan
        left: MediaQuery.of(context).size.width *
            0.1, // Ubah posisi horizontal sesuai kebutuhan
        child: Material(
          color: const Color.fromARGB(0, 255, 25, 25),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.9),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry);

    // Hapus Snackbar setelah beberapa detik
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
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
