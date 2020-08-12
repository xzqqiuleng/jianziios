import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/identity_model.dart';
import 'package:recruit_app/model/me_list.dart';
import 'package:recruit_app/pages/mine/comunicate.dart';
import 'package:recruit_app/pages/mine/focus_company_list.dart';
import 'package:recruit_app/pages/mine/job_intent.dart';
import 'package:recruit_app/pages/mine/mine_infor.dart';
import 'package:recruit_app/pages/mine/online_resume.dart';
import 'package:recruit_app/pages/mine/send_resume.dart';
import 'package:recruit_app/pages/setting/setting.dart';
import 'package:recruit_app/pages/utils/cashfile_utils.dart';
import 'package:recruit_app/widgets/progress_dialog.dart';

class Mine extends StatefulWidget {
  @override
  _MineState createState() {
    // TODO: implement createState
    return _MineState();
  }
}

class _MineState extends State<Mine> {
  List<Me> options = MeOptions.loadOptions();


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
//              if(UserHelper.isLogin()){
//                MiviceRepository().deleteAccount().then((value) {
//                  UserModel usermodel = Provider.of<UserModel>(buildContext,listen: false);
//                  usermodel.logout();
//                  Navigator.of(context).pop();
//                  eventBus.fire(HomeRefreshEvent(true));
//                });
//              }

            },
          ),
        ],
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'images/img_setting_white.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Setting(), ),);
              }),
        ],
        backgroundColor: Colours.app_main,
      ),
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(48),
                  right: ScreenUtil().setWidth(48),
                  bottom: ScreenUtil().setWidth(48),
                  top: ScreenUtil().setWidth(30)),
              color:  Colours.app_main,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>MineInfor(),),);
                    },
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            ScreenUtil().setWidth(70),
                          ),
                          child: Image.asset(
                            'images/img_icon_harden.png',
                            width: ScreenUtil().setWidth(140),
                            height: ScreenUtil().setWidth(140),
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(15),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children:<Widget>[
                            Text(
                              '哈哈哈哈哈登',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ScreenUtil().setSp(40),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: ScreenUtil().setWidth(20),
                            ),
                            Text(
                              '点击登录',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: ScreenUtil().setSp(30),
                              ),
                            ),

                          ],

                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: ScreenUtil().setWidth(76),
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
                                '18',
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
                                '已投递',
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
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>SendResumeJob(),),);

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
                                '18',
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
                                '待面试',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: Color.fromRGBO(227, 226, 226, 1),
                                  fontSize: ScreenUtil().setSp(24),
                                ),
                              ),
                            ],
                          ),
                          onTap: () {},
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
                                '18',
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
                                '沟通过',
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
                            Navigator.push(context,MaterialPageRoute(builder: (context)=>ComunicateJob(),),);
                          },
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Consumer<IdentityModel>(
                  builder: (context, model, child) {
                    return GestureDetector(
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
                        if (index == 2) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FocusCompanyList()));
                        } else if (index == 1) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JobIntent()));
                        } else if (index == 4) {
                          model.changeIdentity(
                              model.identity == Identity.employee
                                  ? Identity.boss
                                  : Identity.employee);
                        }else if(index == 0){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OnlineResume()));
                        }
                      },
                    );
                  },
                ),
                Container(
                  color: Color.fromRGBO(159, 199, 235, 1),
                  height: (index == 3 || index == options.length - 1)
                      ? ScreenUtil().setWidth(1)
                      : 0,
                )
              ],
            );
          }, childCount: options.length)),
          SliverToBoxAdapter(
            child: Container(
              margin:
                  EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(48)),
              height: ScreenUtil().setWidth(50),
            ),
          ),
        ],
      ),
    );
  }
}
