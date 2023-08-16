
import 'package:flutter/material.dart';

class NetResourcePage extends StatefulWidget {
  const NetResourcePage({Key? key}) : super(key: key);

  @override
  State<NetResourcePage> createState() => _NetResourcePageState();
}

class _NetResourcePageState extends State<NetResourcePage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("网络资源"),
    );
  }
}
