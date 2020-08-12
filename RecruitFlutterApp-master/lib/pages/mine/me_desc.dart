import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/pages/account/register/User.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/storage_manager.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

import '../event_heper.dart';
import '../event_heper.dart';

class MeDesc extends StatefulWidget {
  int type; //0, 1，公司名称 2，工作职位 3.工作内容
  MeDesc(this.type);
  @override
  _MeDescState createState() => _MeDescState();
}

class _MeDescState extends State<MeDesc> {
  TextEditingController _phoneController = TextEditingController();
  String title = "";
  String hint = "";
  int line = 1;
  String mkey="";
   Map jl = Map();
  void upDateInfo(){
    if(_phoneController.text.length <= 0){
      showToast("请正确输入信息");
    } else {

      MiviceRepository().upDateInfo(mkey,_phoneController.text).then((value) {
        var reponse = json.decode(value.toString());

        if(reponse["status"] == "success") {


          User user = ShareHelper.getUser();
          switch(widget.type){
            case 0:
              user.nick_name = _phoneController.text;
              break;
            case 1:
              user.wxId = _phoneController.text;
              break;
            case 2:
              user.desc = _phoneController.text;
              break;
            case 3:
              user.school = _phoneController.text;
              break;
            case 4:
              user.work = _phoneController.text;
              break;
        }
          StorageManager.localStorage.setItem(ShareHelper.kUser, user);

          Navigator.of(context).pop(_phoneController.text);
          eventBus.fire(LoginEvent());
        }else{
          showToast(reponse["msg"]);
        }
      });
    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch(widget.type){
      case 0:
        title = "修改姓名";
        hint = "请输入真实姓名";
        line = 1;
        mkey = "nick_name";
        break;
      case 1:
        title = "修改微信号";
        hint = "  请填写真实的微信号，以便于我们联系你";
        line = 1;
        mkey = "wxId";
        break;
      case 2:
        title = "自我介绍";
        hint = "请用简单的自我介绍，展示你的优势";
        line = 10;
        mkey = "desc";
        break;
      case 3:
        title = "最高院校";
        hint = "你的毕业院校/或在读院校";
        line = 1;
        mkey = "school";
        break;
      case 4:
        title = "工作经历";
        hint = "最近一次的工作经历描述";
        line = 10;
        mkey = "work";
        break;


    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFdFdFd),
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        title: Text(title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(37, 38, 39, 1))),
        leading: IconButton(
            icon: Image.asset(
              'images/ic_back_arrow.png',
              width: 16,
              height: 16,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'images/complete.png',
                width: 20,
                height: 20,
              ),
              onPressed: () {upDateInfo();}),
        ],
      ),
      body:  Container(
        margin: EdgeInsets.all(20),
        child: LogRegTextField(

          label: hint,
          controller:  _phoneController,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.phone,
          obscureText: false,

        ),
      ),
    );

  }
}
