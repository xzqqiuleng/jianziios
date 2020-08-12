import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/jobs/all/job_select.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/utils/screen.dart';

import '../job_detail.dart';
import '../job_row_item.dart';
import 'citys_select.dart';
import 'job_sort.dart';
import 'job_tabbar.dart';



class JobBzLibsboard extends StatefulWidget {


  JobBzLibsboard({Key key}):super(key:key);

  @override
  _JobBzLibsboardState createState() => _JobBzLibsboardState();
}

class _JobBzLibsboardState extends State<JobBzLibsboard> {
  @override
  TabbarPopType popType =TabbarPopType.popSelectNone;
  Function tabbarReset;
  String cityName="北京";
  String sortName;
  Map filters;
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  int page;
  List data =List();
  String filet1;
  String filet2;
  String filet3;
  int sortType = 0;
  _OnRefresh(){
    page=0;


    new MiviceRepository().getFilterList(page,sortType,address: cityName,education: filet1,experience: filet2,salary: filet3,jobType: 1).then((value) {
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
    new MiviceRepository().getFilterList(page,sortType,address: cityName,education: filet1,experience: filet2,salary: filet3,jobType: 1).then((value) {
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

  }

  Widget _buildContent() {
    return new Container(
      child: SmartRefresher(

          header: WaterDropHeader(),
          footer: ClassicFooter(),
          controller: _refreshController,
          onRefresh: _OnRefresh,
          onLoading: _loadMore,
          enablePullUp: true,
          child:data.length == 0?
          Center(
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
              : ListView.builder(itemBuilder: (context, index) {
            if (data.length >0 && index < data.length) {
              return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: JobRowItem(
                      isBz: true,
                      job: data[index],
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

  Widget _buildTabBar() {
    return JobTabbar(cityName: cityName,sortName: sortName,popTypeChanged: (type) {

      setState(() {
        popType = type;
      });
    },tabbarReset: (callback) {
      tabbarReset = callback;
    },);
  }

  Widget _buildPopContent() {
    final contentHeight = Screen.height - Screen.navigationBarHeight  - kToolbarHeight;

    switch (popType) {
      case TabbarPopType.popSelectCity: 
        return CitysSelect(themeColor: Colours.app_main,
              height: contentHeight,
              locationIcon: "images/select_loc.png",
              onValueChanged: (city) {
                setState(() {
                  cityName = city;
                  Future.delayed(const Duration(milliseconds: 600), () {
                    tabbarReset();
                    setState(() {
                      popType = TabbarPopType.popSelectNone;
                      _OnRefresh();
                    });
                  });
                });
              },
            );
      case TabbarPopType.popSelectType:
        return JobTypeSelect(height: contentHeight + kToolbarHeight,
          themeColor: Colours.app_main,
          onSureButtonClick: (map) {
            tabbarReset();
            filters = map;
            if(filters != null){
              if(filters.containsKey("0")){
                filet1 = filters["0"];
              }
              if(filters.containsKey("1")){
                filet2 = filters["1"];
              }if(filters.containsKey("2")){
                filet3 = filters["2"];
              }

            }
            _OnRefresh();
            setState(() {
              popType = TabbarPopType.popSelectNone;

            });
          },
        );
      case TabbarPopType.popSort:
        return JobSort(height: contentHeight,
          sortSelectName: sortName,
          themeColor: Colours.app_main,
          onTapBack: () {
            tabbarReset();
            setState(() {
              popType = TabbarPopType.popSelectNone;

            });
          },
          onSortItemClick: (index,text) {
            tabbarReset();
            setState(() {
              sortName = text;
              popType = TabbarPopType.popSelectNone;
              sortName = text;
              if(sortName == null){
                sortType = 0;
              }else if(sortName=="智能排序"){
                sortType = 1;
              } if(sortName=="热门优先"){
                sortType = 1;
              } if(sortName=="最近发布"){
                sortType = 2;
              }
              _OnRefresh();
            });
          });
      default:
        return Container();
    }
  }

  Widget build(BuildContext context) {
    return new Stack(
        children: <Widget>[
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            top: 40,
            child: _buildContent(),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 40,
            child: _buildPopContent(),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            child: _buildTabBar()
          )
        ],
      );
  }
}