import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/event_heper.dart';
import 'package:recruit_app/pages/jobs/all/citys_model.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/utils/screen.dart';

class SelectCity extends StatefulWidget {
  @override
  _SelectCityState createState() => _SelectCityState();
}

class _SelectCityState extends State<SelectCity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('选择城市',
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
      body:  JzCitysSelect(themeColor: Colours.app_main,
        locationIcon: "images/select_loc.png",
        onValueChanged: (city) {
          Navigator.of(context).pop(city);
        },
      ),
    );
  }
}

class JzCitysSelect extends StatefulWidget {
  final double height;
  final Color  themeColor;
  final String locationIcon;
  final ValueChanged<String> onValueChanged;

  JzCitysSelect({Key key,this.height,this.locationIcon = '', this.themeColor = Colors.grey,this.onValueChanged}): super(key:key);

  @override
  _JzCitysSelectState createState() => _JzCitysSelectState();
}

class _JzCitysSelectState extends State<JzCitysSelect> {
  List<CitysModel> models = [];
  int currentSelect = 0;
  bool isTap = false;
  bool isHotCitys = false;
  String selectCityName;


  Future<void> fetchData() async {
    try {
      List<String> hotCitys = ["北京", "天津", "上海", "重庆", "江苏", "广东", "浙江"];
      List<String> allCitys = [
        "全部",
        "北京",
        "天津",
        "上海",
        "重庆",
        "江苏",
        "广东",
        "浙江",
        "安徽",
        "福建",
        "辽宁",
        "黑龙江",
        "湖南",
        "河南",
        "云南",
        "海南",
        "江西",
        "四川",
        "陕西",
        "山东"
      ];


      List<String> historyCitys = [];
      historyCitys.addAll(["北京", "广东", "上海"]);
      String currentCity = ShareHelper.getCity() == ""?"全部":ShareHelper.getCity();
      CitysModel hotModel = CitysModel(name: "常用",
          currentCity: currentCity,
          citys: hotCitys,
          historyCitys: historyCitys,
          allCitys: allCitys);
      models.add(hotModel);


      setState(() {});
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


  bool isSelectCity(String cityName, bool isTap, bool isHot) {
    if (cityName == selectCityName && isTap && isHotCitys == isHot) {
      return true;
    }

    return false;
  }
  List<String> allNums = [
    "0",
    "2",
    "27",
    "25",
    "32",
    "16",
    "6",
    "31",
    "3",
    "4",
    "18",
    "12",
    "14",
    "11",
    "30",
    "9",
    "17",
    "26",
    "24",
    "22"
  ];
  List<String> allMMCitys = [
    "全部",
    "北京",
    "天津",
    "上海",
    "重庆",
    "江苏",
    "广东",
    "浙江",
    "安徽",
    "福建",
    "辽宁",
    "黑龙江",
    "湖南",
    "河南",
    "云南",
    "海南",
    "江西",
    "四川",
    "陕西",
    "山东"
  ];
  Widget _buildCitysItem(List<String> citys, bool isHot) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
      childAspectRatio: 5 / 2.5,
      children: citys.map((cityName) {
        return new InkWell(
          onTap: () {

            selectCityName = cityName;
            isHotCitys = isHot;
            ShareHelper.putCity(cityName);

            for(int j=0;j< allMMCitys.length;j++){
              if(allMMCitys[j] == cityName){
                eventBus.fire(JobRefreshEvent(allNums[j],0));
              }
            }
            widget.onValueChanged(cityName);
            setState(() {
              isTap = true;
            });
          },
          child: new Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color: isSelectCity(cityName, isTap, isHot) ? widget.themeColor
                    .withOpacity(0.08) : Colors.transparent,
                border: Border.all(width: 1.0,
                    color: isSelectCity(cityName, isTap, isHot) ? widget
                        .themeColor : new Color.fromARGB(255, 242, 242, 245))
            ),
            child: new Center(
              child: new Text(cityName, softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: new TextStyle(
                    color: isSelectCity(cityName, isTap, isHot) ? widget
                        .themeColor : Colors.black87
                ),),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildNormalCitys() {
    final double width = (Screen.width * 0.75 - 15.0 * 4) / 3;
    final double height = width * 0.5 + 15.0;
    final historyCitysHeight = (models[currentSelect].historyCitys.length % 3 ==
        0) ? height * (models[currentSelect].historyCitys.length / 3) : height *
        (models[currentSelect].historyCitys.length / 3 + 1);
    final hotCitysHeight = (models[currentSelect].citys.length % 3 == 0)
        ? height * (models[currentSelect].citys.length / 3)
        : height * (models[currentSelect].citys.length / 3 + 1);
    final allCitysHeight = (models[currentSelect].allCitys.length % 3 == 0)
        ? height * (models[currentSelect].allCitys.length / 3)
        : height * (models[currentSelect].allCitys.length / 3 + 1);

    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("当前定位",
                    style: new TextStyle(fontSize: 15.0, color: Colors.black)),
                new Container(
                  margin: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: new Container(
                    width: width,
                    height: height - 15.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        border: Border.all(width: 1.0,
                            color: new Color.fromARGB(255, 242, 242, 245))
                    ),
                    child: new Center(
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                            child: new Image.asset(
                              widget.locationIcon,
                              width: 11.0,
                              height: 13.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: new Text(models[currentSelect].currentCity,
                              style: TextStyle(color: widget.themeColor),
                              softWrap: false,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("最多搜索",
                    style: new TextStyle(fontSize: 15.0, color: Colors.black)),
                new Container(
                  margin: EdgeInsets.only(top: 15.0,bottom: 16),
                  height: historyCitysHeight,
                  child: _buildCitysItem(
                      models[currentSelect].historyCitys, false),
                )
              ],
            ),
          ),
          new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("热门城市",
                  style: new TextStyle(fontSize: 15.0, color: Colors.black),),
                new Container(
                  margin: EdgeInsets.only(top: 15.0,bottom: 16),
                  height: hotCitysHeight,
                  child: _buildCitysItem(models[currentSelect].citys, true),
                )
              ],
            ),
          ),
          new Container(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Text("全部城市",
                  style: new TextStyle(fontSize: 15.0, color: Colors.black),),
                new Container(
                  margin: EdgeInsets.only(top: 15.0,bottom: 16),
                  height: allCitysHeight,
                  child: _buildCitysItem(models[currentSelect].allCitys, true),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCitysList() {
    if (models != null && models.length > 0) {
      return new Container(
        margin: new EdgeInsets.only(left: 15.0, top: 15.0, right: 15.0),
        child: currentSelect != 0 ? _buildCitysItem(
            models[currentSelect].citys, isHotCitys)
            : _buildNormalCitys(),
      );
    }

    return new Container();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(

      child:new Container(
        color: Colors.white,
        child: _buildCitysList(),
      ),


    );
  }
}
