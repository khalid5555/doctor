import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class HomeController extends GetxController {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;
  // final qrKey = GlobalKey(debugLabel: 'QR');
  // QRViewController? controller;
  final RxString qrText = ''.obs;
  @override
  void onInit() {
    super.onInit();
    _requestCameraPermission();
  }

  void onQRViewCreated(QRViewController controller) async {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      qrText.value = scanData.toString();
      _writeToFile(scanData.toString());
    });
  }

  Future<void> _writeToFile(String data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/my_file.txt');
    await file.writeAsString(data);
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.status;
    if (!status.isGranted) {
      await Permission.camera.request();
    }
  }
  /* @override
  dispose() {
    controller?.dispose();
    super.dispose();
  } */
}
