import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/jobs/job_company_search.dart';
import 'package:recruit_app/pages/jobs/job_list.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/utils/screen.dart';

import 'company_detail.dart';
import 'company_row_item.dart';


class CompanyJobList extends StatefulWidget {
  final bool contentScrollable;
  final ValueChanged<int> tabbarItemClick;



  CompanyJobList({Key key,this.contentScrollable,this.tabbarItemClick}) : super(key:key);

  @override
  _CompanyJobState createState() => _CompanyJobState();
}

class _CompanyJobState extends State<CompanyJobList> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> _tabMenus = <Tab> [
    new Tab(text: '推荐'),
    new Tab(text: '最新'),
  ];


   int _currentPosition = 0;

   void _onTabbarItemPressed(index) {
     widget.tabbarItemClick(index);
   }

   Widget _buildTabViewContent() {
    return new TabBarView(children:  [
      CompanyBodyList(0),
      CompanyBodyList(1),
     ],
            controller: _tabController,
          );
  }

  Widget _buildContentTabbar() {
   return Scaffold(
       body:Column(
     crossAxisAlignment: CrossAxisAlignment.stretch,
     children: <Widget>[
       Container(
         color: Colors.white,
         height: 20,
       ),
       Container(
         color: Colors.white,
         padding: EdgeInsets.symmetric(
           horizontal: ScreenUtil().setWidth(24),
           vertical: ScreenUtil().setWidth(24),
         ),
         child: Row(
           crossAxisAlignment: CrossAxisAlignment.center,
           children: <Widget>[
             Expanded(
              child: new Container(
                 child:new TabBar(
                   tabs: _tabMenus,
                   onTap: _onTabbarItemPressed,
                   controller: _tabController,
                   isScrollable: true,
                   indicatorSize: TabBarIndicatorSize.label,
                   indicatorColor: Colours.app_main,
                   indicatorWeight: 4.0,
                   indicatorPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                   labelColor: Colors.black87,
                   labelPadding: new EdgeInsets.only(left: 16.0,right: 16.0),
                   labelStyle: new TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold,fontFamily: ""),
                   unselectedLabelColor: Colors.black54,
                   unselectedLabelStyle: new TextStyle(fontSize: 16.0),
                 ),
                 alignment: Alignment.centerLeft,
                 padding: EdgeInsets.only(left: 10),
               ),
             ),
             SizedBox(
               width: ScreenUtil().setWidth(10),
             ),
             GestureDetector(
               behavior: HitTestBehavior.opaque,
               onTap: () {
                 Navigator.push(context,MaterialPageRoute(builder: (context)=>JobCompanySearch(searchType: SearchType.company,),),);
               },
               child: Container(
                 width: ScreenUtil().setWidth(240),

                 child: Row(
                   children: <Widget>[
                     Image.asset(
                       'images/search_qy.png',
                       width: ScreenUtil().setWidth(26),
                       height: ScreenUtil().setWidth(26),
                       fit: BoxFit.contain,
                     ),
                     Text(
                       " ｜ 企业搜索",
                       maxLines: 1,
                       overflow: TextOverflow.ellipsis,
                       style: TextStyle(
                         fontSize: ScreenUtil().setSp(24),
                         color: Color(0xFF80808080),
                       ),
                     ),
                   ],
                 ),
                 padding: EdgeInsets.symmetric(
                   horizontal: ScreenUtil().setWidth(30),
                   vertical: ScreenUtil().setWidth(16),
                 ),
                 decoration: BoxDecoration(
                   color: Color(0xFFF0F0F0F0),
//                     border: Border.all(
//                       color: Colo,
//                       width: ScreenUtil().setWidth(2),
//                     ),
                     borderRadius:
                     BorderRadius.circular(ScreenUtil().setWidth(1000))),
               ),),

           ],
         ),
       ),

       new Container(
         height: 0.8,
         color: new Color.fromARGB(255, 242, 242, 245),
       )
     ],
   ) )
   ;
 }


 @override
  void initState() {
    // TODO: implement initState
    super.initState();
  
    _tabController = new TabController(vsync: this,length: _tabMenus.length);
    //判断TabBar是否切换
    _tabController.addListener(() {
      setState(() {
          _currentPosition = _tabController.index;
      }); 
    });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
          children: <Widget>[
              new Container(
                  color: Colors.white,
                  width: Screen.width,
                  height: 96,
                  child: _buildContentTabbar()
              ),
              new Container(
                color: Colors.white,
                height:Screen.height - 96 - kBottomNavigationBarHeight-6,
                child: DefaultTabController(
                  length: _tabMenus.length,
                  child: _buildTabViewContent(),
                )
              )
          ],
        );
  }
}
class CompanyBodyList extends StatefulWidget{
  int type;

  CompanyBodyList(this.type);
  @override
  _CompanyBodyListState createState() {
    // TODO: implement createState
    return _CompanyBodyListState();
  }

}

class _CompanyBodyListState extends State<CompanyBodyList> with AutomaticKeepAliveClientMixin{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  int page;
  List data =List();

  _OnRefresh(){
    page=0;

    new MiviceRepository().getCompanyList(page,searchType:widget.type).then((value) {
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
    new MiviceRepository().getCompanyList(page,searchType: widget.type).then((value) {
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return SmartRefresher(

        header: WaterDropHeader(),
        footer: ClassicFooter(),
        controller: _refreshController,
        onRefresh: _OnRefresh,
        onLoading: _loadMore,
        enablePullUp: true,
        child: ListView.builder(itemBuilder: (context, index) {
          if (data.length >0 && index < data.length) {
            return  GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: CompanyRowItem(
                  company: data[index],
                  index: index,
                  lastItem: index == data.length - 1),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompanyDetail( data[index]["id"]),
                    ));
              },
            );
          }
          return Text("");
        },
          itemCount: data.length,
        )
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}