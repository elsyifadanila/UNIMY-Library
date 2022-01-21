import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final Icon icon;
  final Function(String)? onChanged;
  final bool obscureText;
  const CustomTextFormField(
      {Key? key,
      required this.controller,
      required this.label,
      required this.icon,
      this.onChanged,
      required this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '*This field is required';
          }
          return null;
        },
        controller: controller,
        keyboardType: TextInputType.emailAddress,
        style: const TextStyle(color: Colors.black87),
        obscureText: obscureText,
        decoration: InputDecoration(
            prefixIcon: icon,
            label: Text(label),
            filled: true,
            errorStyle: const TextStyle(color: Colors.red),
            // fillColor: const Color(0xffE6F2F6),
            border: const OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(20)))),
      ),
    );
  }
}
