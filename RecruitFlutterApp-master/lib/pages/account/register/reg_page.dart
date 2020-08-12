import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobsms/mobsms.dart';
import 'package:mobsms/mobsms.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/account/register/User.dart';
import 'package:recruit_app/pages/account/register/code_send_btn.dart';
import 'package:recruit_app/pages/event_heper.dart';
import 'package:recruit_app/pages/home/recruit_home_app.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

import '../../storage_manager.dart';


class RegPage extends StatefulWidget{
  @override
  _ForgetState createState() {
    // TODO: implement createState
    return _ForgetState();
  }


}

class _ForgetState extends State<RegPage>{
  GlobalKey<CodeSendBtnState> _codeSendKey = new GlobalKey<CodeSendBtnState>();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _codeController = TextEditingController();
  TextEditingController _newPdController = TextEditingController();
  TextEditingController _ConfirmPdController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    _codeController.dispose();
    _newPdController.dispose();
    _ConfirmPdController.dispose();

    super.dispose();
  }

  void setNewPd(){
    if(_newPdController.text.length <6 || _ConfirmPdController.text.length<6){
      showToast("密码格式不正确，最低6位数");
    } else if(_newPdController.text != _ConfirmPdController.text){
       showToast("两次密码输入不一致");
    }else {

      Smssdk.commitCode(_phoneController.text,"86", _codeController.text, (dynamic ret, Map err){
        if(err!=null){
   print(err);
        }
        else
        {
          MiviceRepository().registerPd(_phoneController.text, _newPdController.text).then((value) {
            var reponse = json.decode(value.toString());

            //"result": {
            //        "user_mail": "15671621652",
            //        "type": "1",
            //        "create_time": 1594561222638,
            //        "user_id": "b0fdb885476d46dab13ccc1a82b98070",
            //        "user_name": "15671621652"
            //    },
            if(reponse["status"] == "success") {
              var data = reponse["result"];


              User user = User.fromJson(data);
              StorageManager.localStorage.setItem(ShareHelper.kUser, user.toJson());
              StorageManager.sharedPreferences.setBool(ShareHelper.is_Login, true);
              eventBus.fire(new LoginEvent());
              Navigator.of(context).pop(true);
            }else{
              showToast(reponse["msg"]);
            }
          });
        }
      });

    }

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Scaffold(
    body: SingleChildScrollView(


        child: Stack(
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
                            SizedBox(height: 50,),
                            LogRegTextField(

                              label: "手机号",
                              controller:  _phoneController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.phone,
                              obscureText: false,

                            ),

                            SizedBox(height: 30,),
                            Stack(
                              children: <Widget>[
                                LogRegTextField(

                                  label: "请输入验证码",
                                  controller:  _codeController,
                                  textInputAction: TextInputAction.next,
                                  textInputType: TextInputType.number,
                                  obscureText: false,

                                ),

                                Positioned(
                                    right: 0,
                                    bottom: 10,
                                    child: GestureDetector(
                                        child: CodeSendBtn(key:_codeSendKey),
                                        onTap: (){
                                          _codeSendKey.currentState.clickCode(_phoneController.text);
                                        }
                                    )
                                )
                              ],
                            ),
                            SizedBox(height: 30,),
                            LogRegTextField(

                              label: "新密码",
                              controller:  _newPdController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              obscureText: true,

                            ),

                            SizedBox(height:30,),
                            LogRegTextField(

                              label: "确认密码",
                              controller:  _ConfirmPdController,
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.text,
                              obscureText: true,

                            ),

                            SizedBox(height: 30,),
                            GestureDetector(

                                onTap: () => setNewPd(),

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
                                        child:Text("注册",
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

              ),
    ),
    backgroundColor: Colors.white,
    resizeToAvoidBottomPadding: false,
  );
  }
  
}

