import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/msg/agreement_detail.dart';
import 'package:recruit_app/pages/utils/gaps.dart';



class AgreementPage extends StatelessWidget{
 List _itmes;


  @override
  Widget build(BuildContext context) {
    _itmes=["用户服务协议","用户隐私政策"];
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colours.bg_color,
          title: Text("服务与隐私",
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
        return AgreementItemWidget(index,_itmes[index]);
       },
        itemCount: _itmes.length,
      ),

    );
  }
  
}

class AgreementItemWidget  extends StatelessWidget{
  String txt;
  int index;
  AgreementItemWidget(this.index,this.txt,{Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
       onTap: () {

         Navigator.push(
             context,
             MaterialPageRoute(
               builder: (context) => AgreementDetailPage(index),
             ));
       },
      child: Container(
        margin: EdgeInsets.only(left: 20,right: 20),
          height: 54,
          child: Stack(
            alignment:Alignment.center,
            children: <Widget>[
              Positioned(
                left: 0,
                child: Text(txt,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colours.black_212920
                  ),
                ),
              ),
              Positioned(
                right: 0,
                child: Icon(Icons.navigate_next, color: Colours.black_400000),
              ),
              Positioned(
                bottom: 0,
              left: 0,
              right: 0,
              child: Gaps.line1,
              ),
              
            ],

          ),

        )
    );
  }

}