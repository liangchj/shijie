

import 'package:get/get.dart';
import 'package:shijie/getx_controller/localVideoDirectoryListController.dart';
import 'package:shijie/getx_controller/net_resource_home_controller.dart';
import 'package:shijie/getx_controller/play_directory_controller.dart';
import 'package:shijie/getx_controller/search_barrage_subtitle_controller.dart';
import 'package:shijie/getx_controller/video_file_controller.dart';
import 'package:shijie/pages/local_video_directory_list_page.dart';
import 'package:shijie/pages/net_resource_home_page.dart';
import 'package:shijie/pages/play_directory_list_page.dart';
import 'package:shijie/pages/search_barrage_subtitle_page.dart';
import 'package:shijie/pages/video_file_list_page.dart';
import 'package:shijie/route/app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.netResourceHomePage,
        page: () => const NetResourceHomePage(),
        binding: BindingsBuilder(
                () => Get.lazyPut(() => NetResourceHomeController()))),
    GetPage(
        name: AppRoutes.localVideoDirectory,
        page: () => const LocalVideoDirectoryListPage(),
        binding: BindingsBuilder(
                () => Get.lazyPut(() => LocalVideoDirectoryListController()))),
    GetPage(
      name: AppRoutes.videoFileList,
      page: () => const VideoFileListPage(),
      bindings: [
        BindingsBuilder(
                () => Get.lazyPut(() => VideoFileController())),
        BindingsBuilder(
                () => Get.lazyPut(() => PlayDirectoryListController()))
      ],
      /*binding: BindingsBuilder(
                () => Get.lazyPut(() => VideoFileController()))*/
    ),
    GetPage(
        name: AppRoutes.playDirectoryList,
        page: () => const PlayDirectoryListPage(),
        binding: BindingsBuilder(
                () => Get.lazyPut(() => PlayDirectoryListController()))),

    GetPage(
        name: AppRoutes.searchBarrageSubtitle,
        page: () => const SearchBarrageSubtitlePage(),
        binding: BindingsBuilder(
                () => Get.lazyPut(() => SearchBarrageSubtitleController()))),
  ];
}