import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData; // Data media query
  static double? screenWidth; // Lebar layar perangkat
  static double? screenHeight; // Tinggi layar perangkat
  static double?
      blockSizeH; // Ukuran blok horizontal, dalam persen dari lebar layar
  static double?
      blockSizeV; // Ukuran blok vertikal, dalam persen dari tinggi layar

  // Metode init digunakan untuk menginisialisasi SizeConfig dengan data MediaQueryData dari BuildContext
  void init(BuildContext context) {
    _mediaQueryData =
        MediaQuery.of(context); // Mendapatkan MediaQueryData dari BuildContext
    screenWidth = _mediaQueryData!
        .size.width; // Mendapatkan lebar layar perangkat dari MediaQueryData
    screenHeight = _mediaQueryData!
        .size.height; // Mendapatkan tinggi layar perangkat dari MediaQueryData
    blockSizeH = screenWidth! /
        100; // Menghitung ukuran blok horizontal dalam persen dari lebar layar
    blockSizeV = screenHeight! /
        100; // Menghitung ukuran blok vertikal dalam persen dari tinggi layar
  }
}
