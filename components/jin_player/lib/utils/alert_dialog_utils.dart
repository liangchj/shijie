import 'package:flutter/material.dart';

class AlertDialogUtils {
  /// 弹出一个确认操作
  /// [maxContentHeight] 对话框内容最大高度，可为空，为空的情况默认取屏幕高度的75%
  /// [buildContext] 构建需要的content
  /// [title] 对话框标题，可为空，默认显示“提示”
  /// [content] 对话框内容
  /// [confirmText] 确认按钮文字
  /// [cancelText] 取消按钮文字
  static Future<bool?> modalConfirmAlertDialog(
      {double? maxContentHeight,
      required BuildContext buildContext,
      String? title,
      required Widget content,
      required String confirmText,
      required String cancelText}) {
    var of = MediaQuery.of(buildContext);
    double maxHeight = maxContentHeight ?? of.size.height * 0.75;
    return showDialog<bool>(
        context: buildContext,
        builder: (context) {
          var navigator = Navigator.of(context);
          return AlertDialog(
            title: Text(title ?? "提示"),
            content: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight //最小高度为50像素
                    ),
                child: SingleChildScrollView(child: content)),
            actions: <Widget>[
              TextButton(
                child: Text(cancelText),
                onPressed: () {
                  navigator.pop();
                }, //关闭对话框
              ),
              TextButton(
                child: Text(confirmText),
                onPressed: () {
                  // ... 执行删除操作
                  navigator.pop(true); //关闭对话框
                },
              ),
            ],
          );
        });
  }
  /// 弹出一个仅有输入框的操作操作
  /// [maxContentHeight] 对话框内容最大高度，可为空，为空的情况默认取屏幕高度的75%
  /// [buildContext] 构建需要的content
  /// [title] 对话框标题，可为空，默认显示“提示”
  /// [content] 对话框内容
  /// [confirmText] 确认按钮文字
  /// [cancelText] 取消按钮文字
  static Future<bool?> modalInputAlertDialog(
      {double? maxContentHeight,
        required BuildContext buildContext,
        String? title,
        required Widget content,
        required String confirmText,
        required String cancelText}) {
    var of = MediaQuery.of(buildContext);
    double maxHeight = maxContentHeight ?? of.size.height * 0.75;
    return showDialog<bool>(
        context: buildContext,
        builder: (context) {
          var navigator = Navigator.of(context);
          return AlertDialog(
            title: Text(title ?? "提示"),
            content: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight //最小高度为50像素
                ),
                child: SingleChildScrollView(child: content)),
            actions: <Widget>[
              TextButton(
                child: Text(cancelText),
                onPressed: () {
                  navigator.pop();
                }, //关闭对话框
              ),
              TextButton(
                child: Text(confirmText),
                onPressed: () {
                  // ... 执行删除操作
                  navigator.pop(true); //关闭对话框
                },
              ),
            ],
          );
        });
  }
}
