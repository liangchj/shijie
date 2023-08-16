
import 'package:flutter/material.dart';

class PersonalCenterPage extends StatefulWidget {
  const PersonalCenterPage({Key? key}) : super(key: key);

  @override
  State<PersonalCenterPage> createState() => _PersonalCenterPageState();
}

class _PersonalCenterPageState extends State<PersonalCenterPage> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("个人中心"),
    );
  }
}
