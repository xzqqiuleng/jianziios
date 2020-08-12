import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/employe_list.dart';

class EmployeeRowItem extends StatelessWidget {
  final Map employee;
  final int index;
  final bool lastItem;

  const EmployeeRowItem({Key key, this.employee, this.index, this.lastItem})
      : super(key: key);
  @override
  Widget build(BuildContext context) {

   var dataItem = json.decode(employee["info"].toString());
   var head_icon = employee["head_img"].toString();
   List tags = List();
   tags.add(dataItem["年龄"].toString());
   tags.add(dataItem["性别"].toString());
   tags.add(dataItem["教育经历"].toString());
    final employeeItem =
      Card(
        margin: EdgeInsets.fromLTRB(15,15,15,0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4)
        ),
        elevation:0.1,
        child:Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: Image.network(
                      head_icon,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${dataItem["姓名"]}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(37, 38, 39, 1),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),

                        Text(

                            dataItem["目前状态"],
                            style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 11,
                              color: Colors.blueAccent,
                            )),

                      ],
                    ),
                  ),
                  SizedBox(width: 18),
                  Text(
                      dataItem["希望月薪"],
                      style: const TextStyle(
                        wordSpacing: 1,
                        letterSpacing: 1,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colours.app_main,
                      )),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    'images/hangye.png',
                    width: 17,
                    height: 18,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                      child: Text(      dataItem["求职行业"],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            wordSpacing: 1,
                            letterSpacing: 1,
                            fontSize: 14,
                            color: Color.fromRGBO(53, 54, 55, 1),
                          ))),
                  SizedBox(width: 10),

                ],
              ),
              SizedBox(
                height: 15,
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 6,
                runSpacing: 6,
                children: tags.map((item) {
                  return new Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: new BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: new BorderRadius.circular(4.0),
                      ),
                      child: Text(item,
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 10, color: Colors.grey[600])));
                }).toList(),
              ),
              SizedBox(
                height: 15,
              ),
              Text( dataItem["求职意向"],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      letterSpacing: 1,
                      wordSpacing: 2,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Color.fromRGBO(93, 94, 95, 1))),
            ],
          ),
        ) ,
    );
    return  employeeItem;
  }
}
