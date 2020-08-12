import 'dart:convert';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_tag_layout/flutter_tag_layout.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/account/register/login_pd_page.dart';
import 'package:recruit_app/pages/bm_result.dart';
import 'package:recruit_app/pages/companys/company_detail.dart';
import 'package:recruit_app/pages/constant.dart';
import 'package:recruit_app/pages/jobs/chat_room.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/widgets/dash_line.dart';
import 'job_row_item.dart';

class JobDetail extends StatefulWidget {
  int id;
  String url;
  JobDetail(this.id,{this.url});
  @override
  _JobDetailState createState() {
    // TODO: implement createState
    return _JobDetailState();
  }
}
class _JobDetailState extends State<JobDetail> {
  Map jobInfo ;
  List datalist=List() ;
  List<dynamic> labels;
  List<Widget> itemWidgetList=[];
  List<Widget> contentWidget=[];
  String userImg="https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2519824424,1132423651&fm=26&gp=0.jpg";
  String user="HR发布";
  Map company;
  String jobDes;
  Map linkMethod;
  String address = "暂无地址";
  String compay_desc = "暂无公司信息";

  Map SaveDatas=Map();
 bool isSvae = false;
 bool isTd = false;


  _loadData(){

     new MiviceRepository().getJZDetail(widget.url).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        var   data = reponse["result"];

        print(data);
        setState(() {
          jobInfo = data["jobInfo"];  //"com_id" -> 10057  "job_id" -> 120587312
          datalist = data["otherJob"];
          company = data["company"];
          jobDes = data["jobDes"].toString();
          linkMethod = data["linkMethod"];
        for(var intem in company["label"]){
         if(compay_desc == "暂无公司信息"){
           compay_desc =intem;
         }else{
           compay_desc = compay_desc+"·"+intem;
         }
        }
          _getLabel();
//          _getContent();
        });

        SaveDatas["jobHref"] = widget.url;
        SaveDatas["pub_time"] = jobInfo["update_time"];
        SaveDatas["companyName"] = company["name"];
        SaveDatas["companyDetList"] =jobInfo["label"];
        SaveDatas["salary"] = jobInfo["salary"];
        SaveDatas["title"] =jobInfo["title"];


      }
    });
  }

  Widget _getLabel(){
    itemWidgetList.add(Text(""));
    labels = jobInfo["label"];
    if(labels != null && labels.length >0){


      for (var i = 0; i < labels.length; i++) {
        var str = labels[i];
        itemWidgetList.add(TextTagWidget("$str",
        backgroundColor: Colors.white,
          margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
          padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
          borderColor: Colors.black87,
          borderRadius:2,

          textStyle: TextStyle(
            color: Colors.black87,
          fontSize: 14
          ),
        ));
      }

    }

  }
  List _sexList=["违法违纪，敏感言论","色情，辱骂，粗俗","职位虚假，信息不真实","违法，欺诈，诱导欺骗","收取求职者费用","变相发布广告和招商","其他违规行为"];

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
    // TODO: implement initState
    super.initState();
    _loadData();

    if(ShareHelper.isLogin()){
      isSvae = ShareHelper.isHaveData(widget.url,"work");
    }else{
      isSvae = false;
    }
    if(ShareHelper.isLogin()){
      isTd = ShareHelper.isHaveData(widget.url,"bm");
    }else{
      isTd = false;
    }
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
              icon: Image.asset(
                'images/ic_back_arrow.png',
                width: 20,
                height: 20,
              ),
              onPressed: () {
                Navigator.pop(context);
              }),
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(255, 255, 255, 1),
          actions: <Widget>[
//            IconButton(
//                icon: Image.asset(
//                  isSvae ?'images/save_yes.png':'images/save_no.png',
//                  width: 24,
//                  height: 24,
//                ),
//                onPressed: () {
//                  if(!ShareHelper.isLogin()){
//                    Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                            builder: (context) => LoginPdPage()));
//                    return;
//                  }
//                  if(isSvae){
//                    ShareHelper.deletData(widget.url,"work");
//                  }else{
//                    ShareHelper.saveData(SaveDatas,"work");
//
//                  }
//                  setState(() {
//                    isSvae = !isSvae;
//                  });
//
//                }),
            IconButton(
                icon: Image.asset(
                  'images/ic_action_report_black.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {_showSexPop(context);})
          ],
        ),
        body: Column(
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
                      Card(
                        margin:EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(jobInfo == null? "":jobInfo["title"],

                                  style: const TextStyle(
                                      wordSpacing: 1,
                                      letterSpacing: 1,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromRGBO(37, 38, 39, 1))),
                              SizedBox(
                                height: 10,
                              ),
                              Text(jobInfo == null? "":jobInfo["salary"],
                                  style: const TextStyle(
                                      wordSpacing: 1,
                                      letterSpacing: 1,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colours.app_main)),
                              SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "最近更新时间:",
                                    style: TextStyle(
                                        color: Color(0xff515151)
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    linkMethod== null||linkMethod["online_time"]==null ?"":linkMethod["online_time"],
                                    style: TextStyle(
                                      color: Color(0xff2a2a2a),
                                    ),
                                  ),


                                ],

                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child:   Wrap(
                                    crossAxisAlignment: WrapCrossAlignment.start,
                                    runAlignment: WrapAlignment.start,
                                    alignment: WrapAlignment.start,
                                    ///子标签
                                    children: itemWidgetList),

                              ),
                              SizedBox(
                                height: 16,
                              ),
                           Container(
                             color: Color(0xfff8f8f8),
                             height: 2,
                           ),
                              SizedBox(
                                height: 16,
                              ),
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                      child: Image.network("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597232775964&di=d3fd1fe74b17fc77bcb77010fdd162a1&imgtype=0&src=http%3A%2F%2Fku.90sjimg.com%2Felement_origin_min_pic%2F00%2F96%2F26%2F8556f2fbfab5f14.jpg",
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover),
                                    ),
                                    SizedBox(width: 8),
                                    Expanded(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(company == null?"":company["name"],
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    wordSpacing: 1,
                                                    letterSpacing: 1,
                                                    fontSize: 14,
                                                    color: Colors.black)),
                                            SizedBox(height: 5),
                                            Text(compay_desc,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    wordSpacing: 1,
                                                    letterSpacing: 1,
                                                    fontSize: 12,
                                                    color: Colors.black54)),
                                          ],
                                        )),
                                    SizedBox(width: 15),
                                    Image.asset('images/ic_arrow_gray.png',
                                        width: 10, height: 10, fit: BoxFit.cover,color: Colors.black87,)
                                  ],
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CompanyDetail(0,url:company["href"])));
                                },
                              ),
                              SizedBox(
                                height: 12,
                              ),
                            ],
                          ),
                        ),
                      )
                 ,
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        height: 12,
                        width: 4,
                        color: Colours.app_main,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text('工作详情',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(37, 38, 39, 1))),
                    ],
                  ),
                      SizedBox(
                        height: 16,
                      ),
                  Html(data: jobDes.toString().replaceAll("早炯", "")),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 12,
                            width: 4,
                            color: Colours.app_main,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text('报名指引',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  wordSpacing: 1,
                                  letterSpacing: 1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(37, 38, 39, 1))),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                        Row(
                          children: <Widget>[

                             Container(
                                width: 90,
                                height: 90,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    image:DecorationImage(
                                        image:AssetImage("images/lc_tab.png"),

                                    )
                                ),
                                child: Text(
                                    "步骤一      ",
                                    style: TextStyle(
                                      color: Colours.app_main,

                                    )
                                ),
                              ),
                           SizedBox(width: 40),
                            Text(
                                "兼职报名",
                              style: TextStyle(
                                color: Colors.black87,
                                 fontSize: 16
                              ),
                            )
                          ],
                        ),

                      Row(
                        children: <Widget>[

                          Image.asset("images/lc_line.png",height: 60,),
                          SizedBox(width: 60),
                          Text(
                            "查看兼职，符合条件，点击报名",
                            style: TextStyle(
                              color: Colors.black38,
                              fontSize: 12
                            )
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            width: 90,
                            height: 90,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image:DecorationImage(
                                      image:AssetImage("images/lc_tab.png")
                                  )
                              ),
                              child: Text(
                                  "步骤二      ",
                                  style: TextStyle(
                                    color: Colours.app_main,

                                  )
                              ),
                            ),
                          SizedBox(width: 40),
                          Text(
                            "添加企业           ",
                            style: TextStyle(
                              color: Colors.black87,

                            ),
                          )
                        ],
                      ),

                      Row(
                        children: <Widget>[
                        Image.asset("images/lc_line.png",height: 60,),
                          SizedBox(width: 60),
                          Text(
                              "添加页面的企业微信号，核实企业身份！",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12
                              )
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                              width: 90,
                              height: 90,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image:DecorationImage(
                                      image:AssetImage("images/lc_tab.png")
                                  )
                              ),
                              child: Text(
                                  "步骤三      ",
                                  style: TextStyle(
                                    color: Colours.app_main,

                                  )
                              ),
                            ),
                          SizedBox(width: 40),
                          Text(
                            "工作签约           ",
                            style: TextStyle(
                              color: Colors.black87,

                            ),
                          )
                        ],
                      ),

                      Row(
                        children: <Widget>[
                         Image.asset("images/lc_line.png",height: 60,),
                          SizedBox(width: 60),
                          Text(
                              "双方沟通，完成签约，正式上班",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12
                              )
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[

                          Container(
                              width: 90,
                              height: 90,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image:DecorationImage(
                                      image:AssetImage("images/lc_tab.png")
                                  )
                              ),
                              child: Text(
                                  "步骤四      ",
                                  style: TextStyle(
                                    color: Colours.app_main,

                                  )
                              ),
                            ),
                          SizedBox(width: 40),
                          Text(
                            "兼职完成           ",
                            style: TextStyle(
                              color: Colors.black87,

                            ),
                          )
                        ],
                      ),

                      Row(
                        children: <Widget>[

                           Image.asset("images/lc_line.png",height: 60,color: Colors.white,),
                          SizedBox(width: 60),
                          Text(
                              "无合同违规，等待薪资发放",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12
                              )
                          )
                        ],
                      ),


                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: <Widget>[
                          Container(
                            height: 12,
                            width: 4,
                            color: Colours.app_main,
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Text('为你推荐',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  wordSpacing: 1,
                                  letterSpacing: 1,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromRGBO(37, 38, 39, 1))),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ListView.builder(itemBuilder: (context, index) {
                        if (datalist.length >0 && index < datalist.length) {
                          return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: JobDetailItem(
                                  job: datalist[index],
                                  index: index,
                                  lastItem: index == datalist.length - 1),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => JobDetail(0,url:datalist[index]["href"]),
                                    ));
                              });
                        }
                        return null;
                      },
                        itemCount: datalist.length,
                        shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics()
                      )
                    ],
                  ),
                ),
              ),
            ),
            SafeArea(
              top: false,
              child: Container(
                  child:Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      GestureDetector(
                        onTap: (){
                          if(!ShareHelper.isLogin()){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginPdPage()));
                            return;
                          }
                          if(isSvae){
                            ShareHelper.deletData(widget.url,"work");
                          }else{
                            ShareHelper.saveData(SaveDatas,"work");

                          }
                          setState(() {
                            isSvae = !isSvae;
                          });
                        },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            alignment: Alignment.center,
                            width: 160,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  isSvae ?'images/save_yes.png':'images/save_no.png',
                                  width: 24,
                                  height: 24,
                                ),
                    SizedBox(
                      width: 6,
                    ),
                    Text(isSvae?"已收藏":"收藏",
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold
                    ),)
                              ],
                            ),
                          ),
                    ),
                       Expanded(
                         flex: 1,
                         child:GestureDetector(
                           behavior: HitTestBehavior.opaque,
                           onTap: () {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (context) => ChatRoom(head_icon: userImg,title: user,reply_id: "",)));
                             if(ShareHelper.isLogin()){

                               if(!isTd){
                                 ShareHelper.saveData(SaveDatas,"bm");
                                 setState(() {
                                   isTd = !isTd;
                                 });
                               }


                               Navigator.push(context,
                                   MaterialPageRoute(builder: (context) => BmResult(jobInfo)));
                             }else{
                               Navigator.push(context,
                                   MaterialPageRoute(builder: (context) => LoginPdPage()));
                             }

                           },
                           child: Container(
                             alignment: Alignment.center,
                             height: 50,
                             color: Colours.app_main,


                               child:Text(isTd?"已报名":"立即报名",
                                 style: TextStyle(
                                     color: Colors.white,
                                     fontWeight: FontWeight.bold
                                 ),

                               ),

                           )
                         )
                       )


    ],

    ) ),
            ),
          ],
        ));
  }
}
class JobDetailItem extends StatelessWidget {
  final Map<String,dynamic> job;
  final int index;
  final bool lastItem;

  List tags;
  JobDetailItem({Key key, this.job, this.index, this.lastItem})
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
          backgroundColor: Colors.white,
          margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
          padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
          borderRadius: 2,
          borderColor:  Colors.black54,
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

//              Container(
//                height: 28,
//                width: 80,
//                decoration: BoxDecoration(
//                    color: Colours.app_main,
//                    borderRadius: BorderRadius.circular(2)
//                ),
//                child: Text(
//                  "报名",
//                  style: TextStyle(
//                      color: Colors.white,
//                      fontSize: 12
//                  ),
//                ),
//                alignment: Alignment.center,
//              )
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
