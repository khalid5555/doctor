import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qr_scanner/app/core/shared/utils/app_colors.dart';
import 'package:qr_scanner/app/data/models/qr_product_model.dart';

import '../shared/widgets/app_text.dart';

class QrCard extends StatelessWidget {
  final QrProductModel student;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final int? index;
  const QrCard(
      {super.key,
      required this.student,
      required this.onEdit,
      this.index,
      required this.onDelete});
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Colors.teal,
      clipBehavior: Clip.hardEdge,
      // surfaceTintColor: Colors.lightGreen,
      margin: const EdgeInsets.all(10),
      child: InkWell(
        // onDoubleTap: () => Get.to(
        //   () => CustomerDetailPage(client: client),
        // ),
        child: Container(
          padding: const EdgeInsets.all(10),
          color: index!.isEven
              ? AppColors.kTeal.withOpacity(.2)
              : AppColors.kYellow.withOpacity(.3),
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Center(
                      child: App_Text(
                    data: "الاسم : ${student.name}",
                    size: 15,
                  )),
                  App_Text(data: "السعر : ${student.price}", size: 12),
                  App_Text(
                    data: "الوصف : ${student.description}",
                    size: 12,
                    maxLine: 6,
                  ),
                  App_Text(
                    data: "الكمية الموجودة : ${student.quantity}",
                    size: 12,
                    color: AppColors.kLightBlue,
                  ),
                  App_Text(
                    data: " الكود : ${student.qrCode}",
                    size: 12,
                    maxLine: 3,
                  ),
                  App_Text(
                    data: "${student.id} : id ",
                    size: 12,
                    direction: TextDirection.ltr,
                  )
                  // App_Text(
                  //   data: "الفصل الدراسي : ${student.studyCourse}",
                  //   size: 12,
                  // ),
                  // App_Text(
                  //   data: "التفاصيل : ${student.desc}",
                  //   size: 12,
                  //   color: AppColors.kTeal,
                  //   maxLine: 6,
                  // ),
                ],
              ),
              Positioned(
                top: Get.height * 0,
                // left: 0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: onEdit,
                      color: Colors.teal,
                      tooltip: 'Edit',
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: onDelete,
                      color: Colors.red,
                      tooltip: 'Delete',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
