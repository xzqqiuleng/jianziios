import 'package:flutter/material.dart';
import 'package:recruit_app/model/company_welfare_list.dart';

class CompanyWelfareItem extends StatelessWidget {
  final String welfareData;
  final int index;
  final bool isLastItem;

  const CompanyWelfareItem({Key key, this.welfareData, this.index,this.isLastItem})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final welfareItem = Container(
      alignment: Alignment.center,
      width: 100,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              width: 0.4,
              color: Colors.black87,
              style: BorderStyle.solid)),
      child: Text(
       welfareData == ""?"公司福利": '${welfareData}',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14, color: Colors.black87),
      ),
    );

    if(isLastItem){
      return welfareItem;
    }

    return Row(
      children: <Widget>[
        welfareItem,
        SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
