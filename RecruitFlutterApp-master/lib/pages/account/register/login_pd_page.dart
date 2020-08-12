import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/account/register/User.dart';
import 'package:recruit_app/pages/account/register/forget_page.dart';
import 'package:recruit_app/pages/account/register/reg_page.dart';
import 'package:recruit_app/pages/event_heper.dart';
import 'package:recruit_app/pages/home/recruit_home_app.dart';
import 'package:recruit_app/pages/msg/agreement_detail.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/storage_manager.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

class LoginPdPage extends StatefulWidget{

  @override
  _LoginPdState createState() {
    // TODO: implement createState
    return _LoginPdState();
  }


}

class _LoginPdState extends State<LoginPdPage>{
  final _phoneController = TextEditingController();

  final _PdController = TextEditingController();
  @override
  void dispose() {
    _phoneController.dispose();
    _PdController.dispose();

    super.dispose();
  }

  void loginPd(){
//    Navigator.pushReplacement(
//        context,
//        MaterialPageRoute(
//          builder: (context) => RecruitHomeApp(),
//        ));
    MiviceRepository().loginPd(_phoneController.text,_PdController.text).then((value)  {
      var reponse = json.decode(value.toString());

      if(reponse["status"] == "success") {
        var data = reponse["result"];


        User user = User.fromJson(data);
        StorageManager.localStorage.setItem(ShareHelper.kUser, user);
        StorageManager.sharedPreferences.setBool(ShareHelper.is_Login, true);
        eventBus.fire(new LoginEvent());
        Navigator.of(context).pop(true);
      }else{
        showToast(reponse["msg"]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Container(

    color:Colors.white,
    height: MediaQuery.of(context).size.height,
    width: MediaQuery.of(context).size.width,
      child:Stack(
                  children: <Widget>[
                    Card(
                        margin: EdgeInsets.only(left: 16,right: 16,top:58),
                        elevation: 0,
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Padding(
                          padding:  EdgeInsets.fromLTRB(16, 16, 16, 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              SizedBox(height: 50),
                              LogRegTextField(

                                label: "手机号",
                                controller:  _phoneController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.phone,
                                obscureText: false,

                              ),

                              SizedBox(height: 30),
                              LogRegTextField(

                                label: "请输入密码",
                                controller:  _PdController,
                                textInputAction: TextInputAction.next,
                                textInputType: TextInputType.text,
                                obscureText: true,
                              ),



                              SizedBox(height: 24),
                              Container(
                                height: 20,
                                child: Stack(

                                  children: <Widget>[
                                    Positioned(
                                      left: 0,
                                      child: GestureDetector(
                                        onTap:()async{
                                       var result =  await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => RegPage(),
                                              ));
                                          if(result != null && result == true){
                                            Navigator.of(context).pop();
                                          }
                                        },
                                        child: Text(
                                          "注册账号",
                                          style: TextStyle(

                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold
                                          ),
                                        ) ,
                                      ),
                                    ),
                                    Positioned(
                                        height: 20,
                                        right: 0,
                                        child: GestureDetector(
                                          onTap:()=>   Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ForgetPage(),
                                              )),
                                          child:Text(
                                            "忘记密码？",
                                            style: TextStyle(

                                                fontSize: 13,
                                                color: Colours.app_main
                                            ),
                                          ),
                                        )
                                    ),


                                  ],
                                ),
                              ),
                              SizedBox(height:30),
                     GestureDetector(

                        onTap: () => loginPd(),
                          child: ConstrainedBox(
                                constraints: BoxConstraints(
                                  minWidth: double.infinity,
                                  minHeight : 50,
                                ),
                                child: Card(
                                    color: Colours.app_main,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(6)
                                    ),
                                    child: Center(
                                      child:Text("登录",
                                        textAlign: TextAlign.center,

                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold
                                        ),
                                      ),

                                    )

                                ),
                              )
                     )
                            ],
                          ),
                        )
                    ),
                    Positioned(
                      left: 20,
                      right: 20,
                      bottom: 14,
                      child: BottomXY(),
                    ),

                    Positioned(
                      right: 30,
                      top: 40,
                      child:GestureDetector(
                        onTap: ()=>Navigator.of(context).pop(),
                      child:Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                            image:DecorationImage(
                                image: AssetImage("images/cancle.png")
                            )
                        ),
                      ),

                   )
                    )
                  ],

                )
  );
  }
  
}


class BottomXY extends StatelessWidget{
  TapGestureRecognizer _tapGestureRecognizer1;
  TapGestureRecognizer _tapGestureRecognizer2;


  @override
  Widget build(BuildContext context) {
    _tapGestureRecognizer1 = TapGestureRecognizer();
    _tapGestureRecognizer2 = TapGestureRecognizer();
    _tapGestureRecognizer1.onTap=(){
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgreementDetailPage(0),
          ));
    };

    _tapGestureRecognizer2.onTap=(){
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgreementDetailPage(1),
          ));
    };
    // TODO: implement build
    return  Text.rich(TextSpan(
        children: [
          TextSpan(
            text: "登录表示您已同意",
            style: TextStyle(
                color: Colours.gray_8A8F8A,
                fontSize: 12,
                decoration: TextDecoration.none
            ),
          ),
          TextSpan(
            recognizer: _tapGestureRecognizer1, //监听
            text:"服务协议，",
            style: TextStyle(
                color: Colours.app_main,
                fontSize: 12,
                decoration: TextDecoration.none
            ),
//                recognizer: _tapRecognizer
          ),
          TextSpan(
            recognizer: _tapGestureRecognizer2,
            text: "隐私政策",
            style: TextStyle(
                color: Colours.app_main,
                fontSize: 12,
                decoration: TextDecoration.none
            ),
//                recognizer: _tapRecognizer
          ),
          TextSpan(

            text: "并授权使用您的帐户信息(如昵称、头像、等)进行统一管理",
            style: TextStyle(
                color: Colours.gray_8A8F8A,
                fontSize: 12,
                decoration: TextDecoration.none
            ),
          ),
        ]
    ));
  }

}