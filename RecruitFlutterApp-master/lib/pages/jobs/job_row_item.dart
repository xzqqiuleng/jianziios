import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/job_list.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/widgets/dash_line.dart';

import '../constant.dart';
import '../provider/app_update.dart';
import '../share_helper.dart';
import '../storage_manager.dart';
import '../web_detail.dart';
import 'job_detail.dart';

class JobRowItem extends StatelessWidget {
  final Map<String,dynamic> job;
  final int index;
  final bool lastItem;
  final bool isJi;
  final bool isBz;
    List tags;
   JobRowItem({Key key, this.job, this.index, this.lastItem,this.isJi,this.isBz,})
      : super(key: key);


  Widget getImg(String imgUrl){
    if(imgUrl.contains("http")){
      return  ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(28)),
        child: Image.network(
          imgUrl,
          width: ScreenUtil().setWidth(56),
          height: ScreenUtil().setWidth(56),
          fit: BoxFit.cover,
        ),
      );
    }else{
      return ClipRRect(
        borderRadius: BorderRadius.circular(ScreenUtil().setWidth(28)),
        child: Image.network(
          Constant.deault_compay,
          width: ScreenUtil().setWidth(56),
          height: ScreenUtil().setWidth(56),
          fit: BoxFit.cover,
        ),
      );
    }
  }


  Widget _getTip(){
    tags = job["companyDetList"];
    List<Widget> tipWidget=[];
    List<Widget> columWidget=[];
    if(tags == null|| tags.length>0 ){

      for (var item in tags){
        if(item == " "||item ==""){
          continue;
        }
        tipWidget.add( TextTagWidget("$item",
          backgroundColor: Color(0xFFF0F0F0),
          margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
          padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
          borderRadius: 2,
          borderColor: Color(0xFFF0F0F0),
          textStyle: TextStyle(
              color: Colors.black54,
              fontSize: 12
          ),
        ));
      }

      columWidget.add(Wrap(children: tipWidget));


    }else{
      columWidget.add(Container(height: 0,));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: columWidget,
    );
  }
  @override
  Widget build(BuildContext context) {
    final jobItem = Padding(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(28),
            right: ScreenUtil().setWidth(28),
            top: ScreenUtil().setWidth(20),
            bottom: ScreenUtil().setWidth(30)),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          job["title"].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(32),
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(20, 20, 20, 1),
                          ),
                        ),
                      ),


                    ],
                  ),
                ),
                SizedBox(width: 16),
                Text(job["salary"].toString(),
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
                        fontWeight: FontWeight.bold,
                        color: Colours.app_main)),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setWidth(20),
            ),
            _getTip(),
            SizedBox(
              height: ScreenUtil().setWidth(28),
            ),


            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Expanded(
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        'images/qyrz.png',
                        width: ScreenUtil().setWidth(24),
                        height: ScreenUtil().setWidth(24),
                        fit: BoxFit.cover,
                      ),

                      SizedBox(
                        width: ScreenUtil().setWidth(4),
                      ),
                      Flexible(
                        child: Text(
                          job["companyName"].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(28),
                            color: Color.fromRGBO(57, 57, 57, 1),
                          ),
                        ),
                      ),
                    ],
                  ),

                ),

               Container(
                 height: 28,
                 width: 80,
                 decoration: BoxDecoration(
                   color: Colours.app_main,
                   borderRadius: BorderRadius.circular(2)
                 ),
                 child: Text(
                   "查看",
                   style: TextStyle(
                     color: Colors.white,
                     fontSize: 12
                   ),
                 ),
                 alignment: Alignment.center,
               )
              ],
            ),
           SizedBox(height: 16,),
           Container(
             color: Color(0xfff8f8f8),
             height: 2,
           )
          ],
        ),
      );

    if (lastItem) {
      return jobItem;
    }
    return Column(
      children: <Widget>[
        jobItem,
      index != 0 && index % 4 ==0? GestureDetector(
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
        child:Container(
          margin: EdgeInsets.fromLTRB(14, 4, 14, 4),
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
//              image: AssetImage("images/mid_ad.jpg"),
              image: NetworkImage(getUrl()),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        )
      ):Container(),
      ],
    );
  }

  Map RandomItem;
  String getUrl(){
     String twoJson = StorageManager.sharedPreferences.getString("two");
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
}
