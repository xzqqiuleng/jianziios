import 'dart:convert';
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
//这次基础款结帐一次，以后每次大版本更新再另算（包括新需求，新模块）。小功能的话，修bug免费。
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
//  Widget _getTip(){
//  List<Widget> tipWidget=[];
//  List<Widget> columWidget=[];
//  columWidget.add(SizedBox(height: 10));
//     if(infors != null &&infors["tip"] != "" &&infors["tip"] != "无"){
//       List<String>tips = infors["tip"].toString().split(" ");
//       columWidget.add(Text("福利待遇",
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//           style: const TextStyle(
//               wordSpacing: 1,
//               letterSpacing: 1,
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Color.fromRGBO(37, 38, 39, 1))));
//       columWidget.add(SizedBox(height: 12));
//       for (var item in tips){
//         if(item == " "||item ==""){
//           continue;
//         }
//         tipWidget.add( TextTagWidget("$item",
//           backgroundColor: Colors.white,
//           margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
//           padding: EdgeInsets.fromLTRB(8, 2, 8, 2),
//           borderRadius: 2,
//           borderColor: Color(0xFFF0F0F0),
//           textStyle: TextStyle(
//               color: Colors.black87,
//               fontSize: 14
//           ),
//         ));
//       }
//
//       columWidget.add(Wrap(children: tipWidget));
//       columWidget.add(SizedBox(height: 18));
//
//     }else{
//       columWidget.add(Container(height: 0,));
//     }
//
//  return Column(
//    mainAxisAlignment: MainAxisAlignment.start,
//    crossAxisAlignment: CrossAxisAlignment.stretch,
//    children: columWidget,
//  );
//  }
////  Widget _getContent(){
//
//   summary.forEach((key, value) {
//      if(key != "公司信息"){
//        contentWidget.add( Text(key.toString(),
//            maxLines: 1,
//            overflow: TextOverflow.ellipsis,
//            style: const TextStyle(
//                wordSpacing: 1,
//                letterSpacing: 1,
//                fontSize: 16,
//                fontWeight: FontWeight.bold,
//                color: Color.fromRGBO(37, 38, 39, 1))));
//        contentWidget.add(SizedBox(
//          height: 8,
//        ));
//        contentWidget.add(Html(data: value.toString().replaceAll("微信分享", "").replaceAll("地图", "")));
//      }
//
//   });
//   if(com_label != null && com_label.length>0){
//     compay_desc = "";
//     com_label.forEach((key, value) {
//       if(key.toString().contains("地")){
//         address = com_label[key].toString();
//       }
//       compay_desc = compay_desc+ com_label[key]+"·";
//     });
//   }
//
//   for( var item in )
//
//  }
  Widget _getLabel(){
    itemWidgetList.add(Text(""));
    labels = jobInfo["label"];
    if(labels != null && labels.length >0){


      for (var i = 0; i < labels.length; i++) {
        var str = labels[i];
        itemWidgetList.add(TextTagWidget("$str",
        backgroundColor: Color(0xFFF0F0F0),
          margin: EdgeInsets.fromLTRB(0, 0, 8, 8),
          padding: EdgeInsets.fromLTRB(4, 1, 4, 1),
          borderColor: Color(0xFFF0F0F0),
          borderRadius: 2,
          textStyle: TextStyle(
            color: Colors.black38,
          fontSize: 12
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
            IconButton(
                icon: Image.asset(
                  isSvae ?'images/save_yes.png':'images/save_no.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: () {
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

                }),
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
                       Image.asset("images/d_label1.png",width: 16,height: 16,),
                       SizedBox(
                         width: 4,
                       ),
                       Text(
                         linkMethod== null||linkMethod["online_time"]==null ?"":linkMethod["online_time"],
                         style: TextStyle(
                           color: Color(0xff515151)
                         ),
                       ),
                       SizedBox(
                         width: 16,
                       ),
                       Image.asset("images/d_label2.png",width: 16,height: 16,),
                       SizedBox(
                         width: 4,
                       ),
                       Text(
                         linkMethod== null||linkMethod["put_num"]==null  ?"":  linkMethod["put_num"],
                         style: TextStyle(
                             color: Color(0xff515151)
                         ),
                       ),
                       SizedBox(
                         width: 16,
                       ),
                       Image.asset("images/d_label3.png",width: 16,height: 16,),
                       SizedBox(
                         width: 4,
                       ),
                       Text(
                         linkMethod== null ||linkMethod["reply_rate"]==null ?"":  linkMethod["reply_rate"],
                         style: TextStyle(
                             color: Color(0xff515151)
                         ),
                       )

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

                      Container(
                        color: Color.fromRGBO(242, 242, 242, 1),
                        height: 2,
                        margin: EdgeInsets.only(top: 15, bottom: 20),
                      ),
                  Html(data: jobDes.toString().replaceAll("早炯", "")),

                      Container(
                        color: Color.fromRGBO(242, 242, 242, 1),
                        height: 2,
                        margin: EdgeInsets.only(top: 15, bottom: 20),
                      ),
                      Text('公司信息',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(37, 38, 39, 1))),
                      SizedBox(height: 16),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            ClipRRect(
                              borderRadius:
                              BorderRadius.all(Radius.circular(5)),
                              child: Image.network("http://www.zaojiong.com/data/logo/20170418/14906489056.PNG",
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
                                            color: Color.fromRGBO(37, 38, 39, 1))),
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
                                width: 10, height: 10, fit: BoxFit.cover)
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CompanyDetail(0,url:company["href"])));
                        },
                      ),
                      Container(
                        color: Color.fromRGBO(242, 242, 242, 1),
                        height: 2,
                        margin: EdgeInsets.only(top: 15, bottom: 20),
                      ),
                      Text('报名流程',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(37, 38, 39, 1))),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: <Widget>[

                             Container(
                                width: 80,
                                height: 30,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    image:DecorationImage(
                                        image:AssetImage("images/lc_tab.png")
                                    )
                                ),
                                child: Text(
                                    "流程一",
                                    style: TextStyle(
                                      color: Colors.white,

                                    )
                                ),
                              ),
                           SizedBox(width: 40),
                            Text(
                                "职位报名",
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
                            "确认工作详情之后，点击报名",
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
                              width: 80,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image:DecorationImage(
                                      image:AssetImage("images/lc_tab.png")
                                  )
                              ),
                              child: Text(
                                  "流程二",
                                  style: TextStyle(
                                    color: Colors.white,

                                  )
                              ),
                            ),
                          SizedBox(width: 40),
                          Text(
                            "联系企业           ",
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
                              "主动添加微信，核实企业联系",
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
                              width: 80,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image:DecorationImage(
                                      image:AssetImage("images/lc_tab.png")
                                  )
                              ),
                              child: Text(
                                  "流程三",
                                  style: TextStyle(
                                    color: Colors.white,

                                  )
                              ),
                            ),
                          SizedBox(width: 40),
                          Text(
                            "开始工作           ",
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
                              "双方同意工作内容，签约上班",
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
                              width: 80,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  image:DecorationImage(
                                      image:AssetImage("images/lc_tab.png")
                                  )
                              ),
                              child: Text(
                                  "流程四",
                                  style: TextStyle(
                                    color: Colors.white,

                                  )
                              ),
                            ),
                          SizedBox(width: 40),
                          Text(
                            "完成兼职           ",
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
                              "无违约，等待企业发放薪资中",
                              style: TextStyle(
                                  color: Colors.black38,
                                  fontSize: 12
                              )
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xfffff7de)
                        ),
                        child:Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
 
                          Text(
                          "如遇无效、虚假、诈骗信息，请立即举报",
                          style: TextStyle(
                              color: Color(0xffff552e),
                              fontSize: 13,
                            fontWeight: FontWeight.bold
                          )
                          ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "1.求职过程中签订劳动合同或没入职前请勿缴纳费用及押金、请勿参与刷单、彩票赌博、YY网络兼职、QT语音兼职职位等事项均为骗子,谨防诈骗！若信息不实请举报。\n2.对学历、经验、技能无任何要求，且承诺能快速赚取高薪的招聘职位，均有传销诈骗嫌疑，请提高警惕查看招聘详情。",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12
                                )
                            )
                          ],
                        ) ,
                      ),

                      SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text('相关职位',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              wordSpacing: 1,
                              letterSpacing: 1,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(37, 38, 39, 1))),
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
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: MaterialButton(
                    color: Colours.app_main,
                    onPressed: () {
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
                    textColor: Colors.white,
                    child: Text(isTd?"已报名":"立即报名"),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                  )),
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
