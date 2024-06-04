import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final IconData? icon;
  final int maxLines;
  final String? suffixText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Widget? child;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.obscureText = false,
    this.icon,
    this.maxLines = 1,
    this.suffixText,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFD9D9D9),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        maxLines: maxLines,
        validator: validator,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey),
          suffixIcon: icon != null ? Icon(icon) : null,
          suffixText: suffixText,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
