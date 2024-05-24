import 'package:flutter/material.dart';
import 'package:Florist/app_styles.dart';
import 'package:Florist/size_configs.dart';

class MyTextButton extends StatelessWidget {
  const MyTextButton({
    Key? key,
    required this.buttomName,
    required this.onPressed,
    required this.bgColor,
  }) : super(key: key);

  final String buttomName;
  final VoidCallback onPressed;
  final bgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: SizedBox(
        height: SizeConfig.blockSizeH! * 15.5,
        width: SizeConfig.blockSizeH! * 100,
        child: TextButton(
          onPressed: onPressed,
          child: Text(
            buttomName,
            style: kBodyText2,
            selectionColor: Colors.black,
          ),
          style: TextButton.styleFrom(
            backgroundColor: bgColor,
          ),
        ),
      ),
    );
  }
}
