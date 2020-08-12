import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:recruit_app/model/banner_model.dart';
import 'package:recruit_app/model/topictab_model.dart';
import 'package:recruit_app/pages/city_page.dart';
import 'package:recruit_app/pages/home/search_bar.dart';
import 'package:recruit_app/pages/jobs/city_filter.dart';
import 'package:recruit_app/pages/select_city.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/utils/screen.dart';
import 'home_headplan.dart';
import 'home_joblist.dart';



class HomePage extends StatefulWidget {
  final double _homeTopBannerHeight = 180;
  final double _homeTopicHeight = 280;
  @override
  State<StatefulWidget> createState() {

    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  ScrollController scrollController = ScrollController();

  List<BannerModel> topBannerDatas = [];
  List<TopicTabModel> topicTabMenus = [];


  double _navAplpha = 0.0;
  double _offset = 0.0;
  bool _mainScrollable = true;
  bool _contentScrollable = true;
  bool _autoScroll = false;
  bool _isTabbarItemClick = false;
  bool _isNavgationBarHidden = false;
  bool isScrool=false;
  String  _city;
  void _rightTabItemPressed() async{
  String  rety = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SelectCity()));
  if(rety != null){
    setState(() {
      _city = rety;
    });
  }

  }

  void _leftTabItemPressed() {

    if (_isTabbarItemClick) {
      _isTabbarItemClick = false;
    }

    scrollController.animateTo(0.0,duration: new Duration(milliseconds: 300),curve: Curves.linear);
    setState(() {
      isScrool = false;
      this._mainScrollable = true;
      this._contentScrollable = false;
      this._offset = (widget._homeTopicHeight - Screen.navigationBarHeight)*0.5;
    });
    this._autoScroll =true;
  }

  void _statuTabbarItemPressed(int) {
    _isTabbarItemClick = true;

    scrollController.animateTo((widget._homeTopicHeight - Screen.navigationBarHeight)*0.5,duration: new Duration(milliseconds: 300),curve: Curves.linear);
    setState(() {
      this._mainScrollable = false;
      this._contentScrollable =true;
      this._offset = (widget._homeTopicHeight - Screen.navigationBarHeight)*0.5;
    });
    this._autoScroll = true;
  }

  void getBanner(){
    new MiviceRepository().getHomeBaner().then((value) {
      var reponse = json.decode(value.toString());
      if(reponse["status"] == "success") {
        List data = reponse["result"];
        List bannStr1 = List();
        List bannStr2 = List();
        List bannStr3 = List();

        for (var itme in data) {

          if (itme["level"].toString() == "one") {
            bannStr1.add(itme);
          } else if (itme["level"].toString() == "two") {
            bannStr2.add(itme);
          } else if (itme["level"].toString() == "three") {
            bannStr3.add(itme);
          }
        }
        if(bannStr1.length>0){
          topBannerDatas.clear();
          for(var inten in bannStr1){
            BannerModel bannerModel = BannerModel(imageUrl: inten["img_url"],link: inten["link_url"],type: inten["go_type"]);
            this.topBannerDatas.add(bannerModel);
          }
          setState(() {

          });
        }
        if(bannStr2.length>0){
          ShareHelper.saveBanner(bannStr2, "two");
        }
        if(bannStr3.length>0){
          ShareHelper.saveBanner(bannStr3, "three");
        }
      }
    });
  }
  Future<void> initPlatformState() async {

    try {
      String uuid = await ImeiPlugin.getId();

      MiviceRepository().postTencentData("PAGE_VIEW", uuid);
    } on PlatformException {

    }

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    getBanner();
    _city = ShareHelper.getCity() == ""?"全部":ShareHelper.getCity();
    _mainScrollable =true;
    _contentScrollable =false;
    // 滚动视图添加监听
    scrollController.addListener(() {
      var offset = scrollController.offset;
      if (offset < 0) {
        if (_navAplpha != 0) {
          setState(() {
            _navAplpha = 0;
          });
        }

        setState(() {
          _isNavgationBarHidden = true;
        });
      } else if (offset < widget._homeTopBannerHeight) {
        setState(() {
          _isNavgationBarHidden = false;
          _navAplpha = 1 - (widget._homeTopBannerHeight - offset) / widget._homeTopBannerHeight;
           if(_navAplpha >=0.5){
             _navAplpha = 1;
             isScrool = true;
           }
        });
      } else if (_navAplpha != 1) {
        setState(() {
          _isNavgationBarHidden = false;
          _navAplpha = 1;
        });
      }

      if (offset > (widget._homeTopicHeight - Screen.navigationBarHeight)*0.5) {
          setState(() {
            this._mainScrollable = false;
            this._contentScrollable =true;
            this._offset = (widget._homeTopicHeight - Screen.navigationBarHeight)*0.5;
          });
          scrollController.animateTo((widget._homeTopicHeight - Screen.navigationBarHeight)*0.5,duration: new Duration(milliseconds: 300),curve: Curves.linear);
        } else {

          if (this._autoScroll) {
            this._autoScroll = false;
          } else {
            if (!_isTabbarItemClick) {
              setState(() {
                this._offset = offset;
              });
            }
          }

        }

    });

    fetchData();
  }

  fetchData()  {

      setState(() {
          BannerModel bannerModel1 = BannerModel(imageUrl: "http://116.62.45.24/imgs/head/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20200716203705.jpg",link: "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3778115985,3313781102&fm=26&gp=0.jpg");
          BannerModel bannerModel2 = BannerModel(imageUrl: "http://116.62.45.24/imgs/head/%E5%BE%AE%E4%BF%A1%E5%9B%BE%E7%89%87_20200716203716.png");
        this.topBannerDatas.add(bannerModel1);
        this.topBannerDatas.add(bannerModel2);


        TopicTabModel tabModel1 = TopicTabModel(picture: "images/h_bt1.png",link: "网上兼职",img:"images/bq1.png",txt: "在家也能赚钱！" );
        TopicTabModel tabModel2 = TopicTabModel(picture: "images/h_bt2.png",link: "线下兼职",img:"images/bq2.png",txt: "高薪兼职推荐！");

        this.topicTabMenus.add(tabModel1);
        this.topicTabMenus.add(tabModel2);


      });


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }


  Widget _buildHeadPlanContent() {
    return HomeHeadPlan(bannerDatas: topBannerDatas,topicTabMenus: topicTabMenus, height: widget._homeTopicHeight,bannerHeight: widget._homeTopBannerHeight,navAplpha: _navAplpha,toCity: _rightTabItemPressed,mcity: _city,);
  }



  Widget _buildContent() {

    return CustomScrollView(
      controller: scrollController,
      shrinkWrap: true,
      primary: false,
      physics: _mainScrollable ? ScrollPhysics() : NeverScrollableScrollPhysics() ,
      slivers: <Widget>[
        new SliverToBoxAdapter(
          child: new Listener(
          onPointerUp: _scrollCancel,
          child: new Stack(
            children: <Widget>[
              Positioned(
                top: this._offset < 0 ? -this._offset : 0.0,
                child: _buildHeadPlanContent(),
              ),
              Padding(
                padding: EdgeInsets.only(top: widget._homeTopicHeight - this._offset),
                  child: HomeJobList(
                    contentScrollable: _contentScrollable,
                    tabbarItemClick: _statuTabbarItemPressed,
                     isScrool:  isScrool,
                  ),
              )
            ],
          ) ,
        ),
        ),
      ],
    );


  }

  Widget _buildNavBar() {
    return new Container(
            height: Screen.navigationBarHeight,
            child: new AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: Colors.white.withOpacity(_navAplpha),
              elevation: _navAplpha == 1 ? 0.2: 0.0,
              leading: _mainScrollable ? null: new IconButton(
                icon: Image.asset('images/arrow_down.png',
                  width: 24,
                  height: 24,
                ),
                onPressed: _leftTabItemPressed,
              ),
              titleSpacing: _mainScrollable ? 7.0 : 0.0,
              centerTitle: true,
              title: _navAplpha != 1 ? null: SearchBar('images/icon_home_search_20x20_@3x.png',height: 32,
                backgroudColor: Colors.black12,txt: "职位快速搜索",
              ),
              actions: _isNavgationBarHidden ? Text(""): <Widget>[
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: _rightTabItemPressed,
                  child: Row(
                    children: <Widget>[

                      _navAplpha != 1 ?  Text(""):
                      Image.asset('images/top_local.png',
                          width: 16,
                          height: 16,
                          color: Color.lerp(Colors.white, Colors.black87, _navAplpha)),
                      SizedBox(
                        width:4,
                      ),
                      Center(
                          child:_navAplpha != 1 ? null: Text(
                            _city,
                            style: TextStyle(
                              color: Color.lerp(Colors.white, Colors.black87, _navAplpha),
                              fontSize: 16
                            ),
                          )
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ),

                SizedBox(
                  width: 16,
                ),

              ],
              bottomOpacity: 0,
            )
          );
  }

  void _scrollCancel(detail) {

      _scrollRelease();
  }

  void _scrollRelease() {
    var offset = scrollController.offset;
    // print('offset :' + offset.toString());
    if (offset < (widget._homeTopicHeight - Screen.navigationBarHeight) * 0.25) {
      if (offset > 0) {
        scrollController.animateTo(0.0,duration: new Duration(milliseconds: 300),curve: Curves.linear);
      }
    } else {
      setState(() {
        this._mainScrollable = false;
        this._contentScrollable =true;
      });
      scrollController.animateTo((widget._homeTopicHeight - Screen.navigationBarHeight)*0.5,duration: new Duration(milliseconds: 300),curve: Curves.linear);
    }
  }
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            top: 0.0,
            child: _buildContent(),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 0.0,
            child: _buildNavBar()
          )

        ],
      ),
    );
  }
}

class Choice {
  const Choice({ this.title, this.icon, this.position});
  final String title;
  final int position;
  final IconData icon;
}