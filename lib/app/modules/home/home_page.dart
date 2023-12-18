import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_scanner/app/core/shared/widgets/app_text.dart';
import 'package:qr_scanner/app/modules/home/read_qr_code.dart';

import '../../core/shared/utils/app_colors.dart';
import '../add_info/add_info_controller.dart';
import '../add_info/add_info_page.dart';
import '../add_info/showproduct.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final AddInfoController controller = Get.put(AddInfoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: AppColors.kTeal,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(8),
              child: OutlinedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.kGreen)),
                onPressed: () {
                  Get.to(() => const QRViewExample());
                },
                child: const App_Text(
                  data: 'اضافة كود منتج جديد',
                  size: 18,
                  color: AppColors.kWhite,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: OutlinedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.kYellow)),
                onPressed: () {
                  Get.to(() => const ReadQrCode());
                },
                child: const App_Text(
                  data: 'قراءة كود المنتج',
                  size: 18,
                  color: AppColors.kBlACK,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(8),
              child: OutlinedButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(AppColors.kCyan)),
                onPressed: () async {
                  // controller.getAllQrCode();
                  Get.to(() => const ShowProduct());
                  printInfo(
                      info:
                          ' product.length   ${controller.productsList.length}');
                },
                child: const App_Text(
                  data: ' الباركود المحفوظ',
                  size: 18,
                  color: AppColors.kPink,
                ),
              ),
            ),
          ],
        ),
      ),
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 1, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  if (result != null)
                    Flexible(
                      child: App_Text(
                          direction: TextDirection.ltr,
                          maxLine: 20,
                          data:
                              'نوع الباركود: ${result!.format.name}\nرقم الباركود : ${result!.code}'),
                    )
                  else
                    const App_Text(data: 'أمسح الباركود'),
                  Row(
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
                                return App_Text(
                                  data: 'الفلاش: ${snapshot.data}',
                                  // size: 20,
                                  color: AppColors.kTeal,
                                );
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
                                      size: 12,
                                      data:
                                          'وضع الكاميرا : ${snapshot.data!.toString().split('.')[1]}');
                                } else {
                                  return const Text('loading');
                                }
                              },
                            )),
                      )
                    ],
                  ),
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
                            data: "توقف الكاميرا",
                            // size: 20,
                            color: AppColors.kRED,
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
                            data: 'أعادة تشغيل',
                            // size: 20,
                            color: AppColors.kGreen,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    child: OutlinedButton(
                      onPressed: () async {
                        Get.to(() => AddInfoPage(), arguments: result?.code!);
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
                        data: 'تسجيل منتج جديد',
                        size: 20,
                        color: AppColors.kRED,
                      ),
                    ),
                  ),
                ],
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
        borderColor: Colors.teal,
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
      Get.snackbar('أنتبه', 'الرجاء السماح للوصول للكاميرا');
      /* ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      ); */
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
/* 
class HomePage extends GetView<HomeController> {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: QRView(
              key: controller.qrKey,
              overlay: QrScannerOverlayShape(
                borderColor: AppColors.kCyan,
                borderRadius: 20,
                // cutOutSize: 20,
                borderLength: 20,
              ),
              onQRViewCreated: controller.onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Obx(() => Text('Scan result: ${controller.qrText.value}')),
            ),
          ),
        ],
      ),
    );
  }
  /* void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      qrText.value = scanData;
      _writeToFile(scanData);
    });
  } */
  /* Future<void> _writeToFile(String data) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/my_file.txt');
    await file.writeAsString(data);
  } */
}
 */