import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/companys/company_search.dart';
import 'package:recruit_app/pages/employe/employsearch_page.dart';
import 'package:recruit_app/pages/jzpage.dart';
import 'package:recruit_app/pages/storage_manager.dart';
import '../share_helper.dart';
import 'jobsearch_page.dart';

enum SearchType { job, company,jl }

class JobCompanySearch extends StatefulWidget {
  final SearchType searchType;

  const JobCompanySearch({Key key, this.searchType}) : super(key: key);

  @override
  _JobCompanySearchState createState() => _JobCompanySearchState();
}


class _JobCompanySearchState extends State<JobCompanySearch> {
  List<dynamic> hotlabels=List();
  List<dynamic> historylabels;
  List<Widget> hotList=[];
  List<Widget>historyList=[];

  @override
  void initState() {
    
    if(widget.searchType == SearchType.job){
      hotlabels.add("传单");
      hotlabels.add("服务员");
      hotlabels.add("业余");
      hotlabels.add("周末");
      hotlabels.add("校园");
      hotlabels.add("学生");
      hotlabels.add("主播");
      hotlabels.add("配送");

      historylabels = ShareHelper.getSearchJob();
    }else if(widget.searchType == SearchType.company){
      hotlabels.add("亚信科技");
      hotlabels.add("亚马逊中国");
      hotlabels.add("光明乳业");
      hotlabels.add("伊利");
      hotlabels.add("长虹电器");
      hotlabels.add("奇安信集团");
      historylabels = ShareHelper.getSearchCompany();
    }else if(widget.searchType == SearchType.jl){
      hotlabels.add("销售");
      hotlabels.add("互联网");
      hotlabels.add("金融");
      hotlabels.add("物流");
      hotlabels.add("酒店");
      historylabels = ShareHelper.getSearchJl();

    }
    _getHotLabel();
    _getHistoryLabel();
  }

  Widget _getHotLabel(){
    if(hotlabels != null && hotlabels.length >0){

      for (var i = 0; i < hotlabels.length; i++) {
        var str = hotlabels[i];
        hotList.add(GestureDetector(
          onTap: (){

            ShareHelper.putSearchJob(str);
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => JZPage(str)));

          },
          child:TextTagWidget("$str",
            backgroundColor: Colors.white,
            borderRadius: 2,
            margin: EdgeInsets.fromLTRB(0, 0,12, 12),
            padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
            borderColor: Color(0xFFF0F0F0),
            textStyle: TextStyle(
                color: Colours.app_main,
                fontSize: 14
            ),
          )
        ));
      }

    }
  }

  Widget _getHistoryLabel(){
    if(historylabels != null && historylabels.length >0){

      for (var i = 0; i < historylabels.length; i++) {
        var str = historylabels[i];
        historyList.add(GestureDetector(
          onTap: (){

            ShareHelper.putSearchJob(str);
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => JZPage(str)));

          },
          child:TextTagWidget("$str",
            backgroundColor: Color(0xFFF0F0F0),
            margin: EdgeInsets.fromLTRB(0, 0, 10, 8),
            padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
            borderColor: Color(0xFFF0F0F0),
            textStyle: TextStyle(
              color: Colors.black87,
              fontSize: 12,

            ),

          ) ,
        ));
      }

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(48),
                  vertical: ScreenUtil().setWidth(15),
                ),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: Color.fromRGBO(245, 245, 245, 1),
                        width: ScreenUtil().setWidth(1)),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Image.asset(
                        'images/img_arrow_left_black.png',
                        width: ScreenUtil().setWidth(20),
                        height: ScreenUtil().setWidth(36),
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(66),
                    ),
                    Expanded(
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Image.asset(
                              'images/img_search_gray.png',
                              width: ScreenUtil().setWidth(26),
                              height: ScreenUtil().setWidth(26),
                              fit: BoxFit.contain,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                horizontal: ScreenUtil().setWidth(40),
                              ),
                              height: ScreenUtil().setWidth(24),
                              width: ScreenUtil().setWidth(2),
                              color: Colors.black26,
                            ),
                            Expanded(
                              child: TextField(
                                textInputAction:TextInputAction.search,
                                autofocus: false,
                                scrollPadding: EdgeInsets.all(0),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                                cursorColor: Color.fromRGBO(176, 181, 180, 1),
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(24),
                                    color: Color.fromRGBO(95, 94, 94, 1)),
                                decoration: InputDecoration(

                                  contentPadding: EdgeInsets.all(0),
                                  border: InputBorder.none,
                                  hintText: widget.searchType == SearchType.job
                                      ? '输入岗位名称'
                                      : '快速搜索',
                                  hintStyle: TextStyle(
                                    fontSize: ScreenUtil().setSp(24),
                                    color: Color.fromRGBO(176, 181, 180, 1),
                                  ),
                                ),
                                onSubmitted: (text) {
                                  if(text.trim().length <=0){
                                    return;
                                  }

                                  ShareHelper.putSearchJob(text);
                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                      builder: (context) => JZPage(text)));
                                },
                              ),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(40),
                          vertical: 0,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0xFFF0F0F0),
                            borderRadius: BorderRadius.circular(
                                ScreenUtil().setWidth(1000))),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(48),
                    vertical: ScreenUtil().setWidth(26)),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        '搜索历史',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(28),
                          color: Color.fromRGBO(57, 57, 57, 1),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(15),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {

                          if(historylabels == null || historyList == null || historylabels.length == 0|| historyList.length == 0){
                            return;
                          }

                        if(widget.searchType == SearchType.job){
                          StorageManager.sharedPreferences.setString(ShareHelper.search_history_job, "");



                        }else if(widget.searchType == SearchType.company){
                          StorageManager.sharedPreferences.setString(ShareHelper.search_history_company, "");
                        }else{
                          StorageManager.sharedPreferences.setString(ShareHelper.search_history_jl, "");
                        }
                        setState(() {
                          historylabels.clear();
                          historyList.clear();
                        });
                      },
                      child: Image.asset(
                        'images/img_del_gray.png',
                        width: ScreenUtil().setWidth(20),
                        height: ScreenUtil().setWidth(24),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(48),right: ScreenUtil().setWidth(48)),
                child:Wrap(

                  ///子标签
                    children: historyList) ,
              ),
              SizedBox(
                height: ScreenUtil().setWidth(20),
              ),
               Padding(
                 padding: EdgeInsets.symmetric(
                     horizontal: ScreenUtil().setWidth(48),
                     vertical: ScreenUtil().setWidth(26)),
                 child:    Text(
                   '热门搜索',
                   maxLines: 1,
                   overflow: TextOverflow.ellipsis,
                   style: TextStyle(
                     fontSize: ScreenUtil().setSp(28),
                     color: Color.fromRGBO(57, 57, 57, 1),
                   ),
                 ),
               ),
              SizedBox(
                height: ScreenUtil().setWidth(10),
              ),
              Padding(
                padding: EdgeInsets.only(left: ScreenUtil().setWidth(48),right: ScreenUtil().setWidth(48)),
                child:Wrap(

                  ///子标签
                    children: hotList) ,
              ),

//              Expanded(
//                child: ListView.builder(
//                  itemBuilder: (context, index) {
//                    if (index <
//                        (widget.searchType == SearchType.job
//                            ? _jobList.length
//                            : _companyList.length)) {
//                      return widget.searchType == SearchType.job
//                          ? GestureDetector(
//                              behavior: HitTestBehavior.opaque,
//                              child: JobRowItem(
////                                  job: _jobList[index],
//                                  index: index,
//                                  lastItem: index == _jobList.length - 1),
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => JobDetail(),
//                                    ));
//                              })
//                          : GestureDetector(
//                              behavior: HitTestBehavior.opaque,
//                              child: CompanyRowItem(
////                                  company: _companyList[index],
//                                  index: index,
//                                  lastItem: index == _companyList.length - 1),
//                              onTap: () {
//                                Navigator.push(
//                                    context,
//                                    MaterialPageRoute(
//                                      builder: (context) => CompanyDetail(),
//                                    ));
//                              },
//                            );
//                    }
//                    return null;
//                  },
//                  itemCount: widget.searchType == SearchType.job
//                      ? _jobList.length
//                      : _companyList.length,
//                  physics: const BouncingScrollPhysics(),
//                ),
//              ),
            ],
          ),
        ));
  }
}
