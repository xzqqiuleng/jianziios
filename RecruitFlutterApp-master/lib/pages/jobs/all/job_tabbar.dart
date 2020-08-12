import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/utils/screen.dart';

import 'animation_array.dart';

enum TabbarPopType {
  popSelectNone,
  popSelectCity,
  popSelectType,
  popSort,
}

class JobTabbar extends StatefulWidget {
  final String cityName;
  final String sortName;

  final ValueChanged<TabbarPopType> popTypeChanged;
  Function(Function) tabbarReset;

  JobTabbar({Key key,this.cityName,this.sortName,this.tabbarReset,this.popTypeChanged}):super(key:key);
  @override
  _JobTabbarState createState() => _JobTabbarState();
}

class _JobTabbarState extends State<JobTabbar> {
  bool isTapCity = false;
  bool isTapSelect = false;
  bool isTapSort = false;
  TabbarPopType popType;

  @override
  Widget build(BuildContext context) {
    if (widget.tabbarReset != null) {
      widget.tabbarReset(() {
  
        setState(() {
          isTapCity = false;
          isTapSelect = false;
          isTapSort = false;
        });
      });
    }
    return new Container(
      height:  41,
      width: Screen.width,
      color: Colors.white,
      child: new Column(
        children: <Widget>[
          new Container(
            height: 40,
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: new Center(
                    child: new InkWell(
                      onTap: () {
                        setState(() {


                          if (!isTapSelect && !isTapSort && isTapCity) {
                            widget.popTypeChanged(TabbarPopType.popSelectNone);
                          } else {
                            popType = TabbarPopType.popSelectCity;
                            widget.popTypeChanged(popType);
                          }

                          

                          isTapCity = !isTapCity;
                          if (isTapCity) {
                            isTapSelect =false;
                            isTapSort =false;
                          }
                        });
                      },
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text(widget.cityName ?? "广州",style: new TextStyle(fontSize: 15.0,color: popType ==TabbarPopType.popSelectCity ? Colours.app_main:Colors.black),softWrap: false,overflow: TextOverflow.ellipsis,maxLines: 1,),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: AnimationArray(
                              container: new Container(
                                width: 10,
                                height: 5,
                                child: new Image.asset('images/company_icon_arrow2_normal_7x4_@3x.png',color: popType ==TabbarPopType.popSelectCity ? Colours.app_main:Colors.grey,),
                              ),
                              isForward: isTapCity,
                              isReverse: !isTapCity,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: new Center(
                    child: new InkWell(
                      onTap: () {
                        setState(() {


                          if (!isTapCity && !isTapSort && isTapSelect) {
                            widget.popTypeChanged(TabbarPopType.popSelectNone);
                          } else {
                            popType = TabbarPopType.popSelectType;
                            widget.popTypeChanged(popType);
                          }

                          isTapSelect =!isTapSelect;
                           if (isTapSelect) {
                            isTapCity =false;
                            isTapSort =false;
                          }
                        });
    
                      },
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text("筛选",style: new TextStyle(fontSize: 15.0,color: popType ==TabbarPopType.popSelectType ? Colours.app_main:Colors.black),),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: AnimationArray(
                              container: new Container(
                                width: 10,
                                height: 5,
                                child: new Image.asset('images/company_icon_arrow2_normal_7x4_@3x.png',color: popType ==TabbarPopType.popSelectType ?  Colours.app_main:Colors.grey,),
                              ),
                              isForward: isTapSelect,
                              isReverse: !isTapSelect,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: new Center(
                    child: new InkWell(
                      onTap: () {
                        setState(() {


                          if (!isTapCity && !isTapSelect && isTapSort) {
                            widget.popTypeChanged(TabbarPopType.popSelectNone);
                          } else {
                            popType = TabbarPopType.popSort;
                            widget.popTypeChanged(popType);
                          }

                          isTapSort =! isTapSort;
                           if (isTapSort) {
                            isTapSelect =false;
                            isTapCity =false;
                          }
                        });

                      },
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          new Text(widget.sortName ?? "排序",style: new TextStyle(fontSize: 15.0,color: popType ==TabbarPopType.popSort ?  Colours.app_main:Colors.black),),
                          Padding(
                            padding: EdgeInsets.only(left: 5.0),
                            child: AnimationArray(
                              container: new Container(
                                width: 10,
                                height: 5,
                                child: new Image.asset('images/company_icon_arrow2_normal_7x4_@3x.png',color: popType ==TabbarPopType.popSort ? Colours.app_main:Colors.grey,),
                              ),
                              isForward: isTapSort,
                              isReverse: !isTapSort,
                            ),
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
            height: 0.1,
            color: new Color.fromARGB(255, 242, 242, 245),
          ),
        ],
      ),
    );
  }
}