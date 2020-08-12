import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import '../colours.dart';
import '../colours.dart';

class BmResult extends StatefulWidget {
  Map jobInfo ;
  BmResult(this.jobInfo);
  @override
  _BmResultState createState() => _BmResultState();
}
 String wx="";

class _BmResultState extends State<BmResult> {

  _loadData(){

    new MiviceRepository().getWxID().then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
         List wxS = reponse["result"];
         if(wxS.length>0){
           var rng = new Random();
         int pos =  rng.nextInt(wxS.length);
         setState(() {

           wx = wxS[pos]["wx_num"].toString();
         });

         }

      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('报名详情',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        leading: IconButton(
            icon: Image.asset(
              'images/ic_back_arrow.png',
              width: 18,
              height: 18,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              height: 150,
             padding: EdgeInsets.only(top: 20),
             alignment: Alignment.topCenter,
              child:  Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[

                  Image.asset(
                    'images/bm_success.png',
                    width: 70,
                    height: 70,
                  ),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("报名成功",

                            style: const TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        SizedBox(
                          height: 10,
                        ),
                        Text("平台将时刻跟进报名流程",
                            style: const TextStyle(
                                wordSpacing: 1,
                                letterSpacing: 1,
                                fontSize: 12,
                                color: Colors.black54)),
                      ]
                  )
                ],
              )
              ,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 160,
            bottom: 0,
            child:SingleChildScrollView(
              child:Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    children: <Widget>[
                      Card(
                          elevation:1,
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                Text(widget.jobInfo["title"],

                                    style: const TextStyle(
                                        wordSpacing: 1,
                                        letterSpacing: 1,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500,
                                        color: Color.fromRGBO(37, 38, 39, 1))),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(widget.jobInfo["salary"],
                                    style: const TextStyle(
                                        wordSpacing: 1,
                                        letterSpacing: 1,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colours.app_main)),
                                SizedBox(
                                  height: 16,
                                ),
                                Container(
                                  height: 1,
                                  color: Color(0xfff8f8f8),
                                ),
                                SizedBox(
                                  height: 24,
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Color(0xfffff7de)
                                  ),
                                  child:Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: <Widget>[

                                      Text(
                                          "注意事项",
                                          style: TextStyle(
                                              color: Color(0xffff552e),
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold
                                          )
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text(
                                          "你已成功报名此职位，请主动添加下方的微信号，联系企业官方工作发布人员。",
                                          style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12
                                          )
                                      ),

                                    ],
                                  ) ,
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                Center(
                                  child: Container(
                                    padding: EdgeInsets.fromLTRB(20, 6, 20, 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      border: new Border.all(color:  Colours.app_main, width: 0.6),

                                    ),
                                    child: Text(
                                      "微信号： ${wx}",
                                      style: TextStyle(
                                          color: Colors.black
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 16,
                                ),
                                CustomBtnWidget(
                                  onPressed: (){
                                    Clipboard.setData(ClipboardData(text: wx));
                                    launch("weixin://");
                                  },
                                  radius: 30,
                                  margin: 0,
                                  height: 40,
                                  fontSize: 12,
                                  btnColor: Colours.app_main,
                                  text: "一键复制微信\n前去联系企业",
                                )
                              ],
                            ),
                          )
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text('--  步骤指引  --',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(37, 38, 39, 1))),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: <Widget>[

                          Container(
                            width: 90,
                            height: 90,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image:DecorationImage(
                                  image:AssetImage("images/lc_tab.png"),

                                )
                            ),
                            child: Text(
                                "步骤一      ",
                                style: TextStyle(
                                  color: Colours.app_main,

                                )
                            ),
                          ),
                          SizedBox(width: 40),
                          Text(
                            "兼职报名",
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16
                            ),
                          )
                        ],
                      ),

                      Row(
                        children: <Widget>[

                          Image.asset("images/lc_line.png",height: 60,),
                          SizedBox(width: 60),
                          Text(
                              "查看兼职，符合条件，点击报名",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12
                              )
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 90,
                            height: 90,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image:DecorationImage(
                                    image:AssetImage("images/lc_tab.png")
                                )
                            ),
                            child: Text(
                                "步骤二      ",
                                style: TextStyle(
                                  color: Colours.app_main,

                                )
                            ),
                          ),
                          SizedBox(width: 40),
                          Text(
                            "添加企业           ",
                            style: TextStyle(
                              color: Colors.black87,

                            ),
                          )
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Image.asset("images/lc_line.png",height: 60,),
                          SizedBox(width: 60),
                          Text(
                              "添加页面的企业微信号，核实企业身份！",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12
                              )
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 90,
                            height: 90,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image:DecorationImage(
                                    image:AssetImage("images/lc_tab.png")
                                )
                            ),
                            child: Text(
                                "步骤三      ",
                                style: TextStyle(
                                  color: Colours.app_main,

                                )
                            ),
                          ),
                          SizedBox(width: 40),
                          Text(
                            "工作签约           ",
                            style: TextStyle(
                              color: Colors.black87,

                            ),
                          )
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Image.asset("images/lc_line.png",height: 60,),
                          SizedBox(width: 60),
                          Text(
                              "双方沟通，完成签约，正式上班",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12
                              )
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[

                          Container(
                            width: 90,
                            height: 90,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                image:DecorationImage(
                                    image:AssetImage("images/lc_tab.png")
                                )
                            ),
                            child: Text(
                                "步骤四      ",
                                style: TextStyle(
                                  color: Colours.app_main,

                                )
                            ),
                          ),
                          SizedBox(width: 40),
                          Text(
                            "兼职完成           ",
                            style: TextStyle(
                              color: Colors.black87,

                            ),
                          )
                        ],
                      ),

                      Row(
                        children: <Widget>[

                          Image.asset("images/lc_line.png",height: 60,color: Colors.white,),
                          SizedBox(width: 60),
                          Text(
                              "无合同违规，等待薪资发放",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12
                              )
                          )
                        ],
                      ),
                    ],

                  ),
                )

            )
          )

        ],
      )
    );
  }
}
