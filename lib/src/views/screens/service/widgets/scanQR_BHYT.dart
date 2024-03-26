import 'dart:convert';
import 'dart:io';
import 'package:convert/convert.dart';
import 'package:app/src/views/screens/service/provider/BHYT.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQR_BHYT extends StatefulWidget {
  const ScanQR_BHYT({super.key});

  @override
  State<ScanQR_BHYT> createState() => _ScanQR_BHYTState();
}

class _ScanQR_BHYTState extends State<ScanQR_BHYT> {
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

          var BHYT = readBHYT('${scanData.code}');
          if (BHYT != null) {
            controller.pauseCamera();
            Navigator.of(context).pop(BHYTToJson(BHYT));
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
                      Image.asset("assets/images/service/bhyt.png", width: 300),
                ),
              ],
            ),
          ),
        ),
      );

  String hexToUtf8(String text) {
    List<int> bytes = hex.decode(text);
    String utf8String = utf8.decode(bytes);
    return utf8String;
  }

  DateTime toDatime(String text) {
    try {
      DateFormat date = DateFormat("dd/MM/yyyy");
      return date.parse(text);
    } catch (e) {
      print(e);
      return DateTime.now();
    }

    // return DateTime(int.parse(year), int.parse(mon), int.parse(day));
  }

  BHYT? readBHYT(String data) {
    try {
      var getbhyt = data.split('|');

      var bhyt = BHYT(
        maThe: getbhyt[0].toString(),
        hoTen: hexToUtf8(getbhyt[1].toString()),
        ngaySinh: toDatime(getbhyt[2].toString()),
        gioiTinh: int.parse(getbhyt[3].toString()),
        diaChi: getbhyt[4].toString(),
        maCoSo: getbhyt[5].toString(),
        hsdTuNgay: toDatime(getbhyt[6].toString()),
        hsdDenNgay: getbhyt[7].toString() != "-"
            ? toDatime(getbhyt[7].toString())
            : getbhyt[7].toString(),
        ngayCap: toDatime(getbhyt[8].toString()),
        maQuanLy: getbhyt[9].toString(),
        tenChaMe: getbhyt[10].toString(),
        maNoiSong: int.parse(getbhyt[11].toString()),
        thoiDiem5Nam: toDatime(getbhyt[12].toString()),
        chuoiKiemTra: getbhyt[13].toString(),
        maHuong: int.parse(getbhyt[14].toString()),
        noiCapDoithe: hexToUtf8(getbhyt[15].toString()),
        qrcode: data,
      );
      print(bhyt.toJson());
      return bhyt;
    } catch (e) {
      print(e);
      return null;
    }
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
                      "Quét mã QR trên thẻ BHYT",
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
                          child: Image.asset("assets/images/service/bhyt.png",
                              width: 200),
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
