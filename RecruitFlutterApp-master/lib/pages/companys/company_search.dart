import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/pages/jobs/job_detail.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

import 'company_row_item.dart';


class CompanySearch extends StatefulWidget{
  String txt;
  CompanySearch(this.txt);
  @override
  _csState createState() {
    // TODO: implement createState
    return _csState();
  }

}

class _csState extends State<CompanySearch>{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  int page;
  List data =List();

  _OnRefresh(){
    page=0;

    new MiviceRepository().getCompanyList(page,searchText:widget.txt).then((value) {
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
  _loadMore() {
    new MiviceRepository().getCompanyList(page, searchText: widget.txt).then((
        value) {
      var reponse = json.decode(value.toString());
      if (reponse["status"] == "success") {
        List loaddata = reponse["result"];
        setState(() {
          data.addAll(loaddata);
        });

        page++;
        _refreshController.loadComplete();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(widget.txt,
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
              width: 16,
              height: 16,
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
                  child: CompanyRowItem(
                      company: data[index],
                      index: index,
                      lastItem: index == data.length - 1),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetail(0,url: data[index]["jobHref"])
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