
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {

  /// 检测是否有权限
  /// [permissionList] 权限申请列表
  /// [onPermissionCallback] 权限申请是否成功
  static Future<void> checkPermission(
      {required List<Permission> permissionList,
        required ValueChanged onPermissionCallback}) async {
    ///一个新待申请权限列表
    List<Permission> newPermissionList = [];
    Map<Permission, PermissionStatus> permissionStatusMap = {};

    ///遍历当前权限申请列表
    for (Permission permission in permissionList) {
      PermissionStatus status = await permission.status;
      print("status: $status");
      ///如果不是允许状态就添加到新的申请列表中
      if (!status.isGranted) {
        newPermissionList.add(permission);
        permissionStatusMap[permission] = status;
      }
    }
    ///如果需要重新申请的列表不是空的
    if (permissionStatusMap.isNotEmpty) {
      PermissionStatus permissionStatus =
      await requestPermission(newPermissionList);
      print("permissionStatus: $permissionStatus");
      ///拒绝状态
      if (permissionStatus == PermissionStatus.denied) {
        onPermissionCallback(false);
      }
      ///允许状态
      else if (permissionStatus == PermissionStatus.granted) {
        onPermissionCallback(true);
      }
      /// 永久拒绝  活动限制
      else if (permissionStatus == PermissionStatus.restricted || permissionStatus == PermissionStatus.limited || permissionStatus == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
      /*switch (permissionStatus) {

        ///拒绝状态
        case PermissionStatus.denied:
          onPermissionCallback(false);
          break;

        ///允许状态
        case PermissionStatus.granted:
          onPermissionCallback(true);
          break;

        /// 永久拒绝  活动限制
        case PermissionStatus.restricted:
        case PermissionStatus.limited:
        case PermissionStatus.permanentlyDenied:
          openAppSettings();
          break;
      }*/

    } else {
      onPermissionCallback(true);
    }

  }

  /// 获取新列表中的权限 如果有一项不合格就返回false
  static Future<PermissionStatus> requestPermission(List<Permission> permissionList) async {
    Map<Permission, PermissionStatus> statuses = await permissionList.request();
    bool isShown = await Permission.contacts.shouldShowRequestRationale;
    PermissionStatus currentPermissionStatus = PermissionStatus.granted;
    statuses.forEach((key, value) {
      if (!value.isGranted) {
        currentPermissionStatus = value;
        return;
      }
    });
    return currentPermissionStatus;
  }
}

