import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/jobs/job_detail.dart';
import 'package:recruit_app/pages/jz_titl.dart';
import 'package:recruit_app/pages/jzjxpage.dart';
import 'package:recruit_app/pages/provider/app_update.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/storage_manager.dart';
import 'package:recruit_app/pages/web_detail.dart';

class JXPageTab extends StatefulWidget {
  @override
  _JXPageTabState createState() => _JXPageTabState();
}

class _JXPageTabState extends State<JXPageTab> {

  List<String> images =["images/zt_a1.png","images/zt_a2.png","images/zt_a3.png","images/zt_a4.png","images/zt_a5.png"];
  List<String> bgs =["images/h_bt1.png","images/h_bt2.png"];
  List<String> imageZs =["images/bg2.jpg","images/bg1.jpg","images/bg4.jpg","images/bg3.jpg"];
  List<String> txt=["周末兼职","模特T台","主播聊天","学生校园","抖音视频"];
  List<String> txtS=["  校内兼职专题","  线上兼职专题","  兼职赚钱专题","  特色兼职赚题"];
  List<String> txDesc=["   校内兼职汇总，专为大学生打造的专题","   在家就能完成兼职，让你足不出户赚工资","   小编推荐专题，精心挑选性价比高的兼职","   特色兼职，我就是要和别人不同，我的工作也是一种特色"];



  Map RandomItem;
  String getUrl(){
    String twoJson = StorageManager.sharedPreferences.getString("three");
    if(twoJson != null){
      List datass = json.decode(twoJson);
      if(!datass.isEmpty && datass.length>0){
        var rng = new Random();
        int pos =  rng.nextInt(datass.length);
        RandomItem = datass[pos];
        return RandomItem["img_url"];
      }else{
        return "";
      }
    }else{
      return"";
    }



  }
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
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("精选专栏",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                if(RandomItem == null){
                  return;
                }
                if(RandomItem["go_type"].toString() == "app"){
                  if(RandomItem["link_url"].toString().length < 3){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>JobDetail(0,url:"http://www.zaojiong.com/job/34.html")));
                  }else{
                    downloadUrlApp(context,RandomItem[" link_url"].toString());
                  }

                }else{
                  if(RandomItem["link_url"].toString().length < 3){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>JobDetail(0,url:"http://www.zaojiong.com/job/34.html")));
                  }else{
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>WebPage(RandomItem[" link_url"].toString())));
                  }

                }
              },
              behavior: HitTestBehavior.opaque,
              child: Card(
                elevation: 2,
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Container(
                  height: 140,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      image: DecorationImage(
//                image: AssetImage("images/zt_top.jpg"),
                          image:  NetworkImage(getUrl()),
                          fit: BoxFit.fill
                      )
                  ),
                ),
              )
            ),

            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
               Text(
                 "--  小编精选  --",
                 style: TextStyle(
                   fontSize: 20,
                   fontWeight: FontWeight.bold,
                   color: Colors.black
                 ),
               )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10),
              child:   GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:3 ,//每行三列
                      childAspectRatio: 1.4 //显示区域宽高相等
                  ),
                  itemCount: images.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    //如果显示到最后一个并且Icon总数小于200时继续获取数据
                    return  GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: (){
                        String surl;
                        switch(index){
                          case 0:
                            surl ="http://www.zaojiong.com/job/?c=search&keyword=%E5%91%A8%E6%9C%AB&minsalary=&maxsalary=";
                            break;
                          case 1:
                            surl ="http://www.zaojiong.com/job/?c=search&keyword=%E6%A8%A1%E7%89%B9&minsalary=&maxsalary=";
                            break;
                          case 2:
                            surl ="http://www.zaojiong.com/job/?c=search&keyword=%E4%B8%BB%E6%92%AD&minsalary=&maxsalary=";
                            break;

                          case 3:
                            surl ="http://www.zaojiong.com/job/?c=search&keyword=%E5%AD%A6%E7%94%9F&minsalary=&maxsalary=";
                            break;

                          case 4:
                            surl ="http://www.zaojiong.com/job/?c=search&keyword=%E5%A8%B1%E4%B9%90%E4%B8%BB%E6%92%AD&minsalary=&maxsalary=";
                            break;
                        }
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => JzTitl(  txt[index],surl)));
                      },
//                    child:Column(
//                      children: [
//                        Image.asset(images[index],width: 40,height: 40,),
//                        SizedBox(
//                          height: 8,
//                        ),
//                        Text(
//                          txt[index],
//
//                        ),
//
//                      ],
//                    ),
                      child:   Container(
                        margin: EdgeInsets.fromLTRB(0, 0,10, 10),
                        height: 80,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(bgs[index % 2]),
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Positioned(
                              top:20,
                              child: Text(
                                txt[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,

                                ),
                              ),
                            ),

                            Positioned(
                              right: 6,
                              bottom:6,
                              child: Image.asset(images[index],height: 20,width: 20,),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "--  专栏推荐  --",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),
                )
              ],
            ),
            SizedBox(
              height: 16,
            ),
            ListView.builder(itemBuilder:(context, index) {

                 return GestureDetector(
                   behavior: HitTestBehavior.opaque,
                   onTap: (){
                     Navigator.push(
                         context,
                         MaterialPageRoute(
                             builder: (context) => JZJXPage(index)));
                   },
                   child:Card(
                     margin:EdgeInsets.all(12) ,
                     child: Padding(
                         padding: EdgeInsets.all(0),
                         child: Column(
                             mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.stretch,
                             children: [
                               Container(
                                 margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                 height: 120,
                                 decoration: BoxDecoration(
                                   image: DecorationImage(
                                     image: AssetImage(imageZs[index]),
                                     fit: BoxFit.fill,
                                   ),
                                   borderRadius: BorderRadius.circular(4),
                                 ),
                               ),
                               SizedBox(
                                 height: 2,
                               ),
                               Text(
                                 txtS[index],
                                 style: TextStyle(
                                     fontSize: 16,
                                     fontWeight: FontWeight.bold
                                 ),
                               ),
                               SizedBox(
                                 height: 2,
                               ),
                               Text(
                                 txDesc[index],
                                 style: TextStyle(
                                     fontSize: 12,
                                     color: Colors.grey
                                 ),
                               ),
                               SizedBox(
                                 height: 10,
                               ),

                             ]
                         )
                     )
                   )
                 );
             },
            itemCount: imageZs.length,
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics()
            )
          ],

        )
      ),
    );
  }
}
