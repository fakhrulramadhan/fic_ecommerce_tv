import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:fic_ecommerce_tv/presentation/home/home_page.dart';

class PaymentSuccesfullPage extends StatefulWidget {
  const PaymentSuccesfullPage({super.key});

  @override
  State<PaymentSuccesfullPage> createState() => _PaymentSuccesfullPageState();
}

class _PaymentSuccesfullPageState extends State<PaymentSuccesfullPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      AwesomeDialog(
              context: context,
              dialogType: DialogType.success,
              title: "Payment Success",
              desc: "Pembayaran anda berhasil dilakukan",
              btnOkOnPress: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              btnOkColor: Colors.green,
              btnOkText: "OK")
          .show();
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
