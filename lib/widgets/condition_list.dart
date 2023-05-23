import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shijie/getx_controller/condition_list_controller.dart';
/// 条件栏
class ConditionList extends StatelessWidget {
  ConditionList(
      {Key? key,
      this.activeTextColor,
      this.activeBackgroundColor,
      this.horizontalPadding,
      this.verticalPadding,
      this.textHorizontalPadding,
      this.textVerticalPadding, this.textBorderRadius})
      : super(key: key);
  final Color? activeTextColor;
  final Color? activeBackgroundColor;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double? textHorizontalPadding;
  final double? textVerticalPadding;
  final BorderRadiusGeometry? textBorderRadius;

  final ConditionListController _conditionListController = Get.find<ConditionListController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _conditionListController.conditionList.map((element) {
          return Padding(padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0, horizontal: horizontalPadding ?? 6.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: element.titleList.asMap().entries.map((e) {
                  bool active = (element.activeIndexList ?? []).contains(e.key);
                  return InkWell(
                    onTap: () {
                      if (!(element.activeIndexList ?? []).contains(e.key)) {
                        element.activeIndexList.clear();
                        element.activeIndexList.add(e.key);
                        _conditionListController.conditionList.refresh();
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: textVerticalPadding ?? 4.0, horizontal: textHorizontalPadding ?? 8.0),
                        decoration: BoxDecoration(
                            color: active
                                ? activeBackgroundColor ?? Colors.black12
                                : null,
                            borderRadius: textBorderRadius ?? const BorderRadius.all(Radius.circular(4.0))),

                        child: Text(e.value, style: TextStyle(color: active ? activeTextColor ?? Colors.green : null),)),
                  );
                }
                ).toList(),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
