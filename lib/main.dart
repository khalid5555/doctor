import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/core/bindings/application_bindings.dart';
import 'app/data/repositories/database_helper.dart';
import 'app/modules/add_info/add_info_controller.dart';
import 'app/modules/home/home_controller.dart';
import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DatabaseHelper.initDb();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put<AddInfoController>(AddInfoController());
    Get.put<HomeController>(HomeController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QrScanner',
      defaultTransition: Transition.fade,
      initialBinding: ApplicationBindings(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
