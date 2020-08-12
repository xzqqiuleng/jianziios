import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/company_list.dart';
import 'package:recruit_app/pages/constant.dart';
import 'package:recruit_app/pages/utils/html_init.dart';
import 'package:recruit_app/widgets/dash_line.dart';

class CompanyRowItem extends StatelessWidget {
  final Map<String,dynamic> company;
  final int index;
  final bool lastItem;

  const CompanyRowItem({Key key, this.company, this.index, this.lastItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final companyItem = Card(
      margin: EdgeInsets.only(
        top: ScreenUtil().setWidth(22),
        left: ScreenUtil().setWidth(30),
        right: ScreenUtil().setWidth(30),
      ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
        ),
        color: Colors.white,
        elevation: 0.1,
      child: Container(
        padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(30),
          left: ScreenUtil().setWidth(30),
          right: ScreenUtil().setWidth(30),
        ),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.all(
                      Radius.circular(ScreenUtil().setWidth(10))),
                  child: Image.network( company["company_img"] == ""?Constant.deault_compay:company["company_img"] ,
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setWidth(100),
                      fit: BoxFit.cover),
                ),
                SizedBox(width: ScreenUtil().setWidth(22)),
                Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Text(
                                company["name"],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil().setSp(32),
                                  color: Color.fromRGBO(20, 20, 20, 1),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(16),
                            ),

                          ],
                        ),
                        SizedBox(height: ScreenUtil().setWidth(10)),
                        Text(
                          company["address"],
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(26),
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setWidth(20)),
                        Row(
                          children: <Widget>[
                            Image.asset('images/company_icon1.png',
                                width: ScreenUtil().setWidth(24),
                                height: ScreenUtil().setWidth(24),
                                fit: BoxFit.cover),
                            SizedBox(width: ScreenUtil().setWidth(6)),
                            Text(
                              '企业认证',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(22),
                                color: Color.fromRGBO(151, 151, 151,6),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(26)),
                            Image.asset('images/company_icon2.png',
                                width: ScreenUtil().setWidth(24),
                                height: ScreenUtil().setWidth(24),
                                fit: BoxFit.cover),
                            SizedBox(width: ScreenUtil().setWidth(6)),
                            Text(
                              '绿色保障',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(22),
                                color: Color.fromRGBO(151, 151, 151, 1),
                              ),
                            ),
                            SizedBox(width: ScreenUtil().setWidth(26)),
                            Image.asset('images/company_icon3.png',
                                width: ScreenUtil().setWidth(24),
                                height: ScreenUtil().setWidth(24),
                                fit: BoxFit.cover),
                            SizedBox(width: ScreenUtil().setWidth(6)),
                            Text(
                              '极速反馈',
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(22),
                                color: Color.fromRGBO(151, 151, 151, 1),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: ScreenUtil().setWidth(38)),
                      ],
                    ))
              ],
            ),
            Text(
             HtmlInit.initHtml(company["company_info"].toString()),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: ScreenUtil().setSp(26),
                color: Colors.black87,
              ),
            ),
            SizedBox(height:ScreenUtil().setWidth(20) ),
            DashLine(
              color: Colors.black12,
              height: 0.4,
              dashWidth:2,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: ScreenUtil().setWidth(32),top: ScreenUtil().setWidth(20),),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Text(
                          '热招中: ',
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(24),
                            color: Color.fromRGBO(151, 151, 151, 1),
                          ),
                        ),
                        Flexible(
                          child: Text(
                            company["jobs"][0]["title"],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: ScreenUtil().setSp(24),
                              color: Colors.black54,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(22),
                  ),
                  Text(
                    company["nums"].toString(),
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: Colours.app_main,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(
                    '个岗位',
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: Color.fromRGBO(151, 151, 151, 1),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(22),
                  ),
                  Image.asset('images/img_arrow_right_blue.png',
                      width: ScreenUtil().setWidth(10),
                      height: ScreenUtil().setWidth(20),
                      fit: BoxFit.cover)
                ],
              ),
            ),
          ],
        ),
      )
    ) ;

//    if (lastItem) {
//      return card;
//    }
//    if (lastItem) {
//      return companyItem;
//    }
    return Column(
      children: <Widget>[
        companyItem,
        Container(
          height: ScreenUtil().setWidth(4),
          color: Color.fromRGBO(245, 245, 245, 1),
        ),
      ],
    );
  }
}
