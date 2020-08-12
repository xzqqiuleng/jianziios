import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/pages/provider/provider_widget.dart';
import 'package:recruit_app/pages/provider/update_info.dart';
import 'package:recruit_app/pages/utils/gaps.dart';

import 'app_update_model.dart';
import 'button_progress_indicator.dart';


class AppUpdateButton extends StatelessWidget {
  Widget build(BuildContext context) {
    return ProviderWidget<AppUpdateModel>(
      model: AppUpdateModel(),
      builder: (_, model, __) => CupertinoButton(
        color: Theme.of(context).accentColor,
        child: model.isBusy
            ? ButtonProgressIndicator()
            : Text("检查更新"),
        onPressed: model.isBusy
            ? null
            : () async {
                AppUpdateInfo appUpdateInfo = await model.checkUpdate();
                if (appUpdateInfo?.buildHaveNewVersion ?? false) {
                  bool result =
                      await showUpdateAlertDialog(context, appUpdateInfo);
                  if (result == true) downloadApp(context, appUpdateInfo);
                } else {
                  showToast("已是最新版本");
                }
              },
      ),
    );
  }
}

Future checkAppUpdate(BuildContext context) async {
  if (!Platform.isAndroid) return;
  AppUpdateInfo appUpdateInfo = await AppUpdateModel().checkUpdate();
  if (appUpdateInfo?.buildHaveNewVersion ?? false) {
    bool result = await showUpdateAlertDialog(context, appUpdateInfo);
    if (result == true) downloadApp(context, appUpdateInfo);
  }
}

/// App更新提示框
//showUpdateAlertDialog(context, AppUpdateInfo appUpdateInfo) async {
//  var forceUpdate = appUpdateInfo.needForceUpdate ?? false;
//  return await showDialog(
//      context: context,
//      builder: (context) => WillPopScope(
//            onWillPop: () async {
//              return !forceUpdate;
//            },
//            child: AlertDialog(
//              title: Text(
//              "发现新版本{appUpdateInfo.buildVersion},是否更新?"
//                  ),
//              content: isNotBlank(appUpdateInfo.buildUpdateDescription)
//                  ? Text(appUpdateInfo.buildUpdateDescription)
//                  : null,
//              actions: <Widget>[
//                if (!forceUpdate)
//                  FlatButton(
//                    onPressed: () {
//                      Navigator.of(context).pop();
//                    },
//                    child: new Text("取消"),
//                  ),
//                FlatButton(
//                  onPressed: () async {
//                    Navigator.of(context).pop(true);
//                  },
//                  child: Text(
//                    "更新",
//                    style: TextStyle(color: Theme.of(context).accentColor),
//                  ),
//                ),
//              ],
//            ),
//          ));
//}

/// App更新提示框
showUpdateAlertDialog(context, AppUpdateInfo appUpdateInfo) async {
  var forceUpdate = appUpdateInfo.mustUpdate ?? false;

  Widget _getW(){
    if (!forceUpdate){
      Align(
        alignment: Alignment.topRight,
        child:  GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.close,color: Colours.black_1e211c) ,
        ),
      );
    }else{
      return Text("");
    }

  }

  return await showDialog(
      context: context,
      builder: (context) => WillPopScope(
        onWillPop: () async {
          return !forceUpdate;
        },

        child:Container(
          alignment: Alignment.center,
          child: Container(
            width: 220,
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white
            ),
            child:

            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
               Gaps.vGap10,

                _getW(),

                Gaps.vGap12,
                Text(
                  "更新版本",
                  style: TextStyle(
                      color: Colours.black_1e211c,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      decoration: TextDecoration.none
                  ),
                ),
                Gaps.vGap8,
                Text(
                  appUpdateInfo.nowVersion,
                  style: TextStyle(
                      color: Colours.app_main,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      decoration: TextDecoration.none
                  ),
                ),
                Gaps.vGap16,
                Text(
                  appUpdateInfo.updateMessage,
                  style: TextStyle(
                      color: Colours.gray_AAAAAA,
                      fontSize: 15,
                      decoration: TextDecoration.none
                  ),
                ),
                Gaps.vGap42,
                CustomBtnWidget(
                  margin:20 ,
                  height: 40,
                  btnColor: Colours.app_main,
                  text:   "下载",
                  onPressed:(){
                    Navigator.of(context).pop(true);
                  },
                )
              ],
            ),



          ),
        ) ,
//        child: AlertDialog(
//          title: Text(
//              "发现新版本{appUpdateInfo.buildVersion},是否更新?"
//          ),
//          content: isNotBlank(appUpdateInfo.buildUpdateDescription)
//              ? Text(appUpdateInfo.buildUpdateDescription)
//              : null,
//          actions: <Widget>[
//            if (!forceUpdate)
//              FlatButton(
//                onPressed: () {
//                  Navigator.of(context).pop();
//                },
//                child: new Text("取消"),
//              ),
//            FlatButton(
//              onPressed: () async {
//                Navigator.of(context).pop(true);
//              },
//              child: Text(
//                "更新",
//                style: TextStyle(color: Theme.of(context).accentColor),
//              ),
//            ),
//          ],
//        ),
      ));
}

Future downloadApp(BuildContext context, AppUpdateInfo appUpdateInfo) async {
  var url = appUpdateInfo.updateUrl;
  var extDir = await getExternalStorageDirectory();
  debugPrint('extDir path: ${extDir.path}');
  String apkPath =
      '${extDir.path}/MiviceConnect${appUpdateInfo.nowVersion}.apk';
  File file = File(apkPath);
  debugPrint('apkPath path: ${file.path}');
  if (!file.existsSync()) {
    // 没有下载过
    if (await showDownloadDialog(context, url, apkPath) ?? false) {
      OpenFile.open(apkPath);
    }
  } else {
    var reDownload = await showReDownloadAlertDialog(context);
    //因为点击android的返回键,关闭dialog时的返回值为null
    if (reDownload != null) {
      if (reDownload) {
        //重新下载
        if (await showDownloadDialog(context, url, apkPath) ?? false) {
          OpenFile.open(apkPath);
        }
      } else {
        //直接安装
        OpenFile.open(apkPath);
      }
    }
  }
}
Future downloadUrlApp(BuildContext context, String murl) async {
  var url = murl;
  var extDir = await getExternalStorageDirectory();
  debugPrint('extDir path: ${extDir.path}');
  String apkPath =
      '${extDir.path}/tuiguagn.apk';
  File file = File(apkPath);
  debugPrint('apkPath path: ${file.path}');
  if (!file.existsSync()) {
    // 没有下载过
    if (await showDownloadDialog(context, url, apkPath) ?? false) {
      OpenFile.open(apkPath);
    }
  } else {
    var reDownload = await showReDownloadAlertDialog(context);
    //因为点击android的返回键,关闭dialog时的返回值为null
    if (reDownload != null) {
      if (reDownload) {
        //重新下载
        if (await showDownloadDialog(context, url, apkPath) ?? false) {
          OpenFile.open(apkPath);
        }
      } else {
        //直接安装
        OpenFile.open(apkPath);
      }
    }
  }
}
showDownloadDialog(context, url, path) async {
  DateTime lastBackPressed;
  CancelToken cancelToken = CancelToken();
  bool downloading = false;
  return await showCupertinoDialog(
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
//            if (lastBackPressed == null ||
//                DateTime.now().difference(lastBackPressed) >
//                    Duration(seconds: 1)) {
//              //两次点击间隔超过1秒则重新计时
//              lastBackPressed = DateTime.now();
//              showToast("再次点击返回键,取消下载",
//                  position: ToastPosition.bottom);
//              return false;
//            }
//            cancelToken.cancel();
//            showToast("下载已取消",
//                position: ToastPosition.bottom);
            return true;
          },
          child: CupertinoAlertDialog(
            title: Text( "等待下载..."),
            content: Builder(
              builder: (context) {
                debugPrint('Downloader Builder');
                ValueNotifier notifier = ValueNotifier(0.0);
                if (!downloading) {
                  downloading = true;
                  Dio().download(url, path, cancelToken: cancelToken,
                      onReceiveProgress: (progress, total) {
                    debugPrint('value--${progress / total}');
                    notifier.value = progress / total;
                  }).then((Response response) {
                    Navigator.pop(context, true);
                  }).catchError((onError) {
                    showToast("下载失败");
                  });
                }
                return ValueListenableBuilder(
                  valueListenable: notifier,
                  builder: (context, value, child) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: LinearProgressIndicator(
                        value: value,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      });
}

showReDownloadAlertDialog(context) async {
  return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Text("检测到该版本已在本地下载。要直接安装吗?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                 "取消",
                ),
              ),
              SizedBox(
                width: 20,
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text(
                 "重新下载",
                ),
              ),
              FlatButton(
                onPressed: () async {
                  Navigator.of(context).pop(false);
                },
                child: Text("安装"),
              ),
            ],
          ));
}
