// import 'dart:convert';
//
// import 'package:flutter/cupertino.dart';
// import './entity/update_entity.dart';
// import '../util/m_net.dart';
//
// import 'update_parser.dart';
// import 'update_prompter.dart';
// import '../util/common.dart';
// import '../util/toast.dart';
// import 'package:install_plugin/install_plugin.dart';
//
// import '../util/http.dart';
//
// /// 版本更新管理
// class UpdateManager {
//   ///全局初始化
//   static init(
//       {String baseUrl, int timeout = 5000, Map<String, dynamic> headers}) {
//     HttpUtils.init(baseUrl: baseUrl, timeout: timeout, headers: headers);
//   }
//
//   static void checkUpdate(BuildContext context, String url) {
//
//     debugPrint("========================");
//     debugPrint(url.toString());
//
//    // MNet.getResponse(url);
//
//     Future<dynamic> futureEntry =  MNet.getData(url);
//
//     futureEntry.then(
//             (dynamic result) {
//           debugPrint("==========request page==============");
//           debugPrint(result.toString());
//          // var data= jsonDecode(result.toString());
//           var versionData = result;
//           //ReturnData returnData = ReturnData.fromJson(result);
//           debugPrint("=====version name======" + versionData["versionName"]);
//           // versionData["versionCode"] = 3;
//           // versionData["updateStatus"] = true;
//
//           UpdateEntity entity = new UpdateEntity(hasUpdate: versionData["updateStatus"], versionCode: versionData["versionCode"],
//               versionName: versionData["versionName"] , updateContent: versionData["modifyContent"] ,
//               downloadUrl: versionData["downloadUrl"],
//               //apkMd5: versionData["apkMd5"],
//               //apkSize:  versionData["apkSize"]
//           );
//
//           UpdatePrompter updatePrompter = UpdatePrompter(
//               updateEntity: entity,
//               onInstall: (String filePath) {
//
//                 debugPrint("========================");
//                 debugPrint(filePath);
//
//                 CommonUtils.installAPP(filePath);
//               });
//
//           updatePrompter.show(context);
//
//
//           });
//
//
//
//  //    HttpUtils.get(url).then((response) {
//  //
//  // UpdateParser.parseJson(response.toString()).then((value) => {
//  //
//  //            UpdatePrompter(
//  //                updateEntity: value,
//  //                onInstall: (String filePath) {
//  //
//  //                  debugPrint("========================");
//  //                  debugPrint(filePath);
//  //
//  //                  CommonUtils.installAPP(filePath);
//  //                }).show(context)
//  //          });
//  //    }
//  //    ).catchError((onError) {
//  //      debugPrint("========================");
//  //      debugPrint(onError.toString());
//  //      ToastUtils.error(onError);
//  //    });
//
//
//
//   }
// }
//
// typedef InstallCallback = Function(String filePath);
