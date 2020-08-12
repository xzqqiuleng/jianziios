import 'package:flutter/material.dart';
import 'package:recruit_app/model/banner_model.dart';
import 'package:recruit_app/model/topictab_model.dart';
import 'package:recruit_app/pages/JobPage.dart';
import 'package:recruit_app/pages/jobs/all/job_libsboard.dart';
import 'package:recruit_app/pages/jobs/all/joball_page.dart';
import 'package:recruit_app/pages/jobs/all/jobbz_page.dart';
import 'package:recruit_app/pages/jobs/all/jobji_page.dart';
import 'package:recruit_app/pages/jobs/job_company_search.dart';
import 'package:recruit_app/pages/jobs/job_loc_select.dart';
import 'package:recruit_app/pages/jz_title_page.dart';
import 'package:recruit_app/pages/utils/resource.dart';
import 'package:recruit_app/pages/utils/screen.dart';


import 'home_banner.dart';


class HomeHeadPlan extends StatelessWidget {
  final List<BannerModel> bannerDatas;
  final List<TopicTabModel> topicTabMenus;


  final double height;
  final double bannerHeight;
  double navAplpha = 0.0;

   Function toCity;
  String mcity;
  HomeHeadPlan({Key key,this.bannerDatas,this.bannerHeight,this.topicTabMenus,this.height,this.navAplpha,this.toCity,this.mcity}):super(key:key);



  Widget _buildMiddelBar(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: topicTabMenus.map((model){

          return  Expanded(
              flex: 1,
              child:GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap:(){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => JZTitlePage(model.link)));


                },
                child:
                Container(
                  margin: EdgeInsets.fromLTRB(14, 0, 14, 0),
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(model.picture),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 16,
                            top:20,
                            child: Text(
                              model.link,
                               style: TextStyle(
                                 fontSize: 16,
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold,

                               ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            bottom:20,
                            child: Text(
                              model.txt,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.white.withOpacity(0.7),


                              ),
                            ),
                          ),
                          Positioned(
                            right: 6,
                            bottom:6,
                            child: Image.asset(model.img,height: 30,width: 30,),
                          ),
                        ],
                  ),
                ),
        )
        );
        }).toList(),
    );
  }



  @override
  Widget build(BuildContext context) {
    return new Container(
      width: Screen.width,
      height: height,
      color: Color.fromARGB(255, 242, 242, 245),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: bannerHeight,
            color: Colors.white,
            child: Stack(
              children: <Widget>[
                new HomeBanner(bannerModels: bannerDatas,height: bannerHeight-40,placeholder:  globalPlaceHolderImage),
            navAplpha == 1?  Text(""):Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 50,
                  child: Card(
                    elevation: 0.8,
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 4),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: toCity,
                          behavior: HitTestBehavior.opaque,
                          child: Row(
                            children: <Widget>[
                              SizedBox(
                                width: 16,
                              ),
                              Text(
                                mcity
                              ),
                              SizedBox(
                                width:2,
                              ),
                              Image.asset("images/arrow_h.png",width: 12,height: 20,),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                    Container(
                      height: 20,
                      width: 1,
                      color: Color(0xfff8f8f8),
                    ),
//            images/icon_home_search_20x20_@3x.png
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: ()=>  Navigator.push(context,MaterialPageRoute(builder: (context)=>JobCompanySearch(searchType: SearchType.job,))),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              SizedBox(
                                width: 12,
                              ),
                            Image.asset("images/icon_home_search_20x20_@3x.png",width: 16,height: 16,),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                  "搜索兼职，看一看",
                                style: TextStyle(
                                  color: Colors.grey
                                ),
                              ),
                              SizedBox(
                                width:4,
                              ),
                            ],
                          ),
                        )

                      ],
                    ),
                  ),
                )
              ],
            ),
          ),


          new Container(
            alignment: Alignment.center,
            margin: new EdgeInsets.only(top: 0.0),
            padding: new EdgeInsets.only(left: 0.0,right: 0.0,bottom: 0,top: 20),
            width: Screen.width,
            height: 100,
            color: Colors.white,
            child: _buildMiddelBar(context),
          ),

        ],
      ),
    );
  }
}