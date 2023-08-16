import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shijie/constant/base_constant.dart';
import 'package:shijie/utils/permission_utils.dart';

class ShiJieApp extends StatelessWidget {
  const ShiJieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "jin player",
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ShiJieAppPage(),
    );
  }
}

class ShiJieAppPage extends StatefulWidget {
  const ShiJieAppPage({Key? key}) : super(key: key);

  @override
  State<ShiJieAppPage> createState() => _ShiJieAppPageState();
}

class _ShiJieAppPageState extends State<ShiJieAppPage> {
  // 是否已经申请权限
  bool _requestPermission = false;
  int _currentIndex = 0;
  late PageController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    if (!_requestPermission) {
      _handleRequestPermission();
    }
    _tabController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  /// 申请权限
  void _handleRequestPermission() {
    List<Permission> permissionList = BaseConstant.requestPermissionList;
    PermissionUtils.checkPermission(
        permissionList: permissionList,
        onPermissionCallback: (flag) {
          Logger().d("flag: $flag");
          if (flag) {
            setState(() {
              _requestPermission = flag;
            });
          } else {
            // 拒绝权限推出app
            exit(0);
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: BaseConstant.tabPageList,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          items: BaseConstant.bottomTabList,
          selectedFontSize: 12.0,
          onTap: (pageIndex) {
            if (pageIndex != _currentIndex) {
              _tabController.jumpToPage(pageIndex);
              setState(() => {_currentIndex = pageIndex});
            }
          },
        ));
  }
}
