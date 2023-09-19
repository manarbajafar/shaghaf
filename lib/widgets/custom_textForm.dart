import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final dynamic validator; // or final void Function()? FunctionName;
  final dynamic controller;

  final bool hasIcon;
  final bool ispasswordType;

  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.validator,
      required this.controller,
      required this.hasIcon,
      required this.ispasswordType});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        // onSaved: onSaved,
        controller: controller,
        validator: validator,
        obscureText: ispasswordType,

        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: hasIcon ? Icon(Icons.search) : null,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
