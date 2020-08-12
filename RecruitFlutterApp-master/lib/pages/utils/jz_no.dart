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


class JZNo extends StatefulWidget{
  String title;
 JZNo(this.title);

  @override
  _JZState createState() {
    // TODO: implement createState
    return _JZState();
  }

}

class _JZState extends State<JZNo>{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  List data =List();

  _OnRefresh(){



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
          child: Center(
              child:  Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset("images/empty_work.png",width: 60,height: 60,),
                  Text(
                      "暂未搜到相关数据"
                  )
                ],
              )
          )
      )
    );
  }


}