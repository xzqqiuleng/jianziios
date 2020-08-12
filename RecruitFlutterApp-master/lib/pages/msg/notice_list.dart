import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/topictab_model.dart';
import 'package:recruit_app/pages/jobs/job_company_search.dart';
import 'package:recruit_app/pages/jobs/job_list.dart';
import 'package:recruit_app/pages/msg/service_chat_room.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/utils/screen.dart';
import 'package:recruit_app/widgets/slide_button.dart';

import 'msg_chat_item.dart';
import 'msg_interview_item.dart';
import 'msg_notify.dart';
import 'msg_notify_item.dart';



class NoticeList extends StatefulWidget {



  @override
  _NoticeListState createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> _tabMenus = <Tab> [
    new Tab(text: '面试邀请'),
    new Tab(text: '系统'),
  ];


   int _currentPosition = 0;

   void _onTabbarItemPressed(index) {
//     final ValueChanged<int> tabbarItemClick;
   }

   Widget _buildTabViewContent() {
    return new TabBarView(children:  [
      MSList(),
      XTList(),
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
         padding: EdgeInsets.symmetric(
           horizontal: ScreenUtil().setWidth(24),
           vertical: ScreenUtil().setWidth(0),
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
                   indicatorColor: Colors.white,

                   indicatorPadding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                   labelColor: Colors.black87,
                   labelPadding: new EdgeInsets.only(left: 16.0,right: 16.0),
                   labelStyle: new TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colours.app_main),
                   unselectedLabelColor: Colors.black54,
                   unselectedLabelStyle: new TextStyle(fontSize: 16.0),
                 ),
                 alignment: Alignment.centerLeft,
                 padding: EdgeInsets.only(left: 10),
               ),
             ),


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
                  height:50,
                  child: _buildContentTabbar()
              ),
              new Container(
                color: Colors.white,
                height:Screen.height - 146 - kBottomNavigationBarHeight-6,
                child: DefaultTabController(
                  length: _tabMenus.length,
                  child: _buildTabViewContent(),
                )
              )
          ],
        );
  }
}
class MSList extends StatefulWidget{

  MSList();
  @override
  _MSListState createState() {
    // TODO: implement createState
    return _MSListState();
  }

}

class _MSListState extends State<MSList> with AutomaticKeepAliveClientMixin{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  int sortId;
  List data =List();



  _OnRefresh(){
    sortId=null;

    new MiviceRepository().getCompanyList(sortId).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        data.clear();

        setState(() {
          data = reponse["result"];
        });
        print(data);
        sortId = data[data.length-1]["sort_id"];
        _refreshController.refreshCompleted();
      }
    });
  }
  _loadMore(){
    new MiviceRepository().getCompanyList(sortId).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        List  loaddata = reponse["result"];
        setState(() {
          data.addAll(loaddata);
        });

        sortId = int.parse(data[data.length-1]["sort_id"]);
        _refreshController.loadComplete();
      }
    });
  }
  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return  SmartRefresher(

            header: WaterDropHeader(),
            footer: ClassicFooter(),
            controller: _refreshController,
            onRefresh: _OnRefresh,
            onLoading: _loadMore,
            enablePullUp: true,
            child: ListView.builder(itemBuilder: (context, index) {
//          if (data.length >0 && index < data.length) {
//            return  GestureDetector(
//              behavior: HitTestBehavior.opaque,
//              child: MsgChatItem(btnKey: key),
//            );
//          }
              var key = GlobalKey<SlideButtonState>();
              return MsgInterviewItem(btnKey: key);
            },

              itemCount: 10,
            )
        );

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

class XTList extends StatefulWidget{

  XTList();
  @override
  _XTListState createState() {
    // TODO: implement createState
    return _XTListState();
  }

}

class _XTListState extends State<XTList> with AutomaticKeepAliveClientMixin{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);




  _OnRefresh(){
    _refreshController.refreshCompleted();
  }
  _loadMore(){
    _refreshController.loadComplete();
  }
  @override
  Widget build(BuildContext context) {


    // TODO: implement build
    return  SmartRefresher(

        header: WaterDropHeader(),
        footer: ClassicFooter(),
        controller: _refreshController,
        onRefresh: _OnRefresh,
        onLoading: _loadMore,
        enablePullUp: true,
        child: ListView.builder(itemBuilder: (context, index) {
//          if (data.length >0 && index < data.length) {
//            return  GestureDetector(
//              behavior: HitTestBehavior.opaque,
//              child: MsgChatItem(btnKey: key),
//            );
//          }
          var key = GlobalKey<SlideButtonState>();
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: MsgNotifyItem(
              btnKey: key,
              title: index % 2 == 0 ? '通知' : '我的客服',
              content: index % 2 == 0
                  ? '明天您将参加一场面试，请您注意安排好行程做好 准备，祝您面试顺利。'
                  : '您好，请问有什么可以为您服务的吗？',
              imgPath: index % 2 == 0
                  ? 'images/notice_m.png'
                  : 'images/kf_m.png',
            ),
            onTap: () {
              if(index%2==0){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MsgNotify()));
              }else {
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ServiceChatRoom()));
              }
            },
          );
        },

          itemCount: 2,
        )
    );

  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

