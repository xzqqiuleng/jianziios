import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/pages/jobs/job_detail.dart';
import 'package:recruit_app/pages/jobs/job_row_item.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

import 'msg_job_item.dart';


class MsgJob extends StatefulWidget{
  int type;
  MsgJob(this.type);

  @override
  _JobState createState() {
    // TODO: implement createState
    return _JobState();
  }

}

class _JobState extends State<MsgJob>{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  int page;
  List data =List();
 String title="";
  _OnRefresh(){
    page=0;

    new MiviceRepository().getMsgWorkList(page,widget.type).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        data.clear();

        setState(() {
          data = reponse["result"];
        });
        print(data);
        page++;
        _refreshController.refreshCompleted();
      }
    });
  }
  _loadMore(){
    new MiviceRepository().getWorkList(page,widget.type).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        List  loaddata = reponse["result"];
        setState(() {
          data.addAll(loaddata);
        });

        page++;
        _refreshController.loadComplete();
      }
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch(widget.type){
      case 0:
        title = "对我感兴趣的";
        break;
      case 1:
        title = "看过我的";
        break;
      case 2:
        title = "智能推荐";
        break;
      case 3:
        title = "职位上新";
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(title,
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
              width: 18,
              height: 18,
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
          child: ListView.builder(itemBuilder: (context, index) {
            if (data.length >0 && index < data.length) {
              return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: MsgRowItem(
                      job: data[index],
                      type: widget.type,
                      index: index,
                      lastItem: index == data.length - 1),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetail(0,url: data[index]["jobHref"]),
                        ));
                  });
            }
            return null;
          },
            itemCount: data.length,
          )
      )
    );
  }


}