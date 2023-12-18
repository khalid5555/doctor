import 'package:get/get.dart';

import 'add_info_controller.dart';

class AddInfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddInfoController>(
      () => AddInfoController(),
    );
  }
}
