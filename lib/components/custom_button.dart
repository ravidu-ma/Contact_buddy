import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
        required this.height,
        required this.btnColor,
        required this.fontColor,
        required this.fontSize,
        required this.btnText,
        required this.onPress})
      : super(key: key);

  final double height;
  final double fontSize;
  final Color btnColor;
  final Color fontColor;
  final String btnText;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: TextButton(
          onPressed: onPress,
          style: TextButton.styleFrom(
              shadowColor: Colors.white,
              backgroundColor: btnColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            btnText,
            style: TextStyle(
              color: fontColor,
              fontSize: fontSize,
            ),
          )),
    );
  }
}
