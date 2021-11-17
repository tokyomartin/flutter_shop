// import 'package:flutter/cupertino.dart';
//
// import 'entity/update_entity.dart';
// import 'entity/update_info.dart';
// import '../util/common.dart';
// import 'package:package_info/package_info.dart';
//
// ///版本更新默认的方法
// class UpdateParser {
//   /// 解析器
//   static Future<UpdateEntity> parseJson(String json) async {
//
//     String tmpJson = json;
//     debugPrint("========================");
//     debugPrint(tmpJson);
//
//     UpdateInfo updateInfo = UpdateInfo.fromJson(json);
//     if (updateInfo == null || updateInfo.code != 0) {
//       return null;
//     }
//
//     //进行二次校验
//     bool hasUpdate = updateInfo.updateStatus != NO_NEW_VERSION;
//     if (hasUpdate) {
//       String versionCode = await CommonUtils.getVersionCode();
//
//       debugPrint("======服务器返回的最新版本小于等于现在的版本，不需要更新========");
//       debugPrint("服务器版本：" + updateInfo.versionCode.toString());
//       debugPrint("本地版本：" + versionCode.toString());
//       //服务器返回的最新版本小于等于现在的版本，不需要更新
//       if (updateInfo.versionCode <= int.parse(versionCode)) {
//         hasUpdate = false;
//       }
//     }
//
//     return UpdateEntity(
//         hasUpdate: hasUpdate,
//         isForce: updateInfo.updateStatus == HAVE_NEW_VERSION_FORCED_UPLOAD,
//         versionCode: updateInfo.versionCode,
//         versionName: updateInfo.versionName,
//         updateContent: updateInfo.modifyContent,
//         downloadUrl: updateInfo.downloadUrl,
//         apkSize: updateInfo.apkSize,
//         apkMd5: updateInfo.apkMd5);
//   }
// }
