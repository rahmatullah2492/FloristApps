import 'package:flutter/material.dart';

class Background {
  Gradient gradientBackground() {
    return LinearGradient(
      colors: [
        Color(0xffB81736), // Primary Color
        Color(0xff281537), // Secondary Color
      ],
    );
  }
}

class BackgroundPutih {
  static Widget build() {
    return Container(color: Colors.white);
  }
}

class BgTumbuhan {
  //Primary color
  static var primaryColor = const Color(0xff296e48);
  static var blackColor = Colors.black54;
}
