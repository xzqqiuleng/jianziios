import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/pages/utils/gaps.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';
import 'package:recruit_app/widgets/photo_select.dart';

class FeedbackPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.bg_color,
        title: Text("意见反馈",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colours.black_212920
          ),
        ),
        leading: Builder(builder: (context) {
          return IconButton(
            icon: Icon(Icons.arrow_back, color: Colours.black_212920), //自定义图标
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          );
        },
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body:FeedBackWidget(),

      resizeToAvoidBottomPadding: false,
    );
  }

}

class FeedBackWidget extends StatefulWidget{


  @override
  _FeedBackState createState() {
    // TODO: implement createState
    return _FeedBackState();
  }

}

class _FeedBackState extends State<FeedBackWidget>{
//  PickedFile _imageFile;


  ImagePicker _picker;
  List<String> fileStrs = List();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

          return   Column(

            children: <Widget>[

              Flex(
                direction: Axis.horizontal,
                children: <Widget>[
                  Gaps.hGap20,
                  Text("*",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colours.red_ffd5351c
                    ),

                  ),
                  Text("标题",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colours.black_212920,
                        fontWeight: FontWeight.bold
                    ),

                  ),
                  Gaps.hGap20,
                  Expanded(
                    flex: 1,
                    child: LogRegTextField(
                      controller: _titleController,
                      label: "请输入问题",
                      textInputAction: TextInputAction.next,
                      textInputType: TextInputType.text,
                      obscureText: false,

                    ),
                  ),
                  Gaps.hGap20,
                ],
              ) ,

              Stack(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(20),
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            color: Colours.green_d8e0d6
                        ),
                        child: TextField(
                         controller: _contentController,
                          cursorColor: Colours.app_main,
                          maxLines: 4,
                          decoration: InputDecoration(

                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.transparent)
                            ),
                            //获得焦点下划线设为蓝色
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color:  Colors.transparent),
                            ),
                            hintText: "请简要说明这个问题，我们会尽快解决。",
                            hintStyle: TextStyle(
                                fontSize: 12,
                                color: Colours.gray_8A8F8A
                            ),
                            labelStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 12
                            ),

                          ),
                        ),
                      ),

                      Positioned(
                          bottom: 40,
                          left: 40,
                          child:  GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap:_showSelectPhoto,
                            child: Container(
                              height: 50,
                              width: 50,

                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(4)
                              ),
                              child: Image(
                                image: AssetImage("images/icon_carema.png"),
                                width: 19,
                                height: 16,
                              ),
                            ),
                          )
                      )
                    ],
                  )
                ],
              ),
              Container(
                height: 100,
                margin: EdgeInsets.fromLTRB(20, 0, 16, 0),
                child:  GridView.builder(
                    itemCount: fileStrs.length ,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, //横轴三个子widget

                    ),
                    itemBuilder: (context,index){

                      return Padding(padding: EdgeInsets.fromLTRB(0, 0, 4, 0),
                        child:  Image.file(File(fileStrs[index]),
                          width: 70,
                          height: 70,
                          fit: BoxFit.cover,),
                      );

                    }
                ) ,
              ),
              Gaps.vGap32,
              CustomBtnWidget(
                onPressed: () =>_putFeed(),
                margin: 20,
                height: 48,
                text: "提交",
                btnColor: Colours.app_main,
              )
            ],
          );

  }

  _putFeed(){
    if(_titleController.text.isEmpty){
      showToast("请填写标题");
      return;
    }
    if(_contentController.text.isEmpty){
      showToast("请填写内容");
      return;
    }
    showToast("反馈已发送");
            Navigator.of(context).pop();
//    if(fileStrs != null && fileStrs.length >0){
//      ProgressDialog.showProgress(context);
//
//      // Receive messages from platform
//      _channel.setMessageHandler((String message) async {
//        ProgressDialog.dismiss(context);
//        if(message == "false"){
//          showToast(S.of(context).upload_erro_img);
//        }else{
//          List imgUrls = json.decode(message);
//          modle.putFeed(_titleController.text, _contentController.text,images: imgUrls).then((value) {
//            showToast(S.of(context).feed_send);
//            Navigator.of(context).pop();
//          });
//        }
//
//
//        return 'Reply from Dart';
//      });
//      Map map = Map();
//      map["type"] ="1";
//      map["user_id"] =UserHelper.getUser().id;
//      map["imgs"] =fileStrs;
//      _channel.send(json.encode(map));
//    }else{
//      modle.putFeed(_titleController.text, _contentController.text).then((value) {
//        showToast(S.of(context).feed_send);
//        Navigator.of(context).pop();
//      });
//    }



  }

    /*拍照*/
  _takePhoto() async {

    var image = await _picker.getImage(source: ImageSource.camera);
    _cancle();
    if(image == null){
      return;
    }

    setState(() {
      fileStrs.add(image.path);
    });
  }
  /*相册*/
  _openGallery() async {

    var image = await _picker.getImage(source: ImageSource.gallery);
    _cancle();
    if(image == null){
      return;
    }

    setState(() {

      fileStrs.add(image.path);
    });
  }
  _cancle(){
    Navigator.of(context).pop();
  }
  void _showSelectPhoto(){
      if(fileStrs.length == 3){
        showToast("最多选择三张图片");
        return;
      }
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