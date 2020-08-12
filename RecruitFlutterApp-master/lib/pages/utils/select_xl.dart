import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/event_heper.dart';
import 'package:recruit_app/pages/jobs/all/citys_model.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/utils/screen.dart';

class SelectXl extends StatefulWidget {
  @override
  _SelectXlState createState() => _SelectXlState();
}

class _SelectXlState extends State<SelectXl> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('选择学历',
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
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body:  _buildCitysItem(salarys)
    );
  }
  List <String>salarys=["不限","初中","高中","中专","大专","本科","硕士","博士"];
  Widget _buildCitysItem(List<String> citys) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
      childAspectRatio: 5 / 2.5,
      children: citys.map((cityName) {
        return new InkWell(
          onTap: () {
            switch(cityName){
              case "本科":
              case "硕士":
              case "博士":
              case "不限":
                eventBus.fire(JobRefreshEvent("65",2));
              Navigator.of(context).pop();
                break;
              case "初中":

                eventBus.fire(JobRefreshEvent("66",2));
                Navigator.of(context).pop();
                break;
              case "高中":

                eventBus.fire(JobRefreshEvent("153",2));
                Navigator.of(context).pop();
                break;
              case "中专":

                eventBus.fire(JobRefreshEvent("67",2));
                Navigator.of(context).pop();
                break;
              case "大专":
                eventBus.fire(JobRefreshEvent("68",2));
                Navigator.of(context).pop();
                break;


            }

          },
          child: new Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color:  Colors.transparent,
                border: Border.all(width: 1.0,
                    color:  new Color.fromARGB(255, 242, 242, 245))
            ),
            child: new Center(
              child: new Text(cityName, softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: new TextStyle(
                    color: Colors.black87
                ),),
            ),
          ),
        );
      }).toList(),
    );
  }
}

