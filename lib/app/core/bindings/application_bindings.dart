import 'package:get/get.dart';

import '../../modules/home/home_binding.dart';

class ApplicationBindings extends Bindings {
  @override
  void dependencies() {
    HomeBinding();
  }
}
