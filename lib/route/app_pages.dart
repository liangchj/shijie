

import 'package:get/get.dart';
import 'package:shijie/getx_controller/net_resource_home_controller.dart';
import 'package:shijie/pages/net_resource_home_page.dart';
import 'package:shijie/route/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.netResourceHomePage,
        page: () => const NetResourceHomePage(),
        binding: BindingsBuilder(
                () => Get.lazyPut(() => NetResourceHomeController()))),
  ];
}