import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/utils/gaps.dart';


class PhotoSelectWidget extends StatelessWidget{
  Function photo_click;
  Function camera_click;
  Function cancle_click;
  PhotoSelectWidget(this.photo_click,this.camera_click,this.cancle_click);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      height: 190,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            height: 110,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12)
            ),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: photo_click,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    alignment: Alignment.center,
                    height:54,
                    child:  Text("相册",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colours.black_4B514A
                      ),

                    ),
                  ),
                ),
                Gaps.line1,
                GestureDetector(

                  onTap: camera_click,
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    alignment: Alignment.center,
                    height:54,
                    child:  Text("拍照",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colours.black_4B514A
                      ),

                    ),
                  ),
                )

              ],
            ),
          ),
          GestureDetector(
              onTap: cancle_click,
              behavior: HitTestBehavior.opaque,
              child:   Container(
                  margin: EdgeInsets.all(10),
                  height:54,
                  alignment: Alignment.center,
                  width: double.infinity,

                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12)
                  ),
                  child: Text("取消",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colours.app_main,
                        fontWeight: FontWeight.bold
                    ),
                  )
              )
          )

        ],
      ),
    );
  }

}