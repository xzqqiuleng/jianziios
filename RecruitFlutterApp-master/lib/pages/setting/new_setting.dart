import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/me_list.dart';
import 'package:recruit_app/pages/mine/about_us.dart';
import 'package:recruit_app/pages/utils/cashfile_utils.dart';
import 'package:recruit_app/widgets/common_appbar_widget.dart';
import 'package:recruit_app/widgets/progress_dialog.dart';

import '../event_heper.dart';
import '../event_heper.dart';
import '../service/mivice_repository.dart';
import '../share_helper.dart';
import '../share_helper.dart';
import '../storage_manager.dart';

class NewSetting extends StatefulWidget {
  @override
  _NewSettingState createState() => _NewSettingState();
}

class _NewSettingState extends State<NewSetting> {
  List<Me> options = List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    options.add( Me(imgPath: 'images/set1.png', itemName: '清理缓存', itemStatus: ''));
    options.add( Me(imgPath: 'images/set2.png', itemName: '关于我们', itemStatus: ''));
    options.add( Me(imgPath: 'images/set3.png', itemName: '注销账号', itemStatus: ''));



  }
  _clearCach(){
    ProgressDialog.showProgress(context);
    CashFileUtils.clearCache().then((value) {
      ProgressDialog.dismiss(context);
    });
  }
  void _showDeleteDialog(BuildContext buildContext) async{
    print("show");
    await showDialog(context: buildContext,builder: (BuildContext context){

      return CupertinoAlertDialog(
        title: Text("账号注销后无法恢复，请谨慎操作",style: TextStyle(color: Colours.black_1e211c,fontSize: 17,fontWeight: FontWeight.bold),),
        content:Text(""),
        actions:<Widget>[

          CupertinoDialogAction(
            child: Text("取消",style: TextStyle(color: Colours.gray_C8C7CC,fontSize: 17,fontWeight: FontWeight.bold)),
            onPressed: (){
              Navigator.of(context).pop();

            },
          ),

          CupertinoDialogAction(
            child:  Text("删除",style: TextStyle(color: Colours.app_main,fontSize: 17,fontWeight: FontWeight.bold)),
            onPressed: (){
              if(ShareHelper.isLogin()){
                MiviceRepository().deletAuthor().then((value) {
                  StorageManager.localStorage.deleteItem(ShareHelper.kUser);
                  StorageManager.sharedPreferences.setBool(ShareHelper.is_Login, false);
                  eventBus.fire(LoginEvent());
                  Navigator.of(context).pop();
                });
              }

            },
          ),
        ],
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar:  AppBar(
        backgroundColor:  Colors.white,
        title: Text("设置",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87
          ),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black87), //自定义图标
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          );
        },
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body:   ListView.builder(itemBuilder: (BuildContext context,int index){
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(48),
                  vertical: ScreenUtil().setWidth(40),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      options[index].imgPath,
                      width: ScreenUtil().setWidth(40),
                      height: ScreenUtil().setWidth(40),
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    Expanded(
                      child: Text(
                        options[index].itemName,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                            color: Color.fromRGBO(57, 57, 57, 1),
                            fontSize: ScreenUtil().setSp(32)),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    Text(
                      options[index].itemStatus,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: Color.fromRGBO(194, 203, 202, 1),
                        fontSize: ScreenUtil().setSp(24),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    Image.asset(
                      'images/img_arrow_right_blue.png',
                      width: ScreenUtil().setWidth(10),
                      height: ScreenUtil().setWidth(20),
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ),
              onTap: () {
                if (index == 0) {
                    _clearCach();
                } else if (index == 1) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AboutUsPage()));
                } else if (index == 2) {
              _showDeleteDialog(context);
                }
              },
            ),
            Container(
              color: Color(0xfff8f8f8),
              height: 1,
            )
          ],
        );
      },
        itemCount: options.length,
        shrinkWrap: true,
      ),
    );
  }
}
