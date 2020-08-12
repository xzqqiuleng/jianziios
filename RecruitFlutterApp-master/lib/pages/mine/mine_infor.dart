import 'dart:convert';
import 'dart:io';

import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/account/register/User.dart';
import 'package:recruit_app/pages/mine/me_desc.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/widgets/photo_select.dart';

import '../btn_widget.dart';
import '../event_heper.dart';
import '../event_heper.dart';
import '../storage_manager.dart';

class MineInfor extends StatefulWidget {
  @override
  _MineInforState createState() => _MineInforState();
}


class _MineInforState extends State<MineInfor> {
  User user;
  String nickName;
  String wxStr;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    user = ShareHelper.getUser();
    nickName= user.nick_name == null||user.nick_name == ""?"未填写":user.nick_name;
    wxStr= user.wxId == null||user.wxId == ""?"未填写":user.wxId;
    birthday = user.birthday == null||user.birthday == ""?"未填写":user.birthday;
    _sex = user.sex == null||user.sex == ""?"未填写":user.sex;
    url = user.head_img == null||user.head_img == ""?"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=145692761,4091651670&fm=26&gp=0.jpg":user.head_img;
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
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                    _showSelectPhoto();
                  },
                  child:  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[

                      Expanded(
                          child: Text(
                            '头像',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize:14,
                              color: Colors.black87,
                            ),
                          )
                      ),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: url.contains("http")?Image.network(
                          url,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ):Image.file(
                          File(url),
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
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

                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: ()async{
                  String mN = await  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeDesc(0),

                        ));
                  if(mN == null){
                    return;
                  }
                  setState(() {
                    nickName = mN;
                  });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:   Text('姓名',
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Colors.black87)),
                      ),
                Text(nickName,
                style: TextStyle(
                    wordSpacing: 1,
                    letterSpacing: 1,
                    fontSize: 14,
                    color: Colors.black38)),
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
                        child:   Text('性别',
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Colors.black87)),
                      ),
                      Text(_sex,
                          style: TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 14,
                              color: Colors.black38)),
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
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: (){
                  _showDatePop(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:   Text('生日',
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Colors.black87)),
                      ),
                      Text(birthday,
                          style: TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 14,
                              color: Colors.black38)),
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
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: ()async{
                  String mwx =  await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MeDesc(1),
                        ));
                  if(mwx == null){
                    return;
                  }
                  setState(() {
                    wxStr = mwx;
                  });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child:   Text('微信',
                            style: TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 14,
                                color: Colors.black87)),
                      ),
                      Text(wxStr,
                          style: TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 14,
                              color: Colors.black38)),
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
                SizedBox(
                  height: 30,
                ),
                CustomBtnWidget(
                    btnColor: Colours.app_main,
                    text: "退出登录",
                    onPressed: () {
                      StorageManager.localStorage.deleteItem(ShareHelper.kUser);
                      StorageManager.sharedPreferences.setBool(
                          ShareHelper.is_Login, false);
                      eventBus.fire(LoginEvent());
                      Navigator.of(context).pop();
                    }
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
  List _sexList=["男","女"];
  String _sex="男";
  String msex="男";
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

                      msex = _sexList[index];

                },
                children: List<Widget>.generate(_sexList.length, (index){
                  return Center(
                    child: Text(_sexList[index]),
                  );
                }),
              ),0
          );
        });
  }
  DateTime _initDate = DateTime.now();
  String birthday="";
  String mbirthday="";

  void _showDatePop(BuildContext context){

    showCupertinoModalPopup<void>(context: context, builder: (BuildContext cotext){

      return _buildBottonPicker(CupertinoDatePicker(
        minimumYear: _initDate.year-100,
        maximumYear: _initDate.year,
        mode: CupertinoDatePickerMode.date,
        initialDateTime: _initDate,
        onDateTimeChanged: (DateTime dataTime){

              mbirthday =  formatDate(dataTime, [yyyy,"-",mm,"-",dd]);

        },
      ),1);
    });
  }
  Widget _buildBottonPicker(Widget picker,int type){
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

                      if(type == 0){
                        _sex = msex;
                        MiviceRepository().upDateInfo("sex",_sex).then((value) {
                          var reponse = json.decode(value.toString());

                          if(reponse["status"] == "success") {


                            User user = ShareHelper.getUser();

                                user.sex = _sex;
                            StorageManager.localStorage.setItem(ShareHelper.kUser, user);
                          }else{
                            showToast(reponse["msg"]);
                          }
                        });
                      }else{
                        birthday =mbirthday;
                        MiviceRepository().upDateInfo("birthday",birthday).then((value) {
                          var reponse = json.decode(value.toString());

                          if(reponse["status"] == "success") {


                            User user = ShareHelper.getUser();

                            user.birthday = birthday;
                            StorageManager.localStorage.setItem(ShareHelper.kUser, user);
                          }else{
                            showToast(reponse["msg"]);
                          }
                        });
                      }




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

  ImagePicker _picker;
  String url;
  /*拍照*/
  _takePhoto() async {

    var image = await _picker.getImage(source: ImageSource.camera);
    _cancle();
    if(image == null){
      return;
    }
    _upLoadImage(image.path);
    setState(() {
      url = image.path;
    });
  }
  /*相册*/
  _openGallery() async {

    var image = await _picker.getImage(source: ImageSource.gallery);
    _cancle();
    if(image == null){
      return;
    }
  _upLoadImage(image.path);
    setState(() {

      url = image.path;
    });
  }
  _upLoadImage(String path){
    MiviceRepository.upLoadPicture(path).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success") {
     String   head_img = reponse["result"]["url"];
        MiviceRepository().upDateInfo("head_img",head_img).then((value) {
          var reponse = json.decode(value.toString());

          if(reponse["status"] == "success") {


            User user = ShareHelper.getUser();

            user.head_img = head_img;
            StorageManager.localStorage.setItem(ShareHelper.kUser, user);
          }else{
            showToast(reponse["msg"]);
          }
        });
      }
    });
  }
  _cancle(){
    Navigator.of(context).pop();
  }
  void _showSelectPhoto(){

    if(_picker == null){
      _picker = new ImagePicker();
    }
    showModalBottomSheet(

      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return PhotoSelectWidget(_openGallery,_takePhoto,_cancle);
      },
    );
  }
}
