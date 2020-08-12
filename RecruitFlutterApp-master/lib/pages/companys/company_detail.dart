import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/company_pic_list.dart';
import 'package:recruit_app/pages/account/register/login_pd_page.dart';
import 'package:recruit_app/pages/bm_result.dart';
import 'package:recruit_app/pages/jobs/job_detail.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';

class CompanyDetail extends StatefulWidget {
  int id;
  String url;
  CompanyDetail(this.id,{this.url});
  @override
  _CompanyDetailState createState() => _CompanyDetailState();
}








class _CompanyDetailState extends State<CompanyDetail> {
  List<CompanyPicData> _picList = CompanyPicList.loadCompanyPicList();
  Map infors ;

  List datalist=List() ;
 String labelStr = "暂未填写公司福利";
//  List<GSInfo> gsInfos=List();

  List _sexList=["公司信息虚假","变相发布广告和招商信息","包含，欺诈，诱导欺骗等信息","其他违规行为"];
  Map SaveDatas=Map();
  bool isSvae = false;
  void _showSexPop(BuildContext context){
    FixedExtentScrollController  scrollController = FixedExtentScrollController(initialItem:0);
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context){
          return _buildBottonPicker(
              CupertinoPicker(

                magnification: 1,
                itemExtent:58 ,
                backgroundColor: Colors.white,
                useMagnifier: true,
                scrollController: scrollController,
                onSelectedItemChanged: (int index){


                },
                children: List<Widget>.generate(_sexList.length, (index){
                  return Center(
                    child: Text(_sexList[index]),
                  );
                }),
              )
          );
        });
  }

  Widget _buildBottonPicker(Widget picker) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 52,
          color: Colours.gray_F6F6F6,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Positioned(

                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("取消",
                    style: TextStyle(
                        color: Colours.black_212920,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.none
                    ),),
                ),
              ),
              Positioned(
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    setState(() {


                    });
                  },
                  child: Text("确定",
                    style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colours.app_main,
                        fontSize: 17,
                        fontWeight: FontWeight.bold
                    ),),
                ),
              ),
            ],
          ),
        ),
        Container(

          height: 190,
          padding: EdgeInsets.only(top: 6),
          color: Colors.white,
          child: DefaultTextStyle(
            style: const TextStyle(
                color: Colours.black_212920,
                fontSize: 18
            ),
            child: GestureDetector(
              child: SafeArea(
                top: false,
                child: picker,
              ),
            ),
          ),
        )
      ],

    );
  }



  @override
  void initState() {
    super.initState();

    if(ShareHelper.isLogin()){
      isSvae = ShareHelper.isHaveData(widget.url,"company");
    }else{
      isSvae = false;
    }

    _loadData();
//  _testData();
  }

  _loadData(){

    new MiviceRepository().getJzCompanyDetail(widget.url).then((value) {
      var reponse = json.decode(value.toString());

        var   data = reponse;

        setState(() {
          infors = data["company"];
        List  jobList = data["comShowJob"];
        datalist.clear();
          datalist.addAll(jobList);

          if(infors["label"] !=null && infors["label"] != "") {
            List labels = infors["label"];
            for (var item in labels) {
              if (labelStr == "暂未填写公司福利") {
                labelStr = item.toString();
              } else {
                labelStr = labelStr + "  |  " + item.toString();
              }
            }
          }

          SaveDatas["name"] = infors["name"];
          SaveDatas["label"] = infors["label"];
          SaveDatas["address"] = infors["address"];
          SaveDatas["job_num"] = infors["job_num"];
          SaveDatas["jobHref"] = widget.url;

        });


    });
  }
//  void _getContent(){
//    gsInfos.clear();
//    if(com_label == null){
//      return;
//    }
//    com_label.forEach((key, value) {
// GSInfo gsInfo = GSInfo(key, value);
//     gsInfos.add(gsInfo);
//     });
//    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/bg_wjd_share_init.jpg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 30,
              sigmaX: 30,
            ),
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.7),
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          AppBar(
            leading: IconButton(
                icon: Image.asset(
                  'images/ic_action_back_white.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
            automaticallyImplyLeading: false,
            centerTitle: true,
            brightness: Brightness.dark,
            iconTheme: IconThemeData(color: Colors.black87),
            backgroundColor: Colors.transparent,
            title: Text(
              '公司详情',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            actions: <Widget>[
              IconButton(
                  icon: Image.asset(
                    'images/ic_action_report_black.png',
                    width: 24,
                    height: 24,
                    color: Colors.white,
                  ),
                  onPressed: () {

                    _showSexPop(context);
                  }),
            ],
          ),
          SafeArea(
            child: Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: kToolbarHeight),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 18, bottom: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Card(
                        elevation: 1,

                        child: Container(
                          height:180,
                          child: Stack(
                            children: <Widget>[
                               Positioned(
                                 left: 76,
                                 top: 22,
                                 right: 90,
                                 child:  Text( infors == null?"": infors["name"],
                                     maxLines: 2,
                                     overflow: TextOverflow.ellipsis,
                                     style: const TextStyle(
                                         wordSpacing: 1,
                                         letterSpacing: 1,
                                         fontSize: 16,
                                         fontWeight: FontWeight.bold,
                                         color: Colors.black87)),
                               ),
                              Positioned(
                                left: 16,
                                top: 20,
                                child:  ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(4)),
                                  child: Image.network(
                                    "http://www.zaojiong.com/data/logo/20170418/14906489056.PNG",
                                      width: 50,
                                      height: 50,
                                      fit: BoxFit.fill),
                                ),
                              ),
                              Positioned(
                                left: 76,
                                top: 60,
                                child:Row(
                                  children: <Widget>[

                                    Text(
                                      labelStr,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(22),
                                        color: Color.fromRGBO(151, 151, 151,6),
                                      ),
                                    ),
                                  ],
                                )),
                              Positioned(
                                right: 4,
                                top: 4,
                                child: Image.asset('images/jz_rz.png',
                                    width: ScreenUtil().setWidth(94),
                                    height: ScreenUtil().setWidth(34),
                                    fit: BoxFit.cover),
                              ),
                              Positioned(
                                bottom: 20,
                                left:16,
                                right: 16,
                                child: Container(
                                  height: 60,
                                  decoration: BoxDecoration(
                                    color: Color(0xfff8f8f8),
                                    borderRadius: BorderRadius.circular(4)
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "在招职位",
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                           infors == null?"": "${infors["job_num"]}个" ,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width:  0.2,
                                        height: 34,
                                        color: Colors.black26,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "共邀面试",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              infors == null?"":  "${int.parse(infors["invite_num"].toString())+1}个" ,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        width: 0.2,
                                        height: 34,
                                        color: Colors.black26,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              "简历处理率",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey
                                              ),
                                            ),
                                            SizedBox(
                                              height: 8,
                                            ),
                                            Text(
                                              "100%",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87
                                              ),
                                            )
                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                )
                              )
                            ],
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 30,
                      ),
//                      Container(
//                        height: 40,
//                        child: ListView.builder(
//                            physics: BouncingScrollPhysics(),
//                            shrinkWrap: true,
//                            scrollDirection: Axis.horizontal,
//                            itemCount: tip.length,
//                            itemBuilder: (context, index) {
//                              if (index < tip.length) {
//                                return CompanyWelfareItem(
//                                  welfareData: tip[index],
//                                  index: index,
//                                  isLastItem: index == tip.length - 1,
//                                );
//                              }
//                              return null;
//                            }),
//                      ),
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        children: <Widget>[
//                          Expanded(
//                            child: Wrap(
//                                crossAxisAlignment: WrapCrossAlignment.center,
//                                spacing: 20,
//                                runSpacing: 10,
//                                children: <Widget>[
//                                  Text('上午10:00-下午07:00',
//                                      style: TextStyle(
//                                          fontSize: 14, color: Colors.white)),
//                                  Text('双休',
//                                      style: TextStyle(
//                                          fontSize: 14, color: Colors.white)),
//                                  Text('弹性工作',
//                                      style: TextStyle(
//                                          fontSize: 14, color: Colors.white)),
//                                ]),
//                          ),
//                          SizedBox(
//                            width: 15,
//                          ),
//                          Text('更多福利',
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                              style: TextStyle(
//                                  wordSpacing: 1,
//                                  letterSpacing: 1,
//                                  fontSize: 14,
//                                  color: Color.fromRGBO(181, 182, 183, 1))),
//                          SizedBox(
//                            width: 8,
//                          ),
//                          Image.asset(
//                            'images/f3_right_arrow_white.png',
//                            width: 10,
//                            height: 10,
//                            fit: BoxFit.cover,
//                          ),
//                        ],
//                      ),

                      Text('公司介绍',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),

                    Html(data: infors== null?"":infors["summary"].toString().replaceAll("查看更多", "")),

//                      Text('公司照片',
//                          maxLines: 1,
//                          overflow: TextOverflow.ellipsis,
//                          style: const TextStyle(
//                              wordSpacing: 1,
//                              letterSpacing: 1,
//                              fontSize: 18,
//                              fontWeight: FontWeight.bold,
//                              color: Colors.black87)),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Container(
//                        height: 150,
//                        child: ListView.builder(
//                            physics: BouncingScrollPhysics(),
//                            shrinkWrap: true,
//                            scrollDirection: Axis.horizontal,
//                            itemCount: _picList.length,
//                            itemBuilder: (context, index) {
//                              if (index < _picList.length) {
//                                return CompanyPicItem(
//                                  picData: _picList[index],
//                                  index: index,
//                                  isLastItem: index == _picList.length - 1,
//                                );
//                              }
//                              return null;
//                            }),
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
                      Text('公司地址',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      SizedBox(
                        height: 20,
                      ),
                      Stack(
                        alignment: Alignment.center,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: Image.asset('images/map_icon.jpg',
                                height: 100, fit: BoxFit.cover),
                          ),
                          Text(infors == null? "" :infors["address"])
                        ],
                      ),

                      SizedBox(
                        height: 20,
                      ),
//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: Text('公司还有9个其他办公地址',
//                                maxLines: 1,
//                                overflow: TextOverflow.ellipsis,
//                                style: const TextStyle(
//                                    wordSpacing: 1,
//                                    letterSpacing: 1,
//                                    fontSize: 14,
//                                    color: Colors.white)),
//                          ),
//                          SizedBox(
//                            width: 15,
//                          ),
//                          Text('查看全部',
//                              maxLines: 1,
//                              overflow: TextOverflow.ellipsis,
//                              style: const TextStyle(
//                                  wordSpacing: 1,
//                                  letterSpacing: 1,
//                                  fontSize: 14,
//                                  color: Color.fromRGBO(181, 182, 183, 1))),
//                        ],
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Text('公司官网',
//                          maxLines: 1,
//                          overflow: TextOverflow.ellipsis,
//                          style: const TextStyle(
//                              wordSpacing: 1,
//                              letterSpacing: 1,
//                              fontSize: 18,
//                              fontWeight: FontWeight.bold,
//                              color: Colors.white)),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Row(
//                        crossAxisAlignment: CrossAxisAlignment.center,
//                        mainAxisAlignment: MainAxisAlignment.start,
//                        children: <Widget>[
//                          Expanded(
//                            child: Text('http://www.tencent.com',
//                                maxLines: 1,
//                                overflow: TextOverflow.ellipsis,
//                                style: const TextStyle(
//                                    wordSpacing: 1,
//                                    letterSpacing: 1,
//                                    fontSize: 14,
//                                    color: Colors.white)),
//                          ),
//                          SizedBox(
//                            width: 15,
//                          ),
//                          Image.asset(
//                            'images/f3_right_arrow_white.png',
//                            width: 10,
//                            height: 10,
//                            fit: BoxFit.cover,
//                          ),
//                        ],
//                      ),
//                      SizedBox(
//                        height: 20,
//                      ),
//                      Text('工商信息',
//                          maxLines: 1,
//                          overflow: TextOverflow.ellipsis,
//                          style: const TextStyle(
//                              wordSpacing: 1,
//                              letterSpacing: 1,
//                              fontSize: 18,
//                              fontWeight: FontWeight.bold,
//                              color: Colors.black87)),
//                      SizedBox(
//                        height: 20,
//                      ),
//                     ListView.builder(itemBuilder: (BuildContext context,int index){
//                       return GsItemwidget(gsInfos[index]);
//                     },
//                       itemCount: gsInfos.length,
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics()
//                     ),
                      SizedBox(
                        height: 16,
                      ),
                      Text('在招职位',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87)),
                      SizedBox(
                        height: 20,
                      ),
                    Container(
                      height: 1,
                      color: Color(0xfff8f8f8),
                    ),
                      ListView.builder(itemBuilder: (BuildContext context,int index){
                        if(datalist.length ==0 || datalist[index]== null){

                          return Text("");
                        }else{
                          return GestureDetector(
                             onTap: (){
                               Navigator.push(
                                   context,
                                   MaterialPageRoute(
                                     builder: (context) => JobDetail(0,url:datalist[index]["href"]),
                                   ));
                             },
                              behavior: HitTestBehavior.opaque,
                            child:JzComItem(job:datalist[index],index: index,
                                lastItem: index == datalist.length - 1)
                          );
                        }

                      },
                          itemCount: datalist.length ,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics()
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
//          BottomDrawerWidget(
//            child: buildJobDrawer(),
//            marginTop: kToolbarHeight,
//            smallHeight: 56,),

        Positioned(
          bottom: 0,
          right: 20,
          left: 20,
          child:    SafeArea(
            top: false,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                child: MaterialButton(
                  color: isSvae?Colors.grey:Colours.app_main,
                  onPressed: () {
                    if(!ShareHelper.isLogin()){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginPdPage()));
                      return;
                    }
                    if(isSvae){
                      ShareHelper.deletData(widget.url,"company");
                    }else{
                      ShareHelper.saveData(SaveDatas,"company");

                    }
                    setState(() {
                      isSvae = !isSvae;
                    });
                  },
                  textColor: Colors.white,
                  child: Text(isSvae?"已关注" : "+ 关注"),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                )),
          ),
        )
        ],

      ),
    );
  }



}





class JzComItem extends StatelessWidget {
  final Map<String,dynamic> job;
  final int index;
  final bool lastItem;

  List tags;
  JzComItem({Key key, this.job, this.index, this.lastItem})
      : super(key: key);



  Widget _getTip(){
    tags = job["label"];
    List<Widget> tipWidget=[];
    List<Widget> columWidget=[];
    if(tags == null|| tags.length>0 ){

      for (var item in tags){
        if(item == " "||item ==""){
          continue;
        }
        tipWidget.add( TextTagWidget("$item",
          backgroundColor: Color(0xFFF0F0F0),
          margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
          padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
          borderRadius: 2,
          borderColor: Color(0xFFF0F0F0),
          textStyle: TextStyle(
              color: Colors.black54,
              fontSize: 12
          ),
        ));
      }

      columWidget.add(Wrap(children: tipWidget));


    }else{
      columWidget.add(Container(height: 0,));
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: columWidget,
    );
  }
  @override
  Widget build(BuildContext context) {
    final jobItem = Padding(
      padding: EdgeInsets.only(
          top: ScreenUtil().setWidth(20),
          bottom: ScreenUtil().setWidth(30)),
      child:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        job["title"].toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: ScreenUtil().setSp(32),
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(20, 20, 20, 1),
                        ),
                      ),
                    ),


                  ],
                ),
              ),
              SizedBox(width: 16),
              Text(job["salary"].toString(),
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(32),
                      fontWeight: FontWeight.bold,
                      color: Colours.app_main)),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setWidth(20),
          ),
          _getTip(),
          SizedBox(
            height: ScreenUtil().setWidth(28),
          ),


          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Image.asset(
                      'images/dz.png',
                      width: ScreenUtil().setWidth(30),
                      height: ScreenUtil().setWidth(30),
                      fit: BoxFit.cover,
                    ),

                    SizedBox(
                      width: ScreenUtil().setWidth(12),
                    ),
                    Text(job["address"].toString(),
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(28),
                            color: Colors.black54)),
                    SizedBox(
                      width: ScreenUtil().setWidth(20),
                    ),
                    Image.asset(
                      'images/rq.png',
                      width: ScreenUtil().setWidth(30),
                      height: ScreenUtil().setWidth(30),
                      fit: BoxFit.cover,
                    ),

                    SizedBox(
                      width: ScreenUtil().setWidth(12),
                    ),
                    Text(job["pub_time"].toString(),
                        style: TextStyle(
                            fontSize: ScreenUtil().setSp(28),
                            color: Colors.black54)),
                  ],
                ),

              ),

              Container(
                height: 28,
                width: 80,
                decoration: BoxDecoration(
                    color: Colours.app_main,
                    borderRadius: BorderRadius.circular(2)
                ),
                child: Text(
                  "报名",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 12
                  ),
                ),
                alignment: Alignment.center,
              )
            ],
          ),
          SizedBox(height: 16,),
          Container(
            color: Color(0xfff8f8f8),
            height: 2,
          )
        ],
      ),
    );

    if (lastItem) {
      return jobItem;
    }
    return Column(
      children: <Widget>[
        jobItem,
      ],
    );
  }
}
