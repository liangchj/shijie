import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shijie/pages/media_library_page.dart';
import 'package:shijie/pages/net_resource_page.dart';
import 'package:shijie/pages/personal_center_page.dart';

abstract class BaseConstant {
  // 需要申请的权限
  static List<Permission> requestPermissionList = [
    Permission.storage,
    Permission.mediaLibrary,
    Permission.manageExternalStorage
  ];

  // 主页tab页面
  static List<BottomNavigationBarItem> bottomTabList = [
    const BottomNavigationBarItem(label: "网络视频", icon: Icon(Icons.home)),
    const BottomNavigationBarItem(
        label: "媒体库", icon: Icon(Icons.video_collection_rounded)),
    const BottomNavigationBarItem(
        label: "我的", icon: Icon(Icons.people_alt_rounded)),
  ];

  static List<Widget> tabPageList = [const NetResourcePage(), const MediaLibraryPage(), const PersonalCenterPage()];


}
