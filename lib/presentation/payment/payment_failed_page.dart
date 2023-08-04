import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../home/home_page.dart';

class PaymentFailedPage extends StatefulWidget {
  const PaymentFailedPage({super.key});

  @override
  State<PaymentFailedPage> createState() => _PaymentFailedPageState();
}

class _PaymentFailedPageState extends State<PaymentFailedPage> {
  //ketika dipanggil halaman ini, langsung muncul pesan gagal
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: "Payment Failed",
        desc: "Maaf, Status Pembayaran anda gagal",
        //ketika tbl ok ditekan, mengarah ke home page
        btnOkOnPress: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        btnOkText: "Tutup",

        btnOkColor: Colors.redAccent,
      ).show(); //show utk ditampilkan
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
