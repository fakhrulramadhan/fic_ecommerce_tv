import 'package:fic_ecommerce_tv/presentation/payment/payment_failed_page.dart';
import 'package:fic_ecommerce_tv/presentation/payment/payment_successfull_page.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// import 'package:fic_ecommerce_tv/presentation/payment/payment_failed_page.dart';
// import 'package:fic_ecommerce_tv/presentation/payment/payment_successfull_page.dart';

//snap widget untuk debagai decision webview utk callback pembayaran
//ke midtrans

class SnapWidget extends StatefulWidget {
  String url;
  SnapWidget({
    Key? key,
    required this.url,
  }) : super(key: key);

  @override
  State<SnapWidget> createState() => _SnapWidgetState();
}

class _SnapWidgetState extends State<SnapWidget> {
  //pakai webview
  WebViewController? _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color.fromARGB(255, 255, 255, 255))
      ..setNavigationDelegate(NavigationDelegate(
        onProgress: (progress) {},
        //ketika halaman dibuka, mau diarahin kemana (tergantung
        // status pembayaran)
        onPageStarted: (String url) {
          print("Mulai di halaman $url");

          //JIKA URL MENGANDUNG KATA TREANSACTION STATUSNYA DITOLAK
          if (url.contains('status_code=202&transaction_status=deny')) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PaymentFailedPage()),
            );
          }

          if (url.contains('status_code-200&transaction_status=settlement')) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const PaymentSuccesfullPage()),
            );
          }
        },
        onPageFinished: (url) {},

        onWebResourceError: (error) {},

        //ketika urlnya ada youtube, maka dicegah ke halaman selanjutnya
        // (payment success / fail)
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith("https://www.youtube.com/")) {
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        },
      ))
      ..loadRequest(Uri.parse(widget.url)); //cara akases url pakai widget
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(controller: _controller!);
  }
}
