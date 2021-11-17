// import 'package:flutter/cupertino.dart';
// import 'update.dart';
// import '../util/common.dart';
// import '../util/http.dart';
// import '../util/toast.dart';
// import 'package:flutter_update_dialog/flutter_update_dialog.dart';
// import 'dart:io';
//
// import 'entity/update_entity.dart';
//
// class UpdatePrompter {
//   /// 版本更新信息
//   final UpdateEntity updateEntity;
//
//   final InstallCallback onInstall;
//
//   UpdateDialog _dialog;
//
//   double _progress = 0.0;
//
//   File _apkFile;
//
//   UpdatePrompter({@required this.updateEntity, @required this.onInstall});
//
//   void show(BuildContext context) async {
//     if (_dialog != null && _dialog.isShowing()) {
//       return;
//     }
//     String title = "是否升级到${updateEntity.versionName}版本？";
//     String updateContent = getUpdateContent();
//     if (Platform.isAndroid) {
//       debugPrint("准备下载APK安装包");
//       _apkFile = await CommonUtils.getApkFileByUpdateEntity(updateEntity);
//     }
//     if (_apkFile != null && _apkFile.existsSync()) {
//
//       debugPrint("显示安装对话框");
//
//       _dialog = UpdateDialog.showUpdate(
//         context,
//         title: title,
//         updateContent: updateContent,
//         updateButtonText: "安装",
//         extraHeight: 10,
//         enableIgnore: updateEntity.isIgnorable,
//         isForce: updateEntity.isForce,
//         onUpdate: doInstall,
//       );
//     } else {
//
//       //debugPrint("======服务器返回的最新版本小于等于现在的版本，不需要更新========");
//       debugPrint("显示安装包对话框");
//
//       _dialog = UpdateDialog.showUpdate(
//         context,
//         title: title,
//         updateContent: updateContent,
//         extraHeight: 10,
//         enableIgnore: updateEntity.isIgnorable,
//         isForce: updateEntity.isForce,
//         onUpdate: onUpdate,
//       );
//
//
//     }
//   }
//
//   String getUpdateContent() {
//     String targetSize =
//         CommonUtils.getTargetSize(updateEntity.apkSize.toDouble());
//     String updateContent = "";
//     if (targetSize.isNotEmpty) {
//       updateContent += "新版本大小：$targetSize\n";
//     }
//     updateContent += updateEntity.updateContent;
//     return updateContent;
//   }
//
//   void onUpdate() {
//     if (Platform.isIOS) {
//       debugPrint("正在下载IOS安装包");
//       doInstall();
//       return;
//     }
//
//     HttpUtils.downloadFile(updateEntity.downloadUrl, _apkFile.path,
//         onReceiveProgress: (int count, int total) {
//
//           debugPrint("正在下载apk安装包");
//
//       _progress = count.toDouble() / total;
//       if (_progress <= 1.0001) {
//         _dialog.update(_progress);
//       }
//     }).then((value) {
//       doInstall();
//     }).catchError((value) {
//       ToastUtils.success("下载失败！");
//       _dialog.dismiss();
//     });
//   }
//
//   /// 安装
//   void doInstall() {
//     _dialog.dismiss();
//     onInstall.call(_apkFile != null ? _apkFile.path : updateEntity.downloadUrl);
//   }
// }
