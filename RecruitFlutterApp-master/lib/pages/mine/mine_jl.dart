import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/mine/me_desc.dart';

import '../account/register/User.dart';
import '../btn_widget.dart';
import '../event_heper.dart';
import '../service/mivice_repository.dart';
import '../share_helper.dart';
import '../share_helper.dart';
import '../storage_manager.dart';

class MineJL extends StatefulWidget {
  @override
  _MineJLState createState() => _MineJLState();
}

class _MineJLState extends State<MineJL> {
  String desc;
  String school;
  String work;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    desc = ShareHelper.getUser().desc ==null||ShareHelper.getUser().desc ==""?"未填写": ShareHelper.getUser().desc;
    school = ShareHelper.getUser().school ==null||ShareHelper.getUser().school ==""?"未填写": ShareHelper.getUser().school;
    work = ShareHelper.getUser().work ==null||ShareHelper.getUser().work ==""?"未填写": ShareHelper.getUser().work;
    xl = ShareHelper.getUser().education ==null||ShareHelper.getUser().education ==""?"未填写": ShareHelper.getUser().education;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar:  AppBar(
        elevation: 0,
        leading: IconButton(
            icon: Image.asset(
              'images/ic_back_arrow.png',
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
        centerTitle: true,
        title: Text('个人中心',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(37, 38, 39, 1))),
      ),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15, top: 18, bottom: 18),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  color: Color.fromRGBO(242, 243, 244, 1),
                  height: 1,
                ),
                Text(
                  '* 自我介绍',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colours.app_main,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: ()async{
                  var mdd = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeDesc(2),
                        ));
                  if(mdd != null){
                    setState(() {
                      desc = mdd;
                    });
                  }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:   Text(desc,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Color.fromRGBO(136, 138, 138, 1))),
                      ),
                      SizedBox(width: 8,),
                      Image.asset(
                        'images/arrow_right.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  color: Color.fromRGBO(242, 243, 244, 1),
                  height: 1,
                ),
                Text(
                  '* 学历',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colours.app_main,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                   _showSexPop(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:   Text(xl,
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Color.fromRGBO(136, 138, 138, 1))),
                      ),
                      SizedBox(width: 8,),
                      Image.asset(
                        'images/arrow_right.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  color: Color.fromRGBO(242, 243, 244, 1),
                  height: 1,
                ),
                Text(
                  '* 最高院校',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colours.app_main,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: ()async{
                  String ss= await  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeDesc(3),
                        ));
                  if(ss != null){
                    setState(() {
                      school = ss;
                    });
                  }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:   Text(school,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Color.fromRGBO(136, 138, 138, 1))),
                      ),
                      SizedBox(width: 8,),
                      Image.asset(
                        'images/arrow_right.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  color: Color.fromRGBO(242, 243, 244, 1),
                  height: 1,
                ),
                Text(
                  '* 工作经历',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colours.app_main,
                  ),
                ),
                SizedBox(height: 8),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: ()async{
                 String ww=await   Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeDesc(4),
                        ));
                 if(ww!=null){
                   setState(() {
                     work = ww;
                   });
                 }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:   Text(work,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Color.fromRGBO(136, 138, 138, 1))),
                      ),
                      SizedBox(width: 8,),
                      Image.asset(
                        'images/arrow_right.png',
                        width: 18,
                        height: 18,
                        fit: BoxFit.cover,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15),
                  color: Color.fromRGBO(242, 243, 244, 1),
                  height: 1,
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
  List _sexList=["初中", "高中", "中专" , "大专", "本科", "硕士", "博士"];
  String xl;
  void _showSexPop(BuildContext context){
    FixedExtentScrollController  scrollController = FixedExtentScrollController(initialItem:0);
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context){
          return _buildBottonPicker(
              CupertinoPicker(

                magnification: 1,
                itemExtent:58 ,
                backgroundColor: Colors.white,
                useMagnifier: true,
                scrollController: scrollController,
                onSelectedItemChanged: (int index){

                      xl = _sexList[index];



                },
                children: List<Widget>.generate(_sexList.length, (index){
                  return Center(
                    child: Text(_sexList[index]),
                  );
                }),
              )
          );
        });
  }

  Widget _buildBottonPicker(Widget picker){
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 52,
          color: Colours.gray_F6F6F6,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(

                left: 20,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Text("取消",
                    style: TextStyle(
                        color: Colours.black_212920,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                    ),),
                ),
              ),
              Positioned(
                right: 20,
                child: GestureDetector(
                  onTap: (){
                    Navigator.pop(context);
                    setState(() {

                        MiviceRepository().upDateInfo("education",xl).then((value) {
                          var reponse = json.decode(value.toString());

                          if(reponse["status"] == "success") {


                            User user = ShareHelper.getUser();

                            user.education = xl;
                            StorageManager.localStorage.setItem(ShareHelper.kUser, user);
                            eventBus.fire(LoginEvent());
                          }else{
                            showToast(reponse["msg"]);
                          }
                        });



                    });

                  },
                  child: Text("确定",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colours.app_main,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),),
                ),
              ),
            ],
          ),
        ) ,
        Container(
          height: 190,
          padding: EdgeInsets.only(top: 6),
          color: Colors.white,
          child: DefaultTextStyle(
            style: const TextStyle(
                color: Colours.black_212920,
                fontSize: 18
            ),
            child: GestureDetector(
              child: SafeArea(
                top: false,
                child: picker,
              ),
            ),
          ),
        )
      ],

    );
  }
}
