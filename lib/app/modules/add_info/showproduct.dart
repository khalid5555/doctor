import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scanner/app/core/shared/utils/app_colors.dart';
import 'package:qr_scanner/app/core/shared/utils/show_loading.dart';
import 'package:qr_scanner/app/core/shared/widgets/app_text.dart';
import 'package:qr_scanner/app/core/widgets/qr_card.dart';
import 'package:qr_scanner/app/modules/add_info/add_info_controller.dart';

class ShowProduct extends StatefulWidget {
  const ShowProduct({Key? key}) : super(key: key);
  @override
  _ShowProductState createState() => _ShowProductState();
}

class _ShowProductState extends State<ShowProduct> {
  AddInfoController controller = Get.find<AddInfoController>();
  @override
  void initState() {
    super.initState();
    controller.getAllQrCode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          OutlinedButton(
            onPressed: () {
              // controller.deleteDatabase();
            },
            child: const App_Text(
              data: "حذف",
              size: 12,
            ),
          )
        ],
        title: const App_Text(
          data: 'قائمة المنتجات المحفوظة',
          color: AppColors.kTeal,
        ),
      ),
      body: GetBuilder<AddInfoController>(
        builder: (_) => controller.productsList.isEmpty
            ? const Center(child: ShowLoading())
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: controller.productsList.length,
                itemBuilder: (BuildContext context, int index) {
                  final qr = controller.productsList[index];
                  return QrCard(
                    index: index,
                    student: qr,
                    onEdit: () {},
                    onDelete: () {
                      // DatabaseHelper.delete(qr.id!);
                      controller.deleteById(qr.id!);
                    },
                  );
                },
              ),
      ),
    );
  }
}
