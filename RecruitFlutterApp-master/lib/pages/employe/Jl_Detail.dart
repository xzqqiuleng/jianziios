import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/job_intent_list.dart';
import 'package:recruit_app/model/mine_edu_list.dart';
import 'package:recruit_app/model/mine_project_list.dart';
import 'package:recruit_app/model/mine_work_list.dart';
import 'package:recruit_app/pages/mine/edu_item.dart';
import 'package:recruit_app/pages/mine/job_intent_item.dart';
import 'package:recruit_app/pages/mine/me_desc.dart';
import 'package:recruit_app/pages/mine/me_gzjl.dart';
import 'package:recruit_app/pages/mine/me_qw.dart';
import 'package:recruit_app/pages/mine/project_item.dart';
import 'package:recruit_app/pages/mine/work_item.dart';

class JLDetail extends StatefulWidget {
  @override
  _JLDetailState createState() {
    // TODO: implement createState
    return _JLDetailState();
  }
}

class _JLDetailState extends State<JLDetail> {
  List<IntentData> _intentList = JobIntentList.loadJobIntent();
  List<MineWorkData> _workList = MineWorkList.loadWorkList();
  List<MineProjectData> _projectList = MineProjectList.loadProjectList();
  List<MineEduData> _eduList = MineEduList.loadEduList();


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      appBar:  AppBar(
        elevation: 0,
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
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'images/ic_action_favor_off_black.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {}),
          IconButton(
              icon: Image.asset(
                'images/ic_action_share_black.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {}),
          IconButton(
              icon: Image.asset(
                'images/ic_action_report_black.png',
                width: 24,
                height: 24,
              ),
              onPressed: () {})
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 18, bottom: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[

                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      'images/avatar_15.png',
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
              SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      child: Text(
                                        '狐说',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromRGBO(37, 38, 39, 1),
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text('5年经验•26岁•本科',
                                    style: const TextStyle(
                                      wordSpacing: 1,
                                      letterSpacing: 1,
                                      fontSize: 14,
                                      color: Color.fromRGBO(164, 165, 166, 1),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(width: 8,),

                        ],
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        color: Color.fromRGBO(242, 243, 244, 1),
                        height: 1,
                      ),
                      Text(
                        '* 自我介绍',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colours.app_main,
                        ),
                      ),
                      SizedBox(height: 8),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MeDesc(0),
                              ));
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                                child:   Text('五年产品运营经验，时刻关注行业新动态，有项目管理经验，产品设计经验。',
                                    style: TextStyle(
                                        wordSpacing: 1,
                                        letterSpacing: 1,
                                        fontSize: 14,
                                        color: Color.fromRGBO(136, 138, 138, 1))),
                            ),
                            SizedBox(width: 8,),

                          ],
                        ),
                      ),





                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        color: Color.fromRGBO(242, 243, 244, 1),
                        height: 1,
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '* 工作期望',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colours.app_main,
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),


                        ],
                      ),
                      SizedBox(height: 8,),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          if (index < _intentList.length) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: (){

                              },
                              child: JobIntentItem(
                                intentData: _intentList[index],
                                index: index,
                              ),
                            );
                          }
                          return null;
                        },
                        shrinkWrap: true,
                        itemCount: _intentList.length,
                        physics: const NeverScrollableScrollPhysics(),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        color: Color.fromRGBO(242, 243, 244, 1),
                        height: 1,
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '* 工作经历',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colours.app_main,
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),


                        ],
                      ),
                      SizedBox(height: 8,),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          if (index < _workList.length) {
                            return GestureDetector(
                              onTap: (){

                              },
                                behavior: HitTestBehavior.opaque,
                              child:  WorkItem(
                                workData: _workList[index],
                                index: index,
                              )
                            );
                          }
                          return null;
                        },
                        shrinkWrap: true,
                        itemCount: _workList.length,
                        physics: const NeverScrollableScrollPhysics(),
                      ),


                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        color: Color.fromRGBO(242, 243, 244, 1),
                        height: 1,
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '* 教育经历',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colours.app_main,
                              ),
                            ),
                          ),
                          SizedBox(width: 8,),

                        ],
                      ),
                      SizedBox(height: 8,),
                      ListView.builder(
                        itemBuilder: (context, index) {
                          if (index < _eduList.length) {
                            return GestureDetector(
                              onTap: (){

                              },
                              child: EduItem(
                                eduData: _eduList[index],
                                index: index,
                              )
                            );
                          }
                          return null;
                        },
                        shrinkWrap: true,
                        itemCount: _eduList.length,
                        physics: const NeverScrollableScrollPhysics(),
                      ),

                      Container(
                        margin: EdgeInsets.symmetric(vertical: 15),
                        color: Color.fromRGBO(242, 243, 244, 1),
                        height: 1,
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              '* 资格证书',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colours.app_main,
                              ),
                            ),
                          ),

                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 15,bottom: 50),
                        color: Color.fromRGBO(242, 243, 244, 1),
                        height: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
