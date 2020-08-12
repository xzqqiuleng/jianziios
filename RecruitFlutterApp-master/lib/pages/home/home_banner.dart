import 'package:flutter/material.dart';
import 'package:recruit_app/model/banner_model.dart';
import 'package:recruit_app/pages/utils/screen.dart';
import 'package:recruit_app/pages/web_detail.dart';
import '../jobs/job_detail.dart';
import '../provider/app_update.dart';
import 'banner/banner.dart';

class HomeBanner extends StatelessWidget {
  final List<BannerModel> bannerModels;
  final double height;
  final String placeholder;
  HomeBanner({Key key,this.bannerModels,this.height,this.placeholder}) :super(key:key);

  @override
  Widget build(BuildContext context) {

    if (bannerModels == null || bannerModels.length == 0) {
      return SizedBox();
    }

    return Container(
      alignment: Alignment.center,
      height: height,
      child: new BannerWidget(
        height: height,
        autoPlay: true,
        content: bannerModels.map((model){
          return GestureDetector(
            onTap: (){
                if(model.type.toString() == "app"){
                  if(model.link.length < 3){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>JobDetail(0,url:"http://www.zaojiong.com/job/34.html")));
                  }else{
                    downloadUrlApp(context,model.link);
                  }

                }else{
                  if(model.link.length < 3){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>JobDetail(0,url:"http://www.zaojiong.com/job/34.html")));
                  }else{
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>WebPage(model.link)));
                  }

                }
            },
              behavior: HitTestBehavior.opaque,
            child: Container(
                width: Screen.width,
                margin: new EdgeInsets.symmetric(horizontal: 0.0),
                child: FadeInImage.assetNetwork(
                  placeholder: placeholder,
                  image: model.imageUrl ?? '',
                  fit: BoxFit.cover,
                )
            )
          ) ;
        }).toList(),
      )
    );
  }
}