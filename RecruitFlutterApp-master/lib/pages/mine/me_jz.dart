import 'dart:async';
import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:launch_review/launch_review.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/account/register/login_pd_page.dart';
import 'package:recruit_app/pages/mine/feedback.dart';
import 'package:recruit_app/pages/mine/push_set.dart';
import 'package:recruit_app/pages/msg/agreement.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/utils/com_save.dart';
import 'package:recruit_app/pages/utils/jz_no.dart';
import 'package:recruit_app/pages/utils/jz_save.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constant.dart';
import '../event_heper.dart';
import '../share_helper.dart';
import '../storage_manager.dart';
import '../utils/gaps.dart';
import 'mine_infor.dart';
import 'mine_jl.dart';
import 'package:recruit_app/model/me_list.dart';
import 'package:recruit_app/pages/setting/new_setting.dart';

class MeJz extends StatefulWidget {
  @override
  _MeJzState createState() => _MeJzState();
}


class _MeJzState extends State<MeJz> {
  List<Me> options = List();
  final TapGestureRecognizer recognizer = TapGestureRecognizer();



  Future<void> initPlatformState() async {

    try {
      String uuid = await ImeiPlugin.getId();

      MiviceRepository().postTencentData("PAGE_VIEW", uuid);
    } on PlatformException {

    }

  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
  setState(() {
    try{
      String jsonStr = StorageManager.sharedPreferences.getString(ShareHelper.getUser().id+"bm");
      List data =  json.decode(jsonStr);
      num = data.length;
    }catch(e){
      num = 0;
    }

  });



    options.add( Me(imgPath: 'images/me1.png', itemName: '推送设置', itemStatus: ''));
    options.add( Me(imgPath: 'images/me2.png', itemName: '意见反馈', itemStatus: ''));
    options.add( Me(imgPath: 'images/me3.png', itemName: '好评一下', itemStatus: ''));
    options.add( Me(imgPath: 'images/me4.png', itemName: '隐私与协议', itemStatus: ''));
    options.add( Me(imgPath: 'images/me5.png', itemName: '设置', itemStatus: ''));
    _eventSub();
//    name ="";
//    xl ="";
//    imagUrl ="";
     name = ShareHelper.isLogin() ?ShareHelper.getUser().nick_name : "未登录";
     xl = ShareHelper.isLogin() ?ShareHelper.getUser().education : "点击登录";
    imagUrl = ShareHelper.isLogin() ?ShareHelper.getUser().head_img : "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1093847288,3038136586&fm=26&gp=0.jpg";
    recognizer.onTap = () {
      launch("tel:${Constant.kf_phone}");

    };

  }
  String name;
  String xl;
  String imagUrl;
  StreamSubscription  _eventRefreshSub;
  int num;
  void _eventSub(){

    _eventRefreshSub= eventBus.on<LoginEvent>().listen((event) {
      setState(() {
        name = ShareHelper.isLogin() ?ShareHelper.getUser().nick_name : "未登录";
        xl = ShareHelper.isLogin() ?ShareHelper.getUser().education : "点击登录";
        imagUrl = ShareHelper.isLogin() ?ShareHelper.getUser().head_img : "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=1093847288,3038136586&fm=26&gp=0.jpg";

      });
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'images/kf.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {
//
                _showCall();
              }),
        ],
        backgroundColor: Colours.app_main,
      ),
      body: SingleChildScrollView(

        child: Column(
          children: <Widget>[
            Container(
              height: 260,
              child:Stack(
                  children: [
                    Container(
                      height: 200,
                      padding: EdgeInsets.only(
                          left: ScreenUtil().setWidth(48),
                          right: ScreenUtil().setWidth(48),
                          bottom: ScreenUtil().setWidth(48),
                          top: ScreenUtil().setWidth(20)),
                      color:  Colours.app_main,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: (){
                              if(ShareHelper.isLogin()){
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>MineInfor(),),);
                              }else{
                                Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPdPage(),),);
                              }

                            },
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[

                                Expanded(
                                  child:  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:<Widget>[
                                      Text(
                                        name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: ScreenUtil().setSp(48),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setWidth(30),
                                      ),
                                      Text(
                                        xl,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(30),
                                        ),
                                      ),

                                    ],

                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(15),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    ScreenUtil().setWidth(70),
                                  ),
                                  child: Image.network(
                                   imagUrl,
                                    width: ScreenUtil().setWidth(140),
                                    height: ScreenUtil().setWidth(140),
                                    fit: BoxFit.cover,
                                  ),
                                ),

                              ],
                            ),
                          ),

                          SizedBox(
                            height: ScreenUtil().setWidth(70),
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        num.toString(),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(36),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '已报名',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Color.fromRGBO(227, 226, 226, 1),
                                          fontSize: ScreenUtil().setSp(24),
                                        ),
                                      ),

                                    ],
                                  ),
                                  onTap: () {
                                    if(ShareHelper.isLogin()){
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>JZSave("已报名"),),);
                                    }else{
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPdPage(),),);
                                    }


                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(10),
                                ),
                                width: ScreenUtil().setWidth(1),
                                height: ScreenUtil().setHeight(28),
                                color: Colors.white,
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        '0',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(36),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '已录取',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Color.fromRGBO(227, 226, 226, 1),
                                          fontSize: ScreenUtil().setSp(24),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    if(ShareHelper.isLogin()){
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>JZNo("已录取"),),);
                                    }else{
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPdPage(),),);
                                    }
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(10),
                                ),
                                width: ScreenUtil().setWidth(1),
                                height: ScreenUtil().setHeight(28),
                                color: Colors.white,
                              ),
                              Expanded(
                                flex: 1,
                                child: GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        '0',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: ScreenUtil().setSp(36),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        '已拒绝',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Color.fromRGBO(227, 226, 226, 1),
                                          fontSize: ScreenUtil().setSp(24),
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: () {
                                    if(ShareHelper.isLogin()){
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>JZNo("已拒绝"),),);
                                    }else{
                                      Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPdPage(),),);
                                    }
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 14,
                      right: 14,
                      child: GestureDetector(

                        onTap: (){
                          if(ShareHelper.isLogin()){
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>MineJL(),),);
                          }else{
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPdPage(),),);
                          }
                    },
                      child:Card(
                        elevation: 0.2,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)
                        ),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child:  Text(
                                  "   优秀的简历，精准的推荐",
                                  style: TextStyle(
                                      letterSpacing: 2,
                                      wordSpacing: 2,
                                      fontWeight: FontWeight.w100
                                  ),
                                )
                            ),
                            Container(
                              height: 30,
                              width: 70,
                              alignment: Alignment.center,
                              margin: EdgeInsets.fromLTRB(16,20,14,20),
                              decoration: BoxDecoration(
                                  color: Colors.redAccent,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Text(
                                "编辑简历",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      )
                    )
                  ],

              ),
            ),

////           Row(
//             children: <Widget>[
//               SizedBox(width: 16,),
//               Container(
//                 width: 2,
//                 height: 16,
//                 color: Colours.app_main,
//               ),
//               Text(
//                 "收藏与关注"
//               )
//             ],
//           ),
            SizedBox(height: 16,),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child:GestureDetector(
                    onTap: (){
                      if(ShareHelper.isLogin()){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>JZSave("兼职收藏"),),);
                      }else{
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPdPage(),),);
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 16,),
                        Image.asset("images/love.png",height: 40,width: 40),
                        SizedBox(width: 16,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "兼职收藏",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "你感兴趣的兼职",style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w100
                            ),
                            )
                          ],
                        ),
                      ],
                    ),
                  )
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: (){
                      if(ShareHelper.isLogin()){
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>ComSave("公司关注"),),);
                      }else{
                        Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginPdPage(),),);
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: <Widget>[
                        SizedBox(width: 16,),
                        Image.asset("images/sub.png",height: 40,width: 40),
                        SizedBox(width: 16,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "公司关注",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,

                              ),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Text(
                              "公司职位不遗漏",style: TextStyle(
                                color: Colors.grey,
                                fontSize: 11,
                                fontWeight: FontWeight.w100
                            ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                )
              ],
            ),
             SizedBox(
               height: 16,
             ),
             ListView.builder(itemBuilder: (BuildContext context,int index){
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PushSetPage()));
                            } else if (index == 1) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => FeedbackPage()));
                            } else if (index == 2) {
                              LaunchReview.launch(androidAppId: "com.shuibian.jobwork");
                            }else if(index == 3){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AgreementPage()));
                            }else if(index == 4){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => NewSetting()));
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
               physics: const NeverScrollableScrollPhysics(),
               shrinkWrap: true,
             )
          ],
        ),
      )

    );
  }
}
