import 'package:flutter/material.dart';

class  TextFormCustom extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;

  TextFormCustom({
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.black.withOpacity(0.2),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          labelStyle: TextStyle(color: Colors.black),
        ),
        style: TextStyle(color: Colors.black),
        validator: validator,
      ),
    );
  }
}
