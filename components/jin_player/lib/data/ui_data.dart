
import 'package:flutter/material.dart';

/// UI需要的数据
class UIData {
  static List<Color> gradientBackground = [
    Colors.black54,
    Colors.black45,
    Colors.black38,
    Colors.black26,
    Colors.black12,
    Colors.transparent
  ];
  static Duration uiShowAnimationDuration = const Duration(milliseconds: 300);
  static Duration uiHideAnimationDuration = const Duration(milliseconds: 300);
  static Duration iconChangeDuration = const Duration(milliseconds: 75);
  static Duration uiShowDuration = const Duration(seconds: 5);
}
