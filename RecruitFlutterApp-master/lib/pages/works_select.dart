import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recruit_app/pages/utils/screen.dart';


class WorksSelect extends StatefulWidget {
  final double height;
  final Color  themeColor;
  final String locationIcon;
  final ValueChanged<String> onValueChanged;

  WorksSelect({Key key,this.height,this.locationIcon = '', this.themeColor = Colors.grey,this.onValueChanged}): super(key:key);

  @override
  _WorksSelectState createState() => _WorksSelectState();
}

class _WorksSelectState extends State<WorksSelect> {
 List models = [];
 Map works=Map();
 int currentSelect = 0;
 bool isTap = false;
 bool isHotCitys = false;
 String selectCityName;


 Future<void> fetchData() async {
    try {

      var responseStr = await rootBundle.loadString('mock/work.json');
      var response = json.decode(responseStr);
      var responseJson = response["data"];
      models  = responseJson['level1'];
      works = responseJson['level0'];


      setState(() {
      });

    } catch (e) {
      print('读取错误：' + e.toString());
    }

  }
  bool isSelect(int index) {
    return currentSelect == index ? true : false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fetchData();
  }

  Widget _buildProvincesItem(String key,String value) {
    return new Container(
      height: 50,
      child: new InkWell(
        onTap: () {
          setState(() {
            currentSelect = int.parse(key);
          });
        },
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: new Center(
                child: new Text(value,maxLines:1,overflow: TextOverflow.ellipsis,style: new TextStyle(fontSize: 12.0,color: isSelect(int.parse(key)) ? Colors.black : Colors.black87,fontWeight: isSelect(int.parse(key)) ? FontWeight.w400:FontWeight.w200),),
              ),
            ),
            new Container(
              width: 4.0,
              height: 20.0,
              color: isSelect(int.parse(key)) ? widget.themeColor : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }

  bool isSelectCity(String cityName,bool isTap,bool isHot) {
    if (cityName == selectCityName && isTap && isHotCitys == isHot) {
      return true;
    }

    return false;
  }

  Widget _buildCitysItem(List<String> citys,bool isHot) {
    return ListView(

      children: citys.map((cityName) {
        return new InkWell(
          onTap: () {
            widget.onValueChanged(cityName);
            selectCityName = cityName;
            isHotCitys = isHot;
            setState(() {
              isTap = true;
            });
            Navigator.of(context).pop(cityName);
          },
          child:  new Container(
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: isSelectCity(cityName, isTap,isHot) ? widget.themeColor.withOpacity(0.08) : Colors.transparent,
              border: Border.all(width: 1.0,color:isSelectCity(cityName, isTap,isHot) ? widget.themeColor: new Color.fromARGB(255, 242, 242, 245))
            ),
            child: new Center(
              child: new Text(cityName, softWrap: false,overflow: TextOverflow.ellipsis,maxLines: 1,style: new TextStyle(
                color: isSelectCity(cityName, isTap,isHot) ? widget.themeColor: Colors.black87
              ),),
            ),
          ),
        );
      }).toList(),
    );
  }


  Widget _buildCitysList() {
    if (models != null && models.length > 0 ) {
       List<String>citys = List();

      for(int i = 0;i < models.length;i++){
          if(currentSelect.toString() == models[i]["pid"].toString()){
            citys.add(models[i]["title"]);
          }
      }
      return new Container(
        margin: new EdgeInsets.only(left: 15.0,top:15.0,right: 15.0),
        child:  _buildCitysItem(citys,isHotCitys)

      );
    }

    return new Container();
  }
 List<Widget> _getP(){
   List<Widget> ws = List();
    works.forEach((key, value) {

      ws.add(_buildProvincesItem(key, value)) ;
   });
    return ws;
 }
  @override
  Widget build(BuildContext context) {
    return Container(
        width: Screen.width,
        height: widget.height,
        child: new Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: new Container(
                color: new Color(0xfff8f8f8),
                child: ListView(
                  children: _getP()
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: new Container(
                color: Colors.white,
                child: _buildCitysList(),
              ),
            )
          ],
        ),
    );
  }
}