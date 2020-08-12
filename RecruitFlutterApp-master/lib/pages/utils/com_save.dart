import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

import '../../colours.dart';
import '../companys/company_detail.dart';
import '../jobs/job_detail.dart';
import '../jobs/job_row_item.dart';
import '../share_helper.dart';
import '../share_helper.dart';
import '../storage_manager.dart';


class ComSave extends StatefulWidget{
  String title;
 ComSave(this.title);

  @override
  _JZState createState() {
    // TODO: implement createState
    return _JZState();
  }

}

class _JZState extends State<ComSave>{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  List data =List();

  _OnRefresh(){
    String jsonStr;

         jsonStr = StorageManager.sharedPreferences.getString(ShareHelper.getUser().id+"company");


  setState(() {
    data =  json.decode(jsonStr);
  });

  _refreshController.refreshCompleted();
  }
  _loadMore(){
    _refreshController.loadComplete();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(widget.title,
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
      body: SmartRefresher(

          header: WaterDropHeader(),
          footer: ClassicFooter(),
          controller: _refreshController,
          onRefresh: _OnRefresh,
          onLoading: _loadMore,
          enablePullUp: true,
          child:data.length == 0 ? Center(
              child:  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("images/empty_work.png",width: 60,height: 60,),
                  Text(
                      "暂未搜到相关数据"
                  )
                ],
              )
          ):ListView.builder(itemBuilder: (context, index) {
            if (data.length >0 && index < data.length) {
              return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: ComRowItem(
                      job: data[index],
                      index: index,
                      lastItem: index == data.length - 1),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>CompanyDetail(0,url: data[index]["jobHref"]),
                        ));
                  });
            }

          },
            itemCount: data.length,
          )
      )
    );
  }


}
class ComRowItem extends StatelessWidget {
  final Map<String,dynamic> job;
  final int index;
  final bool lastItem;
  List tags;
  ComRowItem({Key key, this.job, this.index, this.lastItem})
      : super(key: key);




  Widget _getTip(){
    tags = job["label"];
    List<Widget> tipWidget=[];
    List<Widget> columWidget=[];
    if(tags == null|| tags.length>0 ){

      for (var item in tags){
        if(item == " "||item ==""){
          continue;
        }
        tipWidget.add( TextTagWidget("$item",
          backgroundColor: Color(0xFFF0F0F0),
          margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
          padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
          borderRadius: 2,
          borderColor: Color(0xFFF0F0F0),
          textStyle: TextStyle(
              color: Colors.black54,
              fontSize: 12
          ),
        ));
      }

      columWidget.add(Wrap(children: tipWidget));


    }else{
      columWidget.add(Container(height: 0,));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: columWidget,
    );
  }
  @override
  Widget build(BuildContext context) {
    final jobItem = Padding(
      padding: EdgeInsets.only(
          left: ScreenUtil().setWidth(28),
          right: ScreenUtil().setWidth(28),
          top: ScreenUtil().setWidth(20),
          bottom: ScreenUtil().setWidth(30)),
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
                        job["name"].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(32),
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(20, 20, 20, 1),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(width: 16),
              Text("在招职位${job["job_num"].toString()}",
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(32),
                      fontWeight: FontWeight.bold,
                      color: Colours.app_main)),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setWidth(20),
          ),
          _getTip(),
          SizedBox(
            height: ScreenUtil().setWidth(28),
          ),
          Text(
            job["address"].toString(),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(26),

              color: Color.fromRGBO(20, 20, 20, 1),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setWidth(28),
          ),
          Container(color: Color(0xfff0f0f0),height: 4,),
        ],
      ),
    );

    if (lastItem) {
      return jobItem;
    }
    return Column(
      children: <Widget>[
        jobItem,
        index != 0 && index % 4 ==0? Container(
          margin: EdgeInsets.fromLTRB(14, 4, 14, 4),
          height: 100,
          decoration: BoxDecoration(
            image: DecorationImage(
//              image: AssetImage("images/mid_ad.jpg"),
              image: NetworkImage(getUrl()),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
        ):Container(),
      ],
    );
  }

  Map RandomItem;
  String getUrl(){
    String twoJson = StorageManager.sharedPreferences.getString("two");
    if(twoJson != null){
      List datass = json.decode(twoJson);
      if(!datass.isEmpty && datass.length>0){
        var rng = new Random();
        int pos =  rng.nextInt(datass.length);
        RandomItem = datass[pos];
        return RandomItem["img_url"];
      }else{
        return "";
      }
    }else{
      return"";
    }



  }
}
