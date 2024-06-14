import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {
  String hint;

  TextEditingController Mycontroller;

  TextInputType? keyboardType;

  bool obscureText;

  String? Function(String?)? validator;

  TextEditingController? controller;

  TextFormFieldCustom(this.hint,
      {required this.Mycontroller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.validator,
      this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TextFormField(
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          controller: controller,
          decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: const Color(0xffE3F0FF),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.transparent)),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )),
        ));
  }
}
