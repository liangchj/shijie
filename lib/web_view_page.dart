
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:webview_flutter/webview_flutter.dart';
const htmlString = '''
<!DOCTYPE html>
<head>
<title>webview demo | IAM17</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0, 
  maximum-scale=1.0, user-scalable=no,viewport-fit=cover" />
<style>
*{
  margin:0;
  padding:0;
}
body{
   background:#BBDFFC;  
   display:flex;
   justify-content:center;
   align-items:center;
   height:100px;
   color:#C45F84;
   font-size:20px;
}
</style>
</head>
<html>
<body>
<div >大家好，我是 17</div>
</body>
</html>
''';


class WebViewPage extends StatefulWidget {
  const WebViewPage({Key? key}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  late final WebViewController controller;
  double height = 0;
  @override
  void initState() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadRequest(Uri.parse('https://www.360kan.com'))
      // ..loadHtmlString(htmlString);
      ..setNavigationDelegate(NavigationDelegate(
          onNavigationRequest: (request) {
              Logger().e("发起请求：");
              return NavigationDecision.navigate;
          },
      ))

      ;
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Expanded(child: WebViewWidget(controller: controller))],
      ),
    );
  }

}
