
import 'package:flutter/material.dart';
import 'package:shijie/model/resource_model.dart';

class ResourceItem extends StatelessWidget {
  const ResourceItem({Key? key, required this.resourceModel, this.aspectRatio, required this.width}) : super(key: key);
  final ResourceModel resourceModel;
  final double? aspectRatio;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 缩略图
          AspectRatio(
            aspectRatio: aspectRatio ?? 12 / 16,
            child: Stack(
              children: [
                const Image(
                    height: double.infinity,
                    fit: BoxFit.fitHeight,
                    image: AssetImage("assets/images/1.jpg")
                ),
                // 评分
                if (resourceModel.score != null)
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                        color: Colors.green,
                        child: Text("${resourceModel.score}", style: const TextStyle(color: Colors.white),)),
                  ),
                // 集数/清晰度
                if (resourceModel.number > 0)
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                        width: double.maxFinite,
                        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
                        color: Colors.grey.withOpacity(0.6),
                        child: Text("${resourceModel.number}", style: const TextStyle(color: Colors.white),)),
                  ),
              ],
            ),
          ),
          // 名称
          Text(resourceModel.name, textAlign: TextAlign.start,)
        ],
      ),
    );
  }
}
