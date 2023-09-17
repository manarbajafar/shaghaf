import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final dynamic validator; // or final void Function()? FunctionName;
  final dynamic controller;
  const CustomTextFormField(
      {super.key,
      required this.hintText,
      required this.validator,
      required this.controller});

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
        // obscureText: ispasswordType, from arugments
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          hintText: hintText,
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

// class CustomTextForm extends StatelessWidget {
//   final TextEditingController? controllar;
//   final TextInputType textInputType;
//   final String labelText;
//   final String? Function(String?)? validator;
//   final void Function(String?)? onSave;
//   final EdgeInsetsGeometry padding;
//   final Widget? suffixIcon;
//   bool obscureText = false;
//   final String? hintText;

//   CustomTextForm({
//     Key? key,
//     required this.textInputType,
//     required this.labelText,
//     this.validator,
//     this.onSave,
//     required this.padding,
//     this.controllar,
//     this.suffixIcon,
//     required this.obscureText,
//     this.hintText,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: padding,
//       child: TextFormField(
//         //autovalidateMode: AutovalidateMode.onUserInteraction,
//         controller: controllar,
//         keyboardType: textInputType,
//         obscureText: obscureText,
//         decoration: InputDecoration(
//           labelText: labelText,
//           labelStyle: Theme.of(context).textTheme.headline5,
//           hintText: hintText,
//           suffixIcon: suffixIcon,
//         ),
//         validator: validator,
//         onSaved: onSave,
//       ),
//     );
//   }
// }
