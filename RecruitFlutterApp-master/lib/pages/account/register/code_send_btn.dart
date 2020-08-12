import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobsms/mobsms.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colours.dart';

class CodeSendBtn  extends StatefulWidget{
//  PhoneCodeModel model;
//  CodeSendBtn(this.model);
  CodeSendBtn({Key key}) : super(key: key);
  @override
  CodeSendBtnState createState() {
    // TODO: implement createState
   return CodeSendBtnState();
  }

}

class CodeSendBtnState extends State<CodeSendBtn>{

  Timer _timer;
  int _countdownTime = 0;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Container(
        width:72 ,
        height: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colours.app_main
        ),
        child:Text(

          _countdownTime > 0 ? '${_countdownTime}s' : '获取验证码',

          style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w100
          ),
        ) ,

    ) ;
  }

  void clickCode(String phone){
    getSmsCode( phone);
    if (_countdownTime == 0 ) {

    setState(() {
    _countdownTime = 60;
    });
    //开始倒计时
    startCountdownTimer();
  }
  }

   void getSmsCode(String phone) async{

    print(phone);
    Smssdk.getTextCode(phone,"86","", (dynamic ret, Map err){
      if(err!=null){
        print(err);
      }
      else
      {

      }
    });
  }
  void startCountdownTimer() {
    const oneSec = const Duration(seconds: 1);

    var callback = (timer) => {
      setState(() {
        if (_countdownTime < 1) {
          _timer.cancel();
        } else {
          _countdownTime = _countdownTime - 1;
        }
      })
    };

    _timer = Timer.periodic(oneSec, callback);
  }
  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }



}