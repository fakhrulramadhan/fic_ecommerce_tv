import 'package:flutter/material.dart';

//butuh custom button utk kondisional login / daftar pada file auth_page.dart

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap; //ontap tipe datanya berupa fungsi
  final Color? color; //color tipe datanya warna, enggak wajib pakai ?
  const CustomButton(
      {super.key, required this.text, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          //size(uk.lebar, uk.tinggi)
          minimumSize: const Size(double.infinity, 50),
          backgroundColor: Colors.red),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
            //kalau warnanya kosong, pakai warna putih
            color: color == null ? Colors.white : Colors.black),
      ),
    );
  }
}
