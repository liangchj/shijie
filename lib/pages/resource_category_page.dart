import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shijie/getx_controller/condition_list_controller.dart';
import 'package:shijie/model/resource_model.dart';
import 'package:shijie/pages/video_detail_page.dart';
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
  double itemAspectRatio = 12 / 16;
  double get bodyHorizontalPadding => widget.bodyHorizontalPadding!;
  double get bodyVerticalPadding => widget.bodyVerticalPadding!;
  int get horizontalShowItemNum => widget.horizontalShowItemNum!;
  int get horizontalItemPaddingNum => (widget.horizontalShowItemNum! - 1) + 2; // 横线item padding数量
  final ConditionListController _conditionListController = Get.put(ConditionListController());
  @override
  void setState(VoidCallback fn) {
    // _conditionListController = Get.put(ConditionListController());
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
      ResourceItem(resourceModel:ResourceModel(id: 1, name: "测试名称很长会怎么显示", type: "type", score: 8.0, number: 2), width: singleItemWidth, aspectRatio: 12 / 16,),
      ResourceItem(resourceModel:ResourceModel(id: 1, name: "name", type: "type", score: 8.0, number: 2), width: singleItemWidth, aspectRatio: itemAspectRatio),
      ResourceItem(resourceModel:ResourceModel(id: 1, name: "name", type: "type", score: 8.0, number: 2), width: singleItemWidth, aspectRatio: itemAspectRatio),
      ResourceItem(resourceModel:ResourceModel(id: 1, name: "name", type: "type", score: 8.0, number: 2), width: singleItemWidth, aspectRatio: itemAspectRatio),
      ResourceItem(resourceModel:ResourceModel(id: 1, name: "name", type: "type", score: 8.0, number: 2), width: singleItemWidth, aspectRatio: itemAspectRatio),
      ResourceItem(resourceModel:ResourceModel(id: 1, name: "name", type: "type", score: 8.0, number: 2), width: singleItemWidth, aspectRatio: itemAspectRatio),
      ResourceItem(resourceModel:ResourceModel(id: 1, name: "name", type: "type", score: 8.0, number: 2), width: singleItemWidth, aspectRatio: itemAspectRatio),
      ResourceItem(resourceModel:ResourceModel(id: 1, name: "name", type: "type", score: 8.0, number: 2), width: singleItemWidth, aspectRatio: itemAspectRatio),

    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("电影"),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ],
      ),
      body: Obx(() {
          if (_conditionListController.loading.value) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Container(
            padding: EdgeInsets.symmetric(vertical: bodyVerticalPadding, horizontal: bodyHorizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 资源下条件类型
                ConditionList(verticalPadding: 8.0,),
                const Padding(padding: EdgeInsets.symmetric(vertical: 4.0)),
                // 资源列表
                Expanded(child: GridView.builder(
                  shrinkWrap:true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: bodyHorizontalPadding,
                    crossAxisCount: horizontalShowItemNum, //每行三列
                    mainAxisExtent: (singleItemWidth / itemAspectRatio) + 32,
                    // childAspectRatio: 12 / 19, //显示区域宽高相等
                  ),
                  itemCount: _conditionListController.resourceModelList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                        onTap: () {
                          Get.to(const VideoDetailPage());
                        },
                        child: ResourceItem(resourceModel: _conditionListController.resourceModelList[index], width: singleItemWidth, aspectRatio: itemAspectRatio));
                  },
                ))
                /*Expanded(child: SingleChildScrollView(
                  *//*child: Obx(() => Wrap(
                    spacing: bodyHorizontalPadding, // 主轴(水平)方向间距
                    runSpacing: bodyVerticalPadding, // 纵轴（垂直）方向间距
                    alignment: WrapAlignment.spaceBetween, //沿主轴方向
                    children: _conditionListController.resourceModelList.map((e) {
                      return ResourceItem(resourceModel:e, width: singleItemWidth);
                    }).toList(),
                  )),*//*
                  child: Wrap(
                    spacing: bodyHorizontalPadding, // 主轴(水平)方向间距
                    runSpacing: bodyVerticalPadding, // 纵轴（垂直）方向间距
                    alignment: WrapAlignment.spaceBetween, //沿主轴方向
                    children: fList.map((e) => e).toList(),
                  ),
                ))*/
              ],
            ),
          );
        },
      ),
      /*body: Container(
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
      ),*/
    );
  }
}
