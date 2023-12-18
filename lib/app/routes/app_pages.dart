import 'home_routes.dart';
import 'add_info_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = '/home';

  static final routes = [
    ...HomeRoutes.routes,
		...AddInfoRoutes.routes,
  ];
}
