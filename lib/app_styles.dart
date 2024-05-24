import 'package:Florist/views/pages.dart';
import 'package:flutter/material.dart';
import './size_configs.dart';

class warna {
  static var primaryColor = const Color(0xff296e48);
  static var blackColor = Colors.black54;
}

// Definisikan warna primer dan sekunder
Color kPrimaryColor = BgTumbuhan.primaryColor; // Warna primer
Color kSecondaryColor = Colors.black; // Warna sekunder
Color warnaPutih = Colors.white;

// Definisikan gaya teks untuk judul
final kTitle = TextStyle(
  fontFamily: 'Klasik', // Jenis huruf
  fontSize: SizeConfig.blockSizeH! * 7, // Ukuran font berdasarkan lebar layar
  color: kSecondaryColor, // Warna teks
);

// Definisikan gaya teks untuk teks tubuh
final kBodyText1 = TextStyle(
  color: kSecondaryColor, // Warna teks
  fontSize: SizeConfig.blockSizeH! * 4.5, // Ukuran font berdasarkan lebar layar
  fontWeight: FontWeight.bold, // Ketebalan font
);

final kBodyText2 = TextStyle(
  color: warnaPutih, // Warna teks
  fontSize: SizeConfig.blockSizeH! * 4.5, // Ukuran font berdasarkan lebar layar
  fontWeight: FontWeight.bold, // Ketebalan font
);
