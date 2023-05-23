import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shijie/getx_controller/condition_list_controller.dart';
import 'package:shijie/model/resource_model.dart';
import 'package:shijie/widgets/condition_list.dart';
import 'package:shijie/widgets/resource_item.dart';

class ResourceCategoryPage extends StatefulWidget {
  const ResourceCategoryPage(
      {Key? key,
      this.horizontalShowItemNum = 3,
      this.bodyVerticalPadding = 10.0,
      this.bodyHorizontalPadding = 8.0})
      : super(key: key);
  final int? horizontalShowItemNum; // 横向显示数量
  final double? bodyVerticalPadding;
  final double? bodyHorizontalPadding;

  @override
  State<ResourceCategoryPage> createState() => _ResourceCategoryPageState();
}

class _ResourceCategoryPageState extends State<ResourceCategoryPage> {
  double get bodyHorizontalPadding => widget.bodyHorizontalPadding!;
  double get bodyVerticalPadding => widget.bodyVerticalPadding!;
  int get horizontalShowItemNum => widget.horizontalShowItemNum!;
  int get horizontalItemPaddingNum => (widget.horizontalShowItemNum! - 1) + 2; // 横线item padding数量
  final ConditionListController _conditionListController = Get.put(ConditionListController());
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    /// 获取设备size
    final Size size = MediaQuery.of(context).size;
    /// 设备宽度
    final double deviceWidth = size.width;
    /// 横向显示资源总宽度
    double horizontalItemTotalWidth = deviceWidth - (bodyHorizontalPadding * horizontalItemPaddingNum);
    /// 单个资源宽度
    double singleItemWidth = horizontalItemTotalWidth / horizontalShowItemNum;
    List<Widget> fList = [
      ResourceItem(resourceModel: ResourceModel("dd", "f", 8.0, 1), width: singleItemWidth),
      ResourceItem(resourceModel: ResourceModel("dd", "f", 8.0, 2), width: singleItemWidth),
      ResourceItem(resourceModel: ResourceModel("dd", "f", 8.0, 3), width: singleItemWidth),
      ResourceItem(resourceModel: ResourceModel("dd", "f", 8.0, 4), width: singleItemWidth),
      ResourceItem(resourceModel: ResourceModel("dd", "f", 8.0, 4), width: singleItemWidth),
      ResourceItem(resourceModel: ResourceModel("dd", "f", 8.0, 4), width: singleItemWidth),
      ResourceItem(resourceModel: ResourceModel("dd", "f", 8.0, 4), width: singleItemWidth),
      ResourceItem(resourceModel: ResourceModel("dd", "f", 8.0, 4), width: singleItemWidth),
      ResourceItem(resourceModel: ResourceModel("dd", "f", 8.0, 4), width: singleItemWidth),
      ResourceItem(resourceModel: ResourceModel("dd", "f", 8.0, 4), width: singleItemWidth),
      ResourceItem(resourceModel: ResourceModel("dd", "f", 8.0, 4), width: singleItemWidth),
      ResourceItem(resourceModel: ResourceModel("dd", "f", 8.0, 4), width: singleItemWidth),
      ResourceItem(resourceModel: ResourceModel("dd", "f", 8.0, 4), width: singleItemWidth),
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("电影"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: bodyVerticalPadding, horizontal: bodyHorizontalPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 资源下条件类型
            ConditionList(verticalPadding: 8.0,),
            const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
            // 资源列表
            Expanded(child: SingleChildScrollView(
              child: Wrap(
                spacing: bodyHorizontalPadding, // 主轴(水平)方向间距
                runSpacing: bodyVerticalPadding, // 纵轴（垂直）方向间距
                alignment: WrapAlignment.spaceBetween, //沿主轴方向
                children: fList.map((e) => e).toList(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
