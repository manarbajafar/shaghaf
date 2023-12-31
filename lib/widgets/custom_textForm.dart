import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? hintText;
  final dynamic validator; // or final void Function()? FunctionName;
  final dynamic? controller;
  final String? initialValue;
  final bool hasIcon;
  final bool ispasswordType;
  final bool isEmailOrPasswordForUpdate;
  Function(String)? onChanged;

  CustomTextFormField(
      {super.key,
      this.initialValue,
      this.hintText,
      required this.validator,
      this.controller,
      this.isEmailOrPasswordForUpdate = false,
      required this.hasIcon,
      required this.ispasswordType,
      this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: hasIcon ? 45 : 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextFormField(
        onChanged: onChanged,
        // onSaved: onSaved,
        controller: controller,
        validator: validator,
        obscureText: ispasswordType,
        initialValue: initialValue,
        enabled: !isEmailOrPasswordForUpdate ? true : false,
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
