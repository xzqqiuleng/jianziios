import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

import '../jobs/job_detail.dart';
import '../jobs/job_row_item.dart';
import '../share_helper.dart';
import '../share_helper.dart';
import '../storage_manager.dart';


class JZSave extends StatefulWidget{
  String title;
 JZSave(this.title);

  @override
  _JZState createState() {
    // TODO: implement createState
    return _JZState();
  }

}

class _JZState extends State<JZSave>{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  List data =List();

  _OnRefresh(){
    String jsonStr;
       if(widget.title == "已报名"){
         jsonStr = StorageManager.sharedPreferences.getString(ShareHelper.getUser().id+"bm");
       }else{
         jsonStr = StorageManager.sharedPreferences.getString(ShareHelper.getUser().id+"work");
       }

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
                  child: JobRowItem(
                      job: data[index],
                      index: index,
                      lastItem: index == data.length - 1),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>JobDetail(0,url: data[index]["jobHref"]),
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