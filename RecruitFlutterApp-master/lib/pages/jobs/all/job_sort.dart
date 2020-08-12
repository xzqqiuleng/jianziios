import 'package:flutter/material.dart';
import 'package:recruit_app/pages/utils/screen.dart';

class JobSort extends StatefulWidget {
  final double height;
  String sortSelectName;
  Color themeColor;
  Function(int,String) onSortItemClick;
  Function onTapBack;

  JobSort({Key key,this.height,this.themeColor,this.sortSelectName, this.onTapBack,this.onSortItemClick}) : super(key:key);
  
  @override
  _JobSortState createState() => _JobSortState();
}

class _JobSortState extends State<JobSort> {
  List<String> sorts = [ "智能排序","热门优先","最近发布"];
  int selectIndex = 0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sorts.forEach((text) {
       var index = sorts.indexOf(text);
      if (widget.sortSelectName == text) {
        selectIndex = index;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: Screen.width,
        height: widget.height,
        color:Colors.black.withOpacity(0.5),
        child: new Column(
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: sorts.map((text){
                var index = sorts.indexOf(text);
                return InkWell(
                  onTap: () {
                    if (widget.onSortItemClick !=null) {
                      widget.onSortItemClick(index,text);
                    }
                    
                    setState(() {
                      selectIndex = index;
                    });
                  },
                  child: new Container(
                    width: Screen.width,
                    height: 45.0,
                    color: Colors.white,
                    child: new Center(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Text(text,style: new TextStyle(fontSize:14.0,color: selectIndex == index ? widget.themeColor : Colors.black)),
                          new Container(
                            margin: EdgeInsets.only(top: 15.0),
                            child: new Divider(height: 1.0,),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            new Expanded(
              child: new InkWell(
                onTap: () {
                  if (widget.onTapBack != null) {
                    widget.onTapBack();
                  }
                },
              ),
            )
          ],
        ),
      );
  }
}