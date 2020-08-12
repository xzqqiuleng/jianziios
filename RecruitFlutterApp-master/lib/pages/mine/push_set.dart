import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/mine/push_item.dart';
import 'package:recruit_app/pages/utils/gaps.dart';


class PushSetPage extends StatefulWidget{

  @override
  _PushState createState() {
    // TODO: implement createState
    return _PushState();
  }
  
}
class _PushState extends State<PushSetPage>{
  List<PushItem> _itmes=List();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    PushItem pushItem1 = PushItem(false);
    PushItem pushItem2 = PushItem(false);
    PushItem pushItem3 = PushItem(false);
    _itmes.add(pushItem1);
    _itmes.add(pushItem2);
    _itmes.add(pushItem3);
     _addDatas();
  }
  _addDatas(){

}
  @override
  Widget build(BuildContext context) {

    _itmes[0].txt = "兼职上新";
    _itmes[1].txt =  "公司发布";
    _itmes[2].txt =  "职位申请";
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colours.bg_color,
        title: Text("隐私设置",
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
      body: ListView.builder(itemBuilder: (context, index) {
        return PushSetItemWidget(index,_itmes[index]);
      },
        itemCount: _itmes.length,
      ),

    );
  }

}
class PushSetItemWidget extends StatefulWidget{
  PushItem pushItem;
  int index;
  PushSetItemWidget(this.index,this.pushItem,{Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PusetItemState();
  }

}
class _PusetItemState extends State<PushSetItemWidget>{

  _pushTag(bool value){

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
  return Container(
          margin: EdgeInsets.only(left: 20,right: 20),
          height: 54,
          child: Stack(
            alignment:Alignment.center,
            children: <Widget>[
              Positioned(
                left: 0,
                child: Text(widget.pushItem.txt,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colours.black_212920
                  ),
                ),
              ),
              Positioned(
                  right: 0,

                  child:  CupertinoSwitch(
                  activeColor: Colours.app_main,
                    value:widget.pushItem.value,
                    onChanged: (value) {
                      setState(() {
                        _pushTag(value);
                        widget.pushItem.value = value;
                      });
                    },
                  )
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Gaps.line1,
              ),

            ],

          ),

        ) ;
  }

}
