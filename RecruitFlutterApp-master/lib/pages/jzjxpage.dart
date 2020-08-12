import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';

import 'jobs/job_detail.dart';
import 'jobs/job_row_item.dart';
import 'blur_rect.dart';

class JZJXPage extends StatefulWidget{
  int type;
 JZJXPage(this.type);

  @override
  _JZState createState() {
    // TODO: implement createState
    return _JZState();
  }

}

class _JZState extends State<JZJXPage>{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);
  int page;
  List data =List();
 String url;
  List<String> txtS=["校内兼职推荐","线上兼职专场","兼职赚钱攻略","潮兼职，等你来"];

  String url1 ="http://www.zaojiong.com/job/?c=search&keyword=%E6%A0%A1&minsalary=&maxsalary=";
  String url2 ="http://www.zaojiong.com/job/list/985-0-0-0_0_0_0_0_0_0_0-0-0-0-1.html";
  String url3 ="http://www.zaojiong.com/job/?c=search&keyword=%E5%B8%88&keyword=%E9%92%B1&minsalary=&maxsalary=";
  String url4 ="http://www.zaojiong.com/job/?c=search&keyword=%E9%92%B1&keyword=%E6%96%B0&minsalary=&maxsalary=";
  List<String> imageZs =["images/zt1.jpg","images/zt2.png","images/zt3.png","images/zt4.jpg"];
  String head_icon;
  String text;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    switch(widget.type){
      case 0:
        url = url1;
        break;
      case 1:
        url = url2;
        break;
      case 2:
        url = url3;
        break;
      case 3:
        url = url4;
        break;
    }
    head_icon = imageZs[widget.type];
    text = txtS[widget.type];
  }
  _OnRefresh(){

    new MiviceRepository().getJzList(url).then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success"){
        data.clear();

        setState(() {
          data = reponse["result"];
        });
        print(data);

      }
      _refreshController.refreshCompleted();
    });
  }
  _loadMore(){

      _refreshController.loadComplete();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: Flex(
        direction:Axis.vertical ,
        children: <Widget>[
          Expanded(
            flex: 0,
            child: Stack(
              overflow: Overflow.clip,
              alignment: Alignment.center,
              children: <Widget>[
                // 背景图片
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                      color: Color(0xffF3F4F5),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      image: DecorationImage(
                          image: AssetImage(head_icon),
                          fit: BoxFit.cover) //设置图片的填充模式
                  ),
                  margin: EdgeInsets.only(bottom: ScreenUtil().setHeight(20)),
                ),
                // 矩形高斯模糊效果
                BlurRectWidget(
                  child: Container(height: 100,),
                  sigmaY: 5,
                  sigmaX: 5,
                ),
                Text(
                    text,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                Positioned(
                  left: 12,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back,color: Colors.black,),
                    onPressed:()=> Navigator.of(context).pop(),
                  ),
                )
              ],
            ),
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
                                builder: (context) =>JobDetail(0,url: data[index]["jobHref"]),
                              ));
                        });
                  }else{
                    return  Center(
                        child:  Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("images/empty_work.png",width: 60,height: 60,),
                            Text(
                                "暂未搜到相关数据"
                            )
                          ],
                        )
                    );
                  }

                },
                  itemCount: data.length,
                )
            ),
          )
        ],
      )
    );
  }


}