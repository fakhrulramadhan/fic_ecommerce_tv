import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLines;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.maxLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.black,
                ))),
        validator: (val) {
          //jika tidak ada inputan
          if (val == null || val.isEmpty) {
            //return "enter your hinttext";
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text(
                "$hintText wajib diisi",
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ));
          }
          return null;
        },
        maxLines: maxLines //jumlah max baris
        );
  }
}
