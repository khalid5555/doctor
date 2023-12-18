import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scanner/app/core/shared/utils/app_colors.dart';
import 'package:qr_scanner/app/core/shared/widgets/app_text.dart';
import 'package:qr_scanner/app/core/shared/widgets/app_text_field.dart';

import '../../data/models/qr_product_model.dart';
import '../../data/repositories/database_helper.dart';
import 'add_info_controller.dart';

class AddInfoPage extends GetView<AddInfoController> {
  AddInfoPage({super.key});
  final String qr = Get.arguments ?? "";
  final DatabaseHelper databaseHelper = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    TextEditingController qrController = TextEditingController(text: qr);
    return Scaffold(
      backgroundColor: AppColors.kWhite,
      appBar: AppBar(
        title: const Text('اضافة منتج جديد '),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.kCyan,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              AppTextField(
                hint: 'لا يوجد باركود',
                color: AppColors.kBlue,
                icon: null,
                // min: 2,
                onChange: null,
                myController: qrController,
              ),
              const SizedBox(height: 15),
              AppTextField(
                hint: 'اسم المنتج',
                color: AppColors.kBlue,
                icon: null,
                onChange: null,
                myController: controller.nameCtl,
              ),
              const SizedBox(height: 15),
              AppTextField(
                hint: 'سعر المنتج',
                color: AppColors.kBlue,
                icon: null,
                onChange: null,
                textInputType: TextInputType.number,
                myController: controller.priceCtl,
              ),
              const SizedBox(height: 15),
              AppTextField(
                hint: 'موصفات المنتج',
                color: AppColors.kBlue,
                icon: null,
                onChange: null,
                myController: controller.descriptionCtl,
              ),
              const SizedBox(height: 15),
              AppTextField(
                hint: 'الكمية الموجودة',
                color: AppColors.kBlue,
                icon: null,
                onChange: null,
                textInputType: TextInputType.number,
                myController: controller.quantityCtl,
              ),
              const SizedBox(height: 35),
              OutlinedButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(AppColors.kWhite)),
                onPressed: () async {
                  if (qrController.text == '') {
                    Get.snackbar(
                      "",
                      "",
                      titleText: const App_Text(
                        data: 'أنتبة',
                        size: 20,
                        color: AppColors.kRED,
                      ),
                      messageText: const App_Text(
                        data: "لا يوجد باركود للاضافة",
                        size: 15,
                        color: AppColors.kPink,
                      ),
                      backgroundColor: AppColors.kCyan,
                    );
                  } else {
                    await databaseHelper.insertDocument(
                      QrProductModel(
                        // id: Random().nextInt(10000000).toString(),
                        name: controller.nameCtl.text,
                        price: controller.priceCtl.text,
                        description: controller.descriptionCtl.text,
                        quantity: controller.quantityCtl.text,
                        qrCode: qrController.text,
                      ),
                    );
                    printInfo(info: 'success');
                    Get.back();
                    qrController.clear();
                    controller.nameCtl.clear();
                    controller.priceCtl.clear();
                    controller.descriptionCtl.clear();
                    controller.quantityCtl.clear();
                  }
                },
                child: const App_Text(
                  data: 'حفظ منتج جديد',
                  size: 20,
                  color: AppColors.kRED,
                ),
              ), //get data
              /*  Container(
                margin: const EdgeInsets.all(8),
                child: OutlinedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(AppColors.kCyan)),
                  onPressed: () async {
                    if (qr == '') {
                      return;
                    } else {
                      await controller.getAllQrCode();
                      Get.to(() => const ShowProduct());
                      printInfo(
                          info:
                              ' product.length   ${controller.productsList.length}');
                    }
                  },
                  child: const App_Text(
                    data: ' الباركود المحفوظ',
                    size: 18,
                  ),
                ),
              ), */
            ],
          ),
        ),
      ),
    );
  }
}
