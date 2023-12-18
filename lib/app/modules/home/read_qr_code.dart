import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/app/core/shared/utils/app_colors.dart';

import '../../core/shared/widgets/app_text.dart';
import '../add_info/add_info_controller.dart';

class ReadQrCode extends StatefulWidget {
  const ReadQrCode({Key? key}) : super(key: key);
  @override
  _ReadQrCodeState createState() => _ReadQrCodeState();
}

class _ReadQrCodeState extends State<ReadQrCode> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(),
      body: QRViewExample(),
    );
  }
}

class QRViewExample extends StatefulWidget {
  const QRViewExample({Key? key}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _QRViewExampleState();
}

class _QRViewExampleState extends State<QRViewExample> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  AddInfoController addInfoController = Get.find<AddInfoController>();
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    addInfoController.getAllQrCode();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 1, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    if (result != null &&
                        addInfoController.productsList
                            .any((e) => e.qrCode == result!.code))
                      DecoratedBox(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: AppColors.kCyan,
                        ),
                        child: Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                App_Text(
                                    data:
                                        'اسم المنتج: ${addInfoController.productsList.firstWhere((element) => element.qrCode == result!.code).name}'),
                                App_Text(
                                    data:
                                        'السعر: ${addInfoController.productsList.firstWhere((element) => element.qrCode == result!.code).price}'),
                                App_Text(
                                    data:
                                        'الكمية: ${addInfoController.productsList.firstWhere((element) => element.qrCode == result!.code).quantity}'),
                                App_Text(
                                  maxLine: 3,
                                  data:
                                      'الوصف: ${addInfoController.productsList.firstWhere((element) => element.qrCode == result!.code).description}',
                                ),
                                App_Text(
                                    maxLine: 3,
                                    data:
                                        'الكود: ${addInfoController.productsList.firstWhere((element) => element.qrCode == result!.code).qrCode}'),
                                App_Text(
                                    data:
                                        'الرقم: ${addInfoController.productsList.firstWhere((element) => element.qrCode == result!.code).id}'),
                              ],
                            ),
                          ),
                        ),
                      )
                    /* Flexible(
                            child: App_Text(
                                direction: TextDirection.ltr,
                                maxLine: 20,
                                data:
                                    'Barcode Type: ${result!.format.name}\nData: ${result!.code}'),
                          ) */
                    else
                      const App_Text(data: ' امسح الباركود'),
                    /*   Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await controller?.toggleFlash();
                                    setState(() {});
                                  },
                                  child: FutureBuilder(
                                    future: controller?.getFlashStatus(),
                                    builder: (context, snapshot) {
                                      return Text('Flash: ${snapshot.data}');
                                    },
                                  )),
                            ),
                            Container(
                              margin: const EdgeInsets.all(8),
                              child: ElevatedButton(
                                  onPressed: () async {
                                    await controller?.flipCamera();
                                    setState(() {});
                                  },
                                  child: FutureBuilder(
                                    future: controller?.getCameraInfo(),
                                    builder: (context, snapshot) {
                                      if (snapshot.data != null) {
                                        return App_Text(
                                            size: 10, data: ' ${snapshot.data!}');
                                      } else {
                                        return const Text('loading');
                                      }
                                    },
                                  )),
                            )
                          ],
                        ), */
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller?.pauseCamera();
                            },
                            child: const App_Text(
                              data: 'توقف الكاميرا',
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(8),
                          child: ElevatedButton(
                            onPressed: () async {
                              await controller?.resumeCamera();
                            },
                            child: const App_Text(
                              data: 'اعادة تشغيل',
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: OutlinedButton(
                        onPressed: () async {
                          // Get.to(() => AddInfoPage(), arguments: result?.code!);
                          /*  if (result != null) {
                                Get.to(() => AddInfoPage(), arguments: result?.code!);
                              } else {
                                Get.snackbar('Error', 'No result found',
                                    backgroundColor: AppColors.kRED,
                                    icon: const Icon(Icons.error),
                                    colorText: AppColors.kWhite);
                              } */
                        },
                        child: const App_Text(
                          data: 'حفظ المنتج',
                          size: 20,
                          color: AppColors.kRED,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 320.0
        : 300.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.cyan,
        borderRadius: 10,
        borderLength: 20,
        borderWidth: 5,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
