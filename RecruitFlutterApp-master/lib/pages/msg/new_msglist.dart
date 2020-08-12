import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/topictab_model.dart';
import 'package:recruit_app/pages/jobs/chat_room.dart';
import 'package:recruit_app/pages/jobs/job_company_search.dart';
import 'package:recruit_app/pages/jobs/job_list.dart';
import 'package:recruit_app/pages/msg/msg_job.dart';
import 'package:recruit_app/pages/msg/notice_list.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/utils/screen.dart';
import 'package:recruit_app/widgets/slide_button.dart';

import '../JobPage.dart';
import 'msg_chat_item.dart';



class NewMessageList extends StatefulWidget {



  @override
  _NewMessageListState createState() => _NewMessageListState();
}

class _NewMessageListState extends State<NewMessageList> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> _tabMenus = <Tab> [
    new Tab(text: '互动'),
    new Tab(text: '通知'),
  ];


   int _currentPosition = 0;

   void _onTabbarItemPressed(index) {
//     final ValueChanged<int> tabbarItemClick;
   }

   Widget _buildTabViewContent() {
    return new TabBarView(children:  [
      CompanyBodyList(),
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

  CompanyBodyList();
  @override
  _CompanyBodyListState createState() {
    // TODO: implement createState
    return _CompanyBodyListState();
  }

}

class _CompanyBodyListState extends State<CompanyBodyList> with AutomaticKeepAliveClientMixin{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  int sortId;
  List data =List();
  List<TopicTabModel> topicTabMenus=List();
  int type = 0;

  _OnRefresh(){
    sortId=null;

    new MiviceRepository().getMessageList("",type).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        data.clear();

        setState(() {
          data = reponse["result"];
        });

        _refreshController.refreshCompleted();
      }
    });
  }
  _loadMore(){
    new MiviceRepository().getCompanyList(sortId).then((value) {
        _refreshController.loadComplete();

    });
  }
  @override
  Widget build(BuildContext context) {
    topicTabMenus.clear();
    TopicTabModel tabModel1 = TopicTabModel(picture: "images/m_icon1.png",link: "感兴趣");
    TopicTabModel tabModel2 = TopicTabModel(picture: "images/m_icon2.png",link: "看过我的");
    TopicTabModel tabModel3 = TopicTabModel(picture: "images/m_icon3.png",link: "智能推荐");
    TopicTabModel tabModel4 = TopicTabModel(picture: "images/m_icon4.png",link: "职位上新");
    this.topicTabMenus.add(tabModel1);
    this.topicTabMenus.add(tabModel2);
    this.topicTabMenus.add(tabModel3);
    this.topicTabMenus.add(tabModel4);

    // TODO: implement build
    return Flex(
      direction:Axis.vertical,
      children: <Widget>[
        Expanded(
          flex: 0,
child: _buildMiddelBar(topicTabMenus,context),
        ),
      Expanded(

        child: SmartRefresher(

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
                 onTap: (){
                   Navigator.push(context,
                       MaterialPageRoute(builder: (context) => ChatRoom()));
                 },
                behavior: HitTestBehavior.opaque,
                child:MsgChatItem(btnKey: key) ,
              ) ;
            },

              itemCount: 10,
            )
        )
      )

      ],
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

}

Widget _buildMiddelBar( List<TopicTabModel> topicTabMenus,BuildContext context) {
  return Container(
    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
    child:  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: topicTabMenus.map((model){
        return Expanded(
          flex: 1,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap:(){
              switch(model.link){
                case "感兴趣":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MsgJob(0),
                      ));
                  break;
                case "看过我的":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MsgJob(1),
                      ));
                  break;
                case "智能推荐":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MsgJob(2),
                      ));
                  break;
                case "职位上新":
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MsgJob(3),
                      ));
                  break;
              }
            },
            child:new Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image(
                  width: 46,
                  height: 46,
                  image: AssetImage(model.picture),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  model.link,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 12
                  ),
                )
              ],

            ),
          )
        );
      }).toList(),
    ),
  );
}