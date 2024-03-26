import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// ignore: must_be_immutable
class Screen_XemKetQuaCls extends StatefulWidget {
  String Url;
  Screen_XemKetQuaCls({super.key, required this.Url});

  @override
  State<Screen_XemKetQuaCls> createState() => _Screen_XemKetQuaClsState();
}

class _Screen_XemKetQuaClsState extends State<Screen_XemKetQuaCls> {
  late InAppWebViewController inApp;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Kết quả cận lầm sàng')),
      body: InAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(widget.Url)),
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            supportZoom: true,
          ),
          android: AndroidInAppWebViewOptions(
            initialScale: 100,
          ),
        ),
        onWebViewCreated: (InAppWebViewController controller) {
          inApp = controller;
        },
        onLoadStart: (InAppWebViewController controller, url) {},
        onLoadStop: (InAppWebViewController controller, url) {},
      ),
    );
  }
}
