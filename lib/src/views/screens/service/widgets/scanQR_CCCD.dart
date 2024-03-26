import 'dart:io';

import 'package:app/src/views/screens/service/provider/CCCD.dart';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQR_CCCD extends StatefulWidget {
  const ScanQR_CCCD({super.key});

  @override
  State<ScanQR_CCCD> createState() => _ScanQR_CCCDState();
}

class _ScanQR_CCCDState extends State<ScanQR_CCCD> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  @override
  void reassemble() {
    try {
      super.reassemble();
      if (Platform.isAndroid) {
        controller!.pauseCamera();
      } else if (Platform.isIOS) {
        controller!.resumeCamera();
      }
    } catch (e) {}
  }

  void _onQRViewCreated(QRViewController controller) {
    try {
      this.controller = controller;
      controller.scannedDataStream.listen(
        (scanData) {
          setState(() {
            result = scanData;
          });

          var cccd = readCCCD('${scanData.code}');
          if (cccd != null) {
            controller.pauseCamera();
            Navigator.of(context).pop(CCCDToJson(cccd));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Không phải thẻ căn cước')));
          }
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  showTutorial() => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Hướng dẫn quét mã QR"),
                Opacity(
                  opacity: .5,
                  child:
                      Image.asset("assets/images/service/cccd.png", width: 300),
                ),
              ],
            ),
          ),
        ),
      );

  CCCD? readCCCD(String data) {
    try {
      var getcccd = data.split('|');

      toDatime(getcccd[3].toString());
      var cccd = CCCD(
        soCCCD: getcccd[0].toString(),
        soCmnd: getcccd[1].toString(),
        ten: getcccd[2].toString(),
        ngaySinh: toDatime(getcccd[3].toString()),
        gioiTinh: getcccd[4].toString(),
        diaChi: getcccd[5].toString(),
        ngayCap: toDatime(getcccd[6].toString()),
        qrcode: data,
      );
      print(cccd.toJson());
      return cccd;
    } catch (e) {
      print(e);
      return null;
    }
  }

  DateTime toDatime(String text) {
    var day = text.substring(0, 2);
    var mon = text.substring(2, 4);
    var year = text.substring(4);

    return DateTime(int.parse(year), int.parse(mon), int.parse(day));
  }

  double opacity = 0.6;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Container(
        child: Stack(
          children: [
            QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderRadius: 10,
                borderWidth: 6,
                borderColor: Colors.white,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: Text(
                      "Quét mã QR trên thẻ CCCD",
                      style: TextStyle(color: Colors.white70, fontSize: 17),
                    ),
                  ),
                  InkWell(
                    onTapDown: (details) {
                      setState(() {
                        opacity = 1;
                      });
                    },
                    onTapUp: (details) {
                      setState(() {
                        opacity = .6;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Opacity(
                          opacity: opacity,
                          child: Image.asset("assets/images/service/cccd.png",
                              width: 300),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
