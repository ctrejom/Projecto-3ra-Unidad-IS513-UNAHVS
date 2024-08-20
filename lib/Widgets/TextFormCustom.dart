import 'package:flutter/material.dart';

class TextFormCustom extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final TextStyle style;
  final IconData icon;

  TextFormCustom({
    required this.label,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    required this.style,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            labelText: label,
            filled: true,
            fillColor: Color.fromARGB(255, 0, 0, 0).withOpacity(0.2),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            labelStyle: style,
            prefixIcon: Icon(icon, color: const Color.fromARGB(255, 255, 255, 255)),
          ),
          style: style,
          validator: validator,
        ),
      );
}
