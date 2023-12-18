import 'package:get/get.dart';

import '../modules/add_info/add_info_binding.dart';
import '../modules/add_info/add_info_page.dart';

class AddInfoRoutes {
  AddInfoRoutes._();
  static const addInfo = '/add-info';
  static const showProduct = '/add-info/show-product';
  static final routes = [
    GetPage(
      name: addInfo,
      page: () => AddInfoPage(),
      binding: AddInfoBinding(),
    ),
  ];
}
