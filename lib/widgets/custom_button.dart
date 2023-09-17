import 'package:flutter/material.dart';
import 'package:shaghaf_app/constatnt/app_colors.dart';

class CustomButton extends StatelessWidget {
  String text;
  Function()? onPressed;
  Color buttonColor;

  CustomButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.buttonColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 55,
      margin: const EdgeInsets.only(top: 20),
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(vertical: 15),
        onPressed: onPressed,
        color: buttonColor,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: buttonColor == AppColor.primaryColor
                ? Colors.white
                : AppColor.primaryColor,
          ),
        ),
      ),
    );
  }
}
