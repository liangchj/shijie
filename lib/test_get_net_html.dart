
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:jin_net/jin_net.dart';
import 'package:jin_net/request/jin_net_request.dart';
import 'package:logger/logger.dart';
import 'package:html/parser.dart';
// import 'package:html/dom.dart';

class TestGetHtml extends StatefulWidget {
  const TestGetHtml({Key? key}) : super(key: key);

  @override
  State<TestGetHtml> createState() => _TestGetHtmlState();
}

class _TestGetHtmlState extends State<TestGetHtml> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            gg();
            // get();
          },
          child: Text("获取"),
        ),
      ),
    );
  }


  gg() async {
    var dio = Dio();
    var response = await dio.get('www.baidu.com');
    var document = parse(response.data);
    var elements = document.querySelectorAll('a');
    for (var element in elements) {
      print(element.text);
    }
  }

  get() async {
    Logger logger = Logger();
    KanRequest request = KanRequest();
    request.setBaseUrl("www.360kan.com");
    var result = await JinNet.getInstance().fire(request);
    logger.e(result);
    // print(result);
  }
}

class KanRequest extends JinNetRequest {
  String? baseUrl;
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return "";
  }

  @override
  String authority() {
    return baseUrl ?? super.authority();
  }

  void setBaseUrl(String url) {
    baseUrl = url;
  }
}
