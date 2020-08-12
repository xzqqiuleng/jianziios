import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/job_list.dart';
import 'package:recruit_app/pages/event_heper.dart';
import 'package:recruit_app/pages/jobs/city_filter.dart';
import 'package:recruit_app/pages/jobs/job_company_search.dart';
import 'package:recruit_app/pages/jobs/job_detail.dart';
import 'package:recruit_app/pages/jobs/job_filter.dart';
import 'package:recruit_app/pages/jobs/job_row_item.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

class JobList extends StatefulWidget {

  @override
  _JobListState createState() {
    // TODO: implement createState
    return _JobListState();
  }
}


class JobBody extends StatefulWidget{
  List _jobList;
  JobBody(this._jobList);
  @override
  _JobBodyState createState() {
    // TODO: implement createState
   return _JobBodyState();
  }

}
class _JobBodyState extends State<JobBody> with SingleTickerProviderStateMixin{
 List tabs = ["推荐","最新","急缺"];
 TabController _tabController;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3,vsync:this);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                // 设置阴影
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffD9D9D9),
                    blurRadius: 9.0,
                    spreadRadius: -7.0,
                    offset: Offset(0, -7),
                  )
                ],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(ScreenUtil().setWidth(30)),
                  topRight: Radius.circular(ScreenUtil().setWidth(30)),
                ),
              ),
              //alignment: Alignment.topCenter,
              child: TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.white,
                  tabs: tabs.map((e) => Tab(text: e)).toList(),
                indicatorWeight: ScreenUtil().setHeight(6),
                indicatorPadding: EdgeInsets.only(
                    left: ScreenUtil().setWidth(40),
                    right: ScreenUtil().setWidth(40)),
                labelPadding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
                isScrollable: false,
                labelColor: Color(0xffFF7E98),
                labelStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  color: Color(0xffFF7E98),
                ),
                unselectedLabelColor: Color(0xffAAAAAA),
                unselectedLabelStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Color(0xffAAAAAA),
                ),
                indicatorSize: TabBarIndicatorSize.label,
              )),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: TabBarView(
        children: [
//          JobBodyList(),
//          JobBodyList(),
//          JobBodyList(),
        ],
        controller: _tabController,
      ),
    );
  }

}

class JobBodyList extends StatefulWidget{
  bool isScrool;
  int type;
  JobBodyList(this.isScrool,this.type);
  @override
  _JobBodyListState createState() {
    // TODO: implement createState
    return _JobBodyListState();
  }

}

class _JobBodyListState extends State<JobBodyList> with AutomaticKeepAliveClientMixin{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  int page=1;
  List data =List();
  String cityNum="0";
  String saNum="0";
  String jlNum="0";
  String url = "http://www.zaojiong.com/job/list/0-0-0-0_0_0_0_0_0_0_0-0-0-0-1.html";
  StreamSubscription  _eventRefreshSub;
 @override
void initState() {
  // TODO: implement initState
  super.initState();
  if(widget.type == 0){
    url = "http://www.zaojiong.com/job/list/0-${cityNum}-${saNum}-0_${jlNum}_0_0_0_0_0_0-0-0-0-${page}.html";
  }else{
    url = "http://www.zaojiong.com/job/list/45-${cityNum}-${saNum}-0_${jlNum}_0_0_0_0_0_0-0-0-0-${page}.html";
  }

  _eventSub();
}
  void _eventSub(){

    _eventRefreshSub= eventBus.on<JobRefreshEvent>().listen((event) {
       if(event.type == 0){
         cityNum = event.txt;
         saNum = "0";
         jlNum = "0";

       }else if(event.type == 1){
         cityNum = "0";
         saNum = event.txt;
         jlNum = "0";
       }else{
         cityNum = "0";
         saNum = "0";
         jlNum = event.txt;
       }
      _OnRefresh();
       _refreshController.requestRefresh(needMove: false);

    });
  }
  _OnRefresh(){

    page=2;
    url = "http://www.zaojiong.com/job/list/0-${cityNum}-${saNum}-0_${jlNum}_0_0_0_0_0_0-0-0-0-${page}.html";
    new MiviceRepository().getJzList(url).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        data.clear();

        if(mounted){
          setState(() {
            data = reponse["result"];
          });
        }

        print(data);
        page++;

      }
      _refreshController.refreshCompleted();
    });
  }
  _loadMore(){
    url = "http://www.zaojiong.com/job/list/0-${cityNum}-${saNum}-0_${jlNum}_0_0_0_0_0_0-0-0-0-${page}.html";
    new MiviceRepository().getJzList(url).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        List  loaddata = reponse["result"];
        setState(() {
        data.addAll(loaddata);
        });

        page++;

      }
      _refreshController.loadComplete();
    });
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SmartRefresher(
        physics:widget.isScrool?BouncingScrollPhysics () :NeverScrollableScrollPhysics (),
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
                child: JobRowItem(
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
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}
class _JobListState extends State<JobList> with SingleTickerProviderStateMixin{
  List<Job> _jobList = JobData.loadJobs();
  List tabs = ["推荐","最新","急缺"];
  TabController _tabController;
  int _selectFilterType = 0;
  ScrollController _scrollViewController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(length: 3,vsync:this);
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

        Container(
        padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(48),
        vertical: ScreenUtil().setWidth(24),
      ),
      color: Colours.app_main,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'images/img_job_location.png',
            width: ScreenUtil().setWidth(30),
            height: ScreenUtil().setWidth(36),
            fit: BoxFit.contain,
          ),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          Expanded(
              child: Row(
                children: <Widget>[
                  Flexible(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => CityFilter(),),);
                      },
                      child: Text(
                        '洛杉矶',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(30),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(8),
                  ),

                ],
              )),
          SizedBox(
            width: ScreenUtil().setWidth(10),
          ),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context)=>JobCompanySearch(searchType: SearchType.job,)));
            },
            child: Container(
              width: ScreenUtil().setWidth(304),
              child: Row(
                children: <Widget>[
                  Image.asset(
                    'images/img_search_blue.png',
                    width: ScreenUtil().setWidth(26),
                    height: ScreenUtil().setWidth(26),
                    fit: BoxFit.contain,
                  ),
                  Text(
                    "｜搜索",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(24),
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(10),
                vertical: ScreenUtil().setWidth(10),
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white70,
                    width: ScreenUtil().setWidth(2),
                  ),
                  borderRadius:
                  BorderRadius.circular(ScreenUtil().setWidth(100))),
            ),),
        ],
      ),
    ),
    Expanded(
    child: NestedScrollView(
      controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled){
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.transparent,
                expandedHeight: 160,
                pinned: false,
                //是否随着滑动隐藏标题
                floating: true,
                automaticallyImplyLeading: false,
                snap:  true,
                elevation: 0,
                //可折叠的应用栏
                flexibleSpace:Container(
                  margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0),
                  height: 160,
                  child: Swiper(//第三方的banner库：flutter_swiper
                      itemBuilder: (BuildContext context, int index) {
                        return Card(

                          elevation: 1,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),

                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: FadeInImage.assetNetwork(
                              placeholder: "images/img_job_ad.png",
                              image: "",
                              fit: BoxFit.cover,
                            ),

                          ),
                        );
                      },
                      itemCount: 3,
                      scale: 0.9,
                      pagination: new SwiperPagination()),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6)
                  ),
                )

              ),

          SliverPersistentHeader(
            delegate:   new SliverTabBarDelegate(
               TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                tabs: tabs.map((e) => Tab(text: e)).toList(),
                indicatorWeight: ScreenUtil().setHeight(6),
//                indicatorPadding: EdgeInsets.only(
//                    left: ScreenUtil().setWidth(10),
//                    right: ScreenUtil().setWidth(10)),
                labelPadding:
                EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(14)),
                isScrollable: false,
                labelColor: Colours.app_main,
                labelStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(50),
                  color: Color(0xffFF7E98),
                  fontWeight: FontWeight.bold
                ),
                unselectedLabelColor: Color(0xffAAAAAA),
                unselectedLabelStyle: TextStyle(
                  fontSize: ScreenUtil().setSp(32),
                  color: Colors.black87,
                ),
                indicatorSize: TabBarIndicatorSize.label,
              ),
              color: Colors.white,
            ),
            pinned: true,
          ),
            ];
          },

          body:  TabBarView(
            children: [
//              JobBodyList(),
//              JobBodyList(),
//              JobBodyList(),
            ],
            controller: _tabController,
          ),

      ),
    ),
            ],
        ),
      ),
    );
  }
}
class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      color: Colors.white,
      height: 60,
      alignment: Alignment.center,
      child:Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            left: 0,
            right: 172,
            child: widget,
          ),
          Positioned(
            right: 0,
            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'images/img_job_filter.png',
                                    width: ScreenUtil().setWidth(32),
                                    height: ScreenUtil().setWidth(32),
                                    fit: BoxFit.contain,
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(6),
                                  ),
                                  Text(
                                    "筛选",
                                    style: TextStyle(
                                      fontSize: ScreenUtil().setSp(32),
                                      color: Color.fromRGBO(57, 57, 57, 1),
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => JobFilter(),),);
                              },
                            ),

          )
        ],
      )

    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;
}
//class _JobListState extends State<JobList> {
//  List<Job> _jobList = JobData.loadJobs();
//
//  int _selectFilterType = 0;
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return Scaffold(
//      backgroundColor: Colors.white,
//      body: SafeArea(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.stretch,
//          children: <Widget>[
//            Padding(
//              padding: EdgeInsets.symmetric(
//                horizontal: ScreenUtil().setWidth(48),
//                vertical: ScreenUtil().setWidth(24),
//              ),
//              child: Row(
//                crossAxisAlignment: CrossAxisAlignment.center,
//                children: <Widget>[
//                  Image.asset(
//                    'images/img_job_location.png',
//                    width: ScreenUtil().setWidth(30),
//                    height: ScreenUtil().setWidth(36),
//                    fit: BoxFit.contain,
//                  ),
//                  SizedBox(
//                    width: ScreenUtil().setWidth(10),
//                  ),
//                  Expanded(
//                      child: Row(
//                    children: <Widget>[
//                      Flexible(
//                        child: GestureDetector(
//                          behavior: HitTestBehavior.opaque,
//                          onTap: () {
//                            Navigator.push(context, MaterialPageRoute(
//                              builder: (context) => CityFilter(),),);
//                          },
//                          child: Text(
//                            '洛杉矶',
//                            style: TextStyle(
//                              fontWeight: FontWeight.bold,
//                              fontSize: ScreenUtil().setSp(40),
//                              color: Color.fromRGBO(20, 20, 20, 1),
//                            ),
//                          ),
//                        ),
//                      ),
//                      SizedBox(
//                        width: ScreenUtil().setWidth(8),
//                      ),
//                      Text(
//                        '（当前城市）',
//                        style: TextStyle(
//                          fontSize: ScreenUtil().setSp(22),
//                          color: Color.fromRGBO(176, 181, 180, 1),
//                        ),
//                      ),
//                    ],
//                  )),
//                  SizedBox(
//                    width: ScreenUtil().setWidth(10),
//                  ),
//                  GestureDetector(
//                    behavior: HitTestBehavior.opaque,
//                    onTap: () {
//                      Navigator.push(context,MaterialPageRoute(builder: (context)=>JobCompanySearch(searchType: SearchType.job,)));
//                    },
//                    child: Container(
//                      width: ScreenUtil().setWidth(204),
//                      child: Row(
//                        children: <Widget>[
//                          Image.asset(
//                            'images/img_search_blue.png',
//                            width: ScreenUtil().setWidth(26),
//                            height: ScreenUtil().setWidth(26),
//                            fit: BoxFit.contain,
//                          ),
//                          Text(
//                            "｜搜索",
//                            maxLines: 1,
//                            overflow: TextOverflow.ellipsis,
//                            style: TextStyle(
//                              fontSize: ScreenUtil().setSp(24),
//                              color: Color.fromRGBO(159, 199, 235, 1),
//                            ),
//                          ),
//                        ],
//                      ),
//                      padding: EdgeInsets.symmetric(
//                        horizontal: ScreenUtil().setWidth(10),
//                        vertical: ScreenUtil().setWidth(10),
//                      ),
//                      decoration: BoxDecoration(
//                          border: Border.all(
//                            color: Color.fromRGBO(159, 199, 235, 1),
//                            width: ScreenUtil().setWidth(2),
//                          ),
//                          borderRadius:
//                          BorderRadius.circular(ScreenUtil().setWidth(1000))),
//                    ),),
//                ],
//              ),
//            ),
//            Expanded(
//              child: CustomScrollView(
//                physics: BouncingScrollPhysics(),
//                slivers: <Widget>[
//                  SliverAppBar(
//                    primary: true,
//                    //是否随着滑动隐藏标题
//                    floating: true,
//                    //是否固定在顶部
//                    pinned: false,
//                    automaticallyImplyLeading: false,
//                    snap: true,
//                    elevation: 0,
//                    //可折叠的应用栏
//                    flexibleSpace:  AppBar(
//                        automaticallyImplyLeading: false, //设置没有返回按钮
//                        backgroundColor: Colors.white,
//                        elevation: 0,
//
//                      title:Container(
//                        width: double.infinity,
//                        color: Colors.white,
//                        child: Image.asset(
//                          'images/img_job_ad.png',
//                          fit: BoxFit.cover,
//                          height: ScreenUtil().setWidth(300),
//                        ),
//                      )
//                    ),
//                  ),
////                  SliverToBoxAdapter(
////                    child: Padding(
////                      padding: EdgeInsets.only(
////                          left: ScreenUtil().setWidth(48),
////                          right: ScreenUtil().setWidth(48),
////                          top: ScreenUtil().setWidth(24),
////                          bottom: ScreenUtil().setWidth(48)),
////                      child: ClipRRect(
////                        borderRadius: BorderRadius.all(
////                            Radius.circular(ScreenUtil().setWidth(10))),
////                        child: Image.asset(
////                          'images/img_job_ad.png',
////                          fit: BoxFit.cover,
////                          height: ScreenUtil().setWidth(300),
////                        ),
////                      ),
////                    ),
////                  ),
//                  SliverToBoxAdapter(
//
//                      child: Column(
//                    children: <Widget>[
//                      Container(
//                        height: ScreenUtil().setWidth(4),
//                        color: Color.fromRGBO(245, 245, 245, 1),
//                      ),
//                      Container(
//                        alignment: Alignment.center,
//                        padding: EdgeInsets.symmetric(
//                          horizontal: ScreenUtil().setWidth(48),
//                        ),
//                        height: ScreenUtil().setWidth(92),
//                        child: Row(
//                          children: <Widget>[
//                            Expanded(
//                              child: SingleChildScrollView(
//                                physics: BouncingScrollPhysics(),
//                                scrollDirection: Axis.horizontal,
//                                child: Row(
//                                  children: <Widget>[
//                                    GestureDetector(
//                                      behavior: HitTestBehavior.opaque,
//                                      child: Text(
//                                        "推荐",
//                                        style: TextStyle(
//                                          fontSize: ScreenUtil().setSp(32),
//                                          fontWeight: _selectFilterType == 0
//                                              ? FontWeight.bold
//                                              : FontWeight.normal,
//                                          color: _selectFilterType == 0
//                                              ? Color.fromRGBO(68, 77, 151, 1)
//                                              : Color.fromRGBO(57, 57, 57, 1),
//                                        ),
//                                      ),
//                                      onTap: () {
//                                        setState(() {
//                                          _selectFilterType = 0;
//                                        });
//                                      },
//                                    ),
//                                    SizedBox(
//                                      width: ScreenUtil().setWidth(32),
//                                    ),
//                                    GestureDetector(
//                                      behavior: HitTestBehavior.opaque,
//                                      child: Text(
//                                        "附近",
//                                        style: TextStyle(
//                                          fontSize: ScreenUtil().setSp(32),
//                                          fontWeight: _selectFilterType == 1
//                                              ? FontWeight.bold
//                                              : FontWeight.normal,
//                                          color: _selectFilterType == 1
//                                              ? Color.fromRGBO(68, 77, 151, 1)
//                                              : Color.fromRGBO(57, 57, 57, 1),
//                                        ),
//                                      ),
//                                      onTap: () {
//                                        setState(() {
//                                          _selectFilterType = 1;
//                                        });
//                                      },
//                                    ),
//                                    SizedBox(
//                                      width: ScreenUtil().setWidth(32),
//                                    ),
//                                    GestureDetector(
//                                      behavior: HitTestBehavior.opaque,
//                                      child: Text(
//                                        "最新",
//                                        style: TextStyle(
//                                          fontSize: ScreenUtil().setSp(32),
//                                          fontWeight: _selectFilterType == 2
//                                              ? FontWeight.bold
//                                              : FontWeight.normal,
//                                          color: _selectFilterType == 2
//                                              ? Color.fromRGBO(68, 77, 151, 1)
//                                              : Color.fromRGBO(57, 57, 57, 1),
//                                        ),
//                                      ),
//                                      onTap: () {
//                                        setState(() {
//                                          _selectFilterType = 2;
//                                        });
//                                      },
//                                    ),
//                                    SizedBox(
//                                      width: ScreenUtil().setWidth(32),
//                                    ),
//                                    GestureDetector(
//                                      behavior: HitTestBehavior.opaque,
//                                      child: Text(
//                                        "区域推送",
//                                        style: TextStyle(
//                                          fontSize: ScreenUtil().setSp(32),
//                                          fontWeight: _selectFilterType == 3
//                                              ? FontWeight.bold
//                                              : FontWeight.normal,
//                                          color: _selectFilterType == 3
//                                              ? Color.fromRGBO(68, 77, 151, 1)
//                                              : Color.fromRGBO(57, 57, 57, 1),
//                                        ),
//                                      ),
//                                      onTap: () {
//                                        setState(() {
//                                          _selectFilterType = 3;
//                                        });
//                                      },
//                                    ),
//                                  ],
//                                ),
//                              ),
//                            ),
//                            SizedBox(
//                              width: ScreenUtil().setWidth(8),
//                            ),
//                            GestureDetector(
//                              behavior: HitTestBehavior.opaque,
//                              child: Row(
//                                children: <Widget>[
//                                  Image.asset(
//                                    'images/img_job_filter.png',
//                                    width: ScreenUtil().setWidth(32),
//                                    height: ScreenUtil().setWidth(32),
//                                    fit: BoxFit.contain,
//                                  ),
//                                  SizedBox(
//                                    width: ScreenUtil().setWidth(6),
//                                  ),
//                                  Text(
//                                    "筛选",
//                                    style: TextStyle(
//                                      fontSize: ScreenUtil().setSp(32),
//                                      color: Color.fromRGBO(57, 57, 57, 1),
//                                    ),
//                                  ),
//                                ],
//                              ),
//                              onTap: () {
//                                Navigator.push(context, MaterialPageRoute(
//                                  builder: (context) => JobFilter(),),);
//                              },
//                            ),
//                          ],
//                        ),
//                      ),
//                      Container(
//                        margin: EdgeInsets.only(
//                          left: ScreenUtil().setWidth(48),
//                          right: ScreenUtil().setWidth(48),
//                        ),
//                        height: ScreenUtil().setWidth(1),
//                        color: Color.fromRGBO(159, 199, 235, 1),
//                      ),
//                      Visibility(
//                        visible: _selectFilterType == 3,
//                        child: Column(
//                          children: <Widget>[
//                            Container(
//                                padding: EdgeInsets.symmetric(
//                                  horizontal: ScreenUtil().setWidth(48),
//                                ),
//                                height: ScreenUtil().setWidth(92),
//                                alignment: Alignment.center,
//                                child: Row(
//                                  children: <Widget>[
//                                    Image.asset(
//                                      'images/img_area_filter.png',
//                                      width: ScreenUtil().setWidth(32),
//                                      height: ScreenUtil().setWidth(32),
//                                      fit: BoxFit.contain,
//                                    ),
//                                    SizedBox(
//                                      width: ScreenUtil().setWidth(12),
//                                    ),
//                                    Expanded(child:  Text(
//                                      "区域规划",
//                                      style: TextStyle(
//                                        fontSize: ScreenUtil().setSp(28),
//                                        color: Color.fromRGBO(159, 199, 235, 1),
//                                      ),
//                                    ),),
//                                    SizedBox(
//                                      width: ScreenUtil().setWidth(12),
//                                    ),
//                                    Image.asset(
//                                      'images/img_arrow_right_blue.png',
//                                      width: ScreenUtil().setWidth(11),
//                                      height: ScreenUtil().setWidth(21),
//                                      fit: BoxFit.contain,
//                                    ),
//                                  ],
//                                )),
//                            Container(
//                              margin: EdgeInsets.only(
//                                left: ScreenUtil().setWidth(48),
//                                right: ScreenUtil().setWidth(48),
//                              ),
//                              height: ScreenUtil().setWidth(1),
//                              color: Color.fromRGBO(159, 199, 235, 1),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ],
//                  )),
//                  SliverList(
//                      delegate: SliverChildBuilderDelegate((context, index) {
//                    if (index < _jobList.length) {
//                      return GestureDetector(
//                          behavior: HitTestBehavior.opaque,
//                          child: JobRowItem(
//                              job: _jobList[index],
//                              index: index,
//                              lastItem: index == _jobList.length - 1),
//                          onTap: () {
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                  builder: (context) => JobDetail(),
//                                ));
//                          });
//                    }
//                    return null;
//                  }, childCount: _jobList.length)),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
