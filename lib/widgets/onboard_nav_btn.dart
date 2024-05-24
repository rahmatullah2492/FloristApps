import 'package:flutter/material.dart';
import 'package:Florist/app_styles.dart';

// Widget OnBoardNavBtn
class OnBoardNavBtn extends StatelessWidget {
  const OnBoardNavBtn({
    Key? key,
    required this.name,
    required this.onPressed,
  }) : super(key: key);

  final String name; // Nama tombol
  final VoidCallback onPressed; // Callback yang dipanggil ketika tombol ditekan

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(6),
      splashColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          name,
          style: kBodyText1,
        ),
      ),
    );
  }
}
