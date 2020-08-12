import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/constant.dart';
import 'package:recruit_app/pages/provider/app_update.dart';
import 'package:recruit_app/pages/provider/app_update_model.dart';
import 'package:recruit_app/pages/provider/provider_widget.dart';
import 'package:recruit_app/pages/provider/update_info.dart';
import 'package:recruit_app/pages/utils/gaps.dart';
import 'package:recruit_app/pages/utils/platform_utils.dart';
import 'package:url_launcher/url_launcher.dart';


class AboutUsPage extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("关于我们",
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
      body: AboutUsWidget()

    );
  }
  
}

class  AboutUsWidget extends StatefulWidget{
  @override
  _AboutUsWidgetState createState() {
    // TODO: implement createState
  return _AboutUsWidgetState();
  }

}
class  _AboutUsWidgetState extends State<AboutUsWidget>{
  var appVersion ;
  bool visible = false;
  final TapGestureRecognizer recognizer = TapGestureRecognizer();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recognizer.onTap = () {
      launch("tel:${Constant.kf_phone}");
    };
    getVersion();
  }
  void getVersion() async{
    appVersion = await PlatformUtils.getAppVersion();
    print("appversion${appVersion}");
    setState(() {


    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return ProviderWidget<AppUpdateModel>(
     model: AppUpdateModel(),
     onModelReady: (AppUpdateModel model){
         model.checkUpdate().then((value) {
           if(value == null){
             return;
           }
             setState(() {
               visible = value.buildHaveNewVersion == null?false :value.buildHaveNewVersion;
             });

         });
     },
     builder: (_, model, __) {
        return Column(
          children: <Widget>[
            Gaps.vGap24,
            ClipRRect( //剪裁为圆角矩形
              borderRadius: BorderRadius.circular(5.0),
              child: Image(
                image: AssetImage("images/icon_hc.png"),
                height: 98,
                width: 98,
              ),
            ),
            Gaps.vGap12,
            Text("随时兼职",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colours.black_212920
              ),
            ),
            Gaps.vGap12,
            Text("版本 $appVersion",
              style: TextStyle(
                  fontSize: 13,
                  color: Colours.gray_8A8F8A
              ),
            ),
            Gaps.vGap50,
            GestureDetector(
              onTap: model.isBusy
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
              behavior: HitTestBehavior.opaque,

              child: Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                height: 54,
                child: Stack(
                  alignment:Alignment.center,
                  children: <Widget>[
                    Positioned(
                      left: 0,
                      child: Text("检查新版本",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: Colours.black_212920
                        ),
                      ),
                    ),
                    Positioned(
                        right: 30,
                        child:  Offstage(
                          offstage: !visible,
                          child: Text("NEW ！",
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colours.red_ffd5351c
                            ),
                          ),
                        )
                    ),
                    Positioned(
                      right: 0,
                      child: Icon(Icons.navigate_next, color: Colours.black_400000),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Gaps.line1,
                    ),

                  ],

                ),

              ),
            ),

            GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap:_showCall,
                child: Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  height: 54,
                  child: Stack(
                    alignment:Alignment.center,
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        child: Text("客户服务热线",
                          style: TextStyle(

                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              color: Colours.black_212920
                          ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        child: Icon(Icons.navigate_next, color: Colours.black_400000),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Gaps.line1,
                      ),

                    ],

                  ),

                )
            )

          ],
        );
     });

  }

  void _showCall(){
    showModalBottomSheet(

      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                height: 118,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Column(
                  children: <Widget>[
                    Gaps.vGap20,
                    Text("客服热线服务时间:9:00-21:00",
                      style: TextStyle(
                          fontSize: 13,
                          color: Colours.gray_8A8F8A
                      ),

                    ),
                    Gaps.vGap20,
                    Gaps.line1,
                    Gaps.vGap20,
                    Text.rich(TextSpan(
                        children: [
                          TextSpan(
                            text: "客户服务热线：",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colours.black_212920
                            ),
                          ),
                          TextSpan(
                            recognizer: recognizer,
                            text: Constant.kf_phone,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colours.app_main
                            ),
                          ),
                        ]
                    ))
                  ],
                ),
              ),
             GestureDetector(
               behavior: HitTestBehavior.opaque,
               onTap: () =>Navigator.of(context).pop(),
               child: Container(
                   margin: EdgeInsets.all(10),
                   height:54,
                   alignment: Alignment.center,
                   width: double.infinity,

                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(12)
                   ),
                   child: Text("取消",
                     style: TextStyle(
                         fontSize: 16,
                         color: Colours.app_main,
                         fontWeight: FontWeight.bold
                     ),
                   )
               )
             )
            ],
          ),
        );
      },
    );
  }

}

