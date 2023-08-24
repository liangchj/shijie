import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shijie/cache/mmkv_cache.dart';
import 'package:shijie/http/dao/recommend_dao.dart';
import 'package:shijie/pages/full_play.dart';
import 'package:shijie/pages/net_resource_home_page.dart';
import 'package:shijie/pages/resource_category_page.dart';
import 'package:shijie/pages/video_detail_page.dart';
import 'package:shijie/route/app_pages.dart';
import 'package:shijie/route/app_routes.dart';
import 'package:shijie/shi_jie_app.dart';
import 'package:shijie/test_get_net_html.dart';
import 'package:shijie/test_player.dart';
import 'package:shijie/test_share.dart';
import 'package:shijie/utils/permission_utils.dart';
import 'package:shijie/web_view_page.dart';

import 'dan_page.dart';
import 'test_ui.dart';

void main() {
  /*MMKVCacheInit.preInit();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    getPages: AppPages.pages,
    home: const ShiJieApp(),
  ));*/
  MMKVCacheInit.preInit();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(GetMaterialApp(
    getPages: AppPages.pages,
    home: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
        // here
        navigatorObservers: [FlutterSmartDialog.observer],
        // here
        builder: FlutterSmartDialog.init(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;
  /// 是否已经申请权限
  bool _requestPermission = false;

  void _incrementCounter() {
    // Get.toNamed(AppRoutes.netResourceHomePage);
    // Get.to(ResourceCategoryPage());
    // Get.to(FullPlay(), duration: Duration(seconds: 0));
    // Get.to(DanPage());
    // Get.to(WebViewPage());
    // Get.to(TestGetHtml());
    Get.to(const TestUI());
    // Get.to(const TestShare());
    // Get.to(const TestPlayer());
    // Get.to(VideoDetailPage(), preventDuplicates: true);
    // RecommendDao.get();
    /*SmartDialog.show(
      alignment: Alignment.bottomCenter,
      builder: (_) => Container(
        color: Colors.cyanAccent,
        child: Text("右边弹窗"),
      ),
    );*/
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //2.页面初始化的时候，添加一个状态的监听者
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //3. 页面销毁时，移出监听者
    WidgetsBinding.instance.removeObserver(this);
  }

  //监听程序进入前后台的状态改变的方法
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    switch (state) {
    //进入应用时候不会触发该状态 应用程序处于可见状态，并且可以响应用户的输入事件。它相当于 Android 中Activity的onResume
      case AppLifecycleState.resumed:
        print("应用进入前台======");
        break;
    //应用状态处于闲置状态，并且没有用户的输入事件，
    // 注意：这个状态切换到 前后台 会触发，所以流程应该是先冻结窗口，然后停止UI
      case AppLifecycleState.inactive:
        print("应用处于闲置状态，这种状态的应用应该假设他们可能在任何时候暂停 切换到后台会触发======");
        break;
    //当前页面即将退出
      case AppLifecycleState.detached:
        print("当前页面即将退出======");
        break;
    // 应用程序处于不可见状态
      case AppLifecycleState.paused:
        print("应用处于不可见状态 后台======");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_requestPermission) {
      // List<Permission> permissionList = [Permission.storage, Permission.manageExternalStorage];
      List<Permission> permissionList = [Permission.storage, Permission.manageExternalStorage];
      PermissionUtils.checkPermission(permissionList: permissionList, onPermissionCallback: (flag) {
        print("flag: $flag");
        setState((){
          _requestPermission = flag;
        });
      });
    }
    print("主页build");
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
