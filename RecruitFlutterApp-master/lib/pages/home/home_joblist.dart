import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/jobs/job_list.dart';
import 'package:recruit_app/pages/utils/screen.dart';
import 'package:recruit_app/pages/utils/select_salary.dart';
import 'package:recruit_app/pages/utils/select_xl.dart';


class HomeJobList extends StatefulWidget {
  final bool contentScrollable;
  final ValueChanged<int> tabbarItemClick;
  final bool isScrool;



  HomeJobList({Key key,this.contentScrollable,this.tabbarItemClick,this.isScrool}) : super(key:key);

  @override
  _HomeJobListState createState() => _HomeJobListState();
}

class _HomeJobListState extends State<HomeJobList> with SingleTickerProviderStateMixin {
  TabController _tabController;
  final List<Tab> _tabMenus = <Tab> [
    new Tab(text: '推荐'),
    new Tab(text: '最新'),
  ];
  List _recommandJobs = [];
  List _newsJobs = [];
  List _newshotJobs = [];

   int _currentPosition = 0;

   void _onTabbarItemPressed(index) {
     widget.tabbarItemClick(index);
   }

   Widget _buildTabViewContent() {
    return new TabBarView(children:  [
        JobBodyList(widget.isScrool,0),
     JobBodyList(widget.isScrool,1),

     ],
            controller: _tabController,
          );
  }

  Widget _buildContentTabbar() {
   return new Stack(
//     mainAxisAlignment: MainAxisAlignment.end,
   alignment: Alignment.center,
     children: <Widget>[
       new Container(
        width: Screen.width,
         child: new TabBar(
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
       ),
       Positioned(
         right: 16,
         child: Row(
           children: <Widget>[
             GestureDetector(
               onTap: ()=>Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => SelectSalary())),
               child: Container(

                 child: Stack(
                   children: <Widget>[

                     Container(
                       alignment: Alignment.center,
                       width: 50,
                       height: 24,
                       decoration: BoxDecoration(
                           color: Colours.app_main.withOpacity(0.2),
                         borderRadius: BorderRadius.circular(2)
                       ),
                       child: Text(
                           "薪资",
                         style: TextStyle(
                           color: Colours.app_main,
                           fontSize: 12
                         ),
                       ),
                     ),
                     Positioned(
                       bottom: 4,
                       right: 4,
                       child: Image.asset("images/sanjiao.png",width: 5,height: 5,),
                     )
                   ],
                 ),
               ),
             ),
             SizedBox(
               width: 16,
             ),
             GestureDetector(
               onTap: ()=>Navigator.push(
                   context,
                   MaterialPageRoute(
                       builder: (context) => SelectXl())),
               child: Container(

                 child: Stack(
                   children: <Widget>[

                     Container(
                       alignment: Alignment.center,
                       width: 50,
                       height: 24,
                       decoration: BoxDecoration(
                           color: Colours.app_main.withOpacity(0.2),
                           borderRadius: BorderRadius.circular(2)
                       ),
                       child: Text(
                         "学历",
                         style: TextStyle(
                             color: Colours.app_main,
                             fontSize: 12
                         ),
                       ),
                     ),
                     Positioned(
                       bottom: 4,
                       right: 4,
                       child: Image.asset("images/sanjiao.png",width: 5,height: 5,),
                     )
                   ],
                 ),
               ),
             )
           ],
         ),
       ),
     ],

   );
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
                  height: kBottomNavigationBarHeight,
                  child: _buildContentTabbar()
              ),
              new Container(
                color: Colors.white,
                height:Screen.height - Screen.navigationBarHeight - kBottomNavigationBarHeight*2,
                child: DefaultTabController(
                  length: _tabMenus.length,
                  child: _buildTabViewContent(),
                )
              )
          ],
        );
  }
}