import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/btn_widget.dart';
import 'package:recruit_app/pages/home/search_bar.dart';
import 'package:recruit_app/pages/share_helper.dart';

import '../city_page.dart';
import 'jobsearch_page.dart';

class JobLocSelelct extends StatefulWidget{
  @override
  _JobLocSelectState createState() {
    // TODO: implement createState
  return _JobLocSelectState();
  }

}

class _JobLocSelectState extends State<JobLocSelelct>{
  TextEditingController textEditingController = TextEditingController();
  String city="选择城市";
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   return Scaffold(
     backgroundColor: Colors.white,
     resizeToAvoidBottomPadding: false,
     appBar: AppBar(
       elevation: 0,
       centerTitle: true,
       title: Text('',
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
             width: 20,
             height: 20,
           ),
           onPressed: () {
             Navigator.pop(context);
           }),
       automaticallyImplyLeading: false,
       backgroundColor: Color.fromRGBO(255, 255, 255, 1),
     ),
     body: Column(
       children: <Widget>[
         SizedBox(height: 30),
         Text("请填写你期望的工作岗位",
           style: TextStyle(
             color: Colors.black87,
             fontWeight: FontWeight.bold,
             fontSize: 24

           ),
         ),
         SizedBox(height: 10),
         Text("以便我们精准推荐",
           style: TextStyle(
               color: Colors.black38,
               fontSize: 16
           ),
         ),
         SizedBox(height: 60),
         Padding(
             padding: EdgeInsets.symmetric(horizontal: 40),
             child:Container(

                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(34 * 0.5),
                   color: Colours.app_main.withOpacity(0.2),
                 ),
                 child: TextField(
                    controller: textEditingController,
                   textAlign: TextAlign.center,
                   decoration: InputDecoration(
                     border: InputBorder.none,
                     contentPadding: const EdgeInsets.symmetric(vertical: 2.0),
                     hintText: "请输入期望职位",
                     hintStyle: TextStyle(
                       fontSize: 12
                     )
                   ),
                 ),
               ),

         )
         ,
         SizedBox(height: 20),
         Padding(
             padding: EdgeInsets.symmetric(horizontal: 40),
             child:GestureDetector(
               onTap: ()async {city = await Navigator.push(context,MaterialPageRoute(builder: (context)=>CityPage()));setState(() {

               });},
               behavior: HitTestBehavior.opaque,
               child:Container(

                 height: 50,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.circular(34 * 0.5),
                   color: Colours.app_main.withOpacity(0.2),
                 ),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: <Widget>[
                     new Image.asset("images/icon_home_search_20x20_@3x.png",
                         width: 14,
                         height: 14,
                         color: Colors.black45),
                     new Container(
                       padding: new EdgeInsets.only(left: 5.0),
                       child: new Text(city,
                         style: new TextStyle(fontSize: 12.0,color: Colors.black45),
                       ),
                     )
                   ],
                 ),
               ),
             )
         )
         ,
         SizedBox(height: 60),
         CustomBtnWidget(
           text: "开始查找",
           btnColor: Colours.app_main,
           onPressed: (){
             if(textEditingController.text.trim().length > 0 && city != "选择城市"){
               ShareHelper.putCity(city);
               Navigator.pushReplacement(context, MaterialPageRoute(
                   builder: (context) => JobSearchPage(textEditingController.text)));
             }
           }
         )
       ],
     ),
   );
  }

}