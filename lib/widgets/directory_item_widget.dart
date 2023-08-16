import 'package:flutter/material.dart';
import 'package:jin_player/utils/my_icons_utils.dart';
import 'package:shijie/model/directory_model.dart';

/// 目录widget
class DirectoryItemWidget extends StatelessWidget {
  const DirectoryItemWidget(
      {Key? key,
      required this.directoryModel,
      this.leadingWidget,
      this.subtitleWidget,
      this.trailingWidget,
      this.onTap,
      this.contentPadding})
      : super(key: key);

  final DirectoryModel directoryModel;
  final Widget? leadingWidget;
  final Widget? subtitleWidget;
  final Widget? trailingWidget;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? contentPadding;

  @override
  Widget build(BuildContext context) {

    Widget defaultLeadingWidget = const Padding(
      padding: EdgeInsets.only(right: 10),
      child: Icon(
        MyIconsUtils.folderFullBackground,
        size: 60,
        color: Colors.black26,
      ),
    );
    Widget defaultSubtitleWidget = Text(
      "${directoryModel.fileNumber}个视频",
      style: const TextStyle(fontSize: 12),
    );
    return InkWell(
      onTap: () {
        onTap?.call();
      },
      child: ListTile(
        horizontalTitleGap: 0,
        contentPadding: contentPadding,
        leading: leadingWidget ?? defaultLeadingWidget,
        title: Text(
          directoryModel.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: subtitleWidget ?? defaultSubtitleWidget,
        trailing: trailingWidget,
      ),
    );
  }
}
