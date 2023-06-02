
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shijie/getx_controller/net_resource_home_controller.dart';
import 'package:shijie/model/resource_model.dart';
import 'package:shijie/pages/video_detail_page.dart';

import '../widgets/resource_item.dart';

class NetResourceHomePage extends GetView<NetResourceHomeController>  {
  const NetResourceHomePage({super.key});

  static double itemAspectRatio = 12 / 16;
  static double bodyHorizontalPadding = 8.0;
  static double bodyVerticalPadding = 10.0;
  static int horizontalShowItemNum = 3;
  static int horizontalItemPaddingNum = (horizontalShowItemNum - 1) + 2; // 横线item padding数量

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


    return Scaffold(
      appBar: AppBar(
        title: const Text("主页"),
        /*bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Material(
            color: Colors.white,
            child: TabBar(
              // labelPadding: EdgeInsets.all(10.0),
              labelStyle: TextStyle(fontSize: 16.0),
              unselectedLabelColor: Colors.black54,
              labelColor: Colors.blue,
              controller: controller.tabController,
              tabs: controller.tabs.map((e) => Tab(text: e)).toList(),
            ),
          ),
        ),*/
      ),
      body: Container(
        height: double.maxFinite,
        child: Obx(() => controller.loading.value ? const Center(
          child: CircularProgressIndicator(),
        ) : Column(
          children: [
            Container(
              color: Colors.black12,
              child: TabBar(
                unselectedLabelColor: Colors.black54,
                labelColor: Colors.blue,
                controller: controller.tabController,
                tabs: controller.tabs.map((e) => Tab(text: e)).toList(),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap:true,
                itemCount: controller.resourceCategoryList.length,
                itemBuilder: (context, index) {
                  return resourceCategoryList(controller.resourceCategoryList[index], singleItemWidth);
                }
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget resourceCategoryList(List<ResourceModel> resourceCategoryList, double singleItemWidth) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: bodyHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(resourceCategoryList[0].type, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(
            height: (singleItemWidth / itemAspectRatio) + 24 + 2 * bodyVerticalPadding,
            child: ListView.builder(
              shrinkWrap:true,
              scrollDirection: Axis.horizontal,
              itemCount: resourceCategoryList.length,
              itemBuilder: (context, index) {
                EdgeInsetsGeometry padding = EdgeInsets.only(left: index == 0 ? 0 : bodyHorizontalPadding, top: bodyVerticalPadding, right: 0, bottom: bodyVerticalPadding);
                return Padding(
                  padding: padding,
                  child: InkWell(
                      onTap: () {
                        Get.to(const VideoDetailPage());
                      },
                      child: ResourceItem(resourceModel: resourceCategoryList[index], width: singleItemWidth, aspectRatio: itemAspectRatio)),
                );
              },
            ),
            /*child: ListView(
                scrollDirection: Axis.horizontal,
                children: resourceCategoryList.map((e) {
                  return Padding(padding: EdgeInsets.symmetric(vertical: bodyVerticalPadding, horizontal: bodyHorizontalPadding / 2),child: ResourceItem(resourceModel: e, width: singleItemWidth, aspectRatio: itemAspectRatio));}).toList(),
            ),*/
          ),
        ],
      ),
    );
    /*return GridView.builder(
      scrollDirection: Axis.horizontal,
      shrinkWrap:true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: bodyHorizontalPadding,
        crossAxisCount: 1, // 一行
        mainAxisExtent: singleItemWidth,
        // childAspectRatio: 12 / 19, //显示区域宽高相等
      ),
      itemCount: resourceCategoryList.length,
      itemBuilder: (context, index) {
        return ResourceItem(resourceModel: resourceCategoryList[index], width: singleItemWidth, aspectRatio: itemAspectRatio);
      },
    );*/
    /*return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(

        children: resourceCategoryList.map((e) => ResourceItem(resourceModel: e, width: singleItemWidth, aspectRatio: itemAspectRatio)).toList(),
      ),
    );*/
  }

}