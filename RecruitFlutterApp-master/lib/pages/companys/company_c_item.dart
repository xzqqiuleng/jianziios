import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/job_list.dart';
import 'package:recruit_app/pages/constant.dart';
import 'package:recruit_app/widgets/dash_line.dart';

class CompanyCItem extends StatelessWidget {
  final Map<String,dynamic> job;
  final int index;
  final bool lastItem;


  const CompanyCItem({Key key, this.job, this.index, this.lastItem})
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
    }else {
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

  @override
  Widget build(BuildContext context) {
    final jobItem = Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4)
      ),
      color: Colors.white,
      elevation: 0.1,
      margin: EdgeInsets.only(
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
          top: ScreenUtil().setWidth(22),
          bottom: 0),
      child: Padding(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(28),
            right: ScreenUtil().setWidth(28),
            top: ScreenUtil().setWidth(20),
            bottom: ScreenUtil().setWidth(20)),
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
                            fontWeight: FontWeight.w500,
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
            Text(
              job["label"].toString(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(23),
                color: Color.fromRGBO(151, 151, 151, 1),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setWidth(28),
            ),
            DashLine(
              color: Colors.black12,
              height: 0.4,
              dashWidth:2,
            ),


            SizedBox(
              height: ScreenUtil().setWidth(28),
            ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                getImg(job["company_img"].toString()),
                SizedBox(
                  width: ScreenUtil().setWidth(12),
                ),
                Flexible(
                  child: Text(
                    job["pub_person"].toString()==""?"HR发布":job["pub_person"],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(30),
                      color: Color.fromRGBO(57, 57, 57, 1),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(16),
                ),
               Container(
                 alignment: Alignment.centerRight,
                  child: Text(
                    job["pub_date"].toString(),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(22),
                      color: Color.fromRGBO(176, 181, 180, 1),
                    ),
                  ),
               ),

              ],
            ),
            SizedBox(
              height: ScreenUtil().setWidth(18),
            ),

            Container(
              height: 30,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
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
                          job["company"].toString(),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(22),
                            color: Color.fromRGBO(57, 57, 57, 1),
                          ),
                        ),
                      ),


                    ],
                  ),
                ],
              ),
            )


          ],
        ),
      )
    );

    if (lastItem) {
      return jobItem;
    }
    return Column(
      children: <Widget>[
        jobItem,
      ],
    );
  }
}
