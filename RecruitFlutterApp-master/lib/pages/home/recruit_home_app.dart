import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:imei_plugin/imei_plugin.dart';
import 'package:provider/provider.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/identity_model.dart';
import 'package:recruit_app/pages/JxPageTab.dart';
import 'package:recruit_app/pages/boss/boss.dart';
import 'package:recruit_app/pages/companys/company_jobslist.dart';
import 'package:recruit_app/pages/companys/company_list.dart';
import 'package:recruit_app/pages/employe/employe_list.dart';
import 'package:recruit_app/pages/home/home_page.dart';
import 'package:recruit_app/pages/jobs/job_list.dart';
import 'package:recruit_app/pages/mine/me.dart';
import 'package:recruit_app/pages/mine/me_jz.dart';
import 'package:recruit_app/pages/msg/agreement_detail.dart';
import 'package:recruit_app/pages/msg/msg_list.dart';
import 'package:recruit_app/pages/msg/new_msglist.dart';
import 'package:recruit_app/pages/service/mivice_repository.dart';
import 'package:recruit_app/pages/storage_manager.dart';

class RecruitHomeApp extends StatefulWidget {
  @override
  _RecruitHomeState createState() {
    // TODO: implement createState
    return _RecruitHomeState();
  }
}

class _RecruitHomeState extends State<RecruitHomeApp> {
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> _bossWidget = <Widget>[
    HomePage(),
    JXPageTab(),
    MeJz(),
  ];



  static List<BottomNavigationBarItem> _bossBottoms = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/btab1.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/btab1on.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      title: Text('找兼职'),
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/b_tab2.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/b_tab2on.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      title: Text('精选'),
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/b_tab3.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/b_tab3on.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      title: Text('我的'),
    ),
  ];

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    CompanyJobList(),
    NewMessageList(),
    MeJz(),
  ];

  static List<BottomNavigationBarItem> _widgetBottoms =
  <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/ic_nav_tab_jobs_unselect.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/ic_nav_tab_jobs_select.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      title: Text('职位'),
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/ic_nav_tab_coms_unselect.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/ic_nav_tab_coms_select.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      title: Text('公司'),
    ),
    BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/ic_nav_tab_msg_unselect.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/ic_nav_tab_msg_select.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      title: Text('消息'),
    ),

    BottomNavigationBarItem(
      icon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/ic_nav_tab_my_unselect.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      activeIcon: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Image.asset(
          'images/ic_nav_tab_my_select.png',
          width: 24,
          height: 24,
          fit: BoxFit.contain,
        ),
      ),
      title: Text('我的'),
    ),
  ];

//  void _onItemTapped(int index) {
//    setState(() {
//      _selectedIndex = index;
//    });
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<IdentityModel>(builder: (context, model, child) {
        return _bossWidget.elementAt(model.selectedIndex);
      }),
      bottomNavigationBar: Consumer<IdentityModel>(
        builder: (context, model, child) {
          return BottomNavigationBar(
            items: _bossBottoms,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color.fromRGBO(255, 255, 255, 1),
            currentIndex: model.selectedIndex,
            unselectedItemColor: Color.fromRGBO(67, 67, 67, 1),
            selectedItemColor: Color.fromRGBO(52, 52, 52, 1),
            selectedFontSize: 13,
            unselectedFontSize: 12,
            onTap: (index) {
              model.changeSelectTap(index);
            },
          );
        },
      ),
    );
  }


  TapGestureRecognizer _tapGestureRecognizer1;
  TapGestureRecognizer _tapGestureRecognizer2;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tapGestureRecognizer1 = TapGestureRecognizer();
    _tapGestureRecognizer2 = TapGestureRecognizer();

    _tapGestureRecognizer1.onTap=(){

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AgreementDetailPage(0),
          ));
    };

    _tapGestureRecognizer2.onTap=(){

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AgreementDetailPage(1),
          ));
    };


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {


      if(StorageManager.sharedPreferences != null &&StorageManager.sharedPreferences.getBool("is_sagree") !=null &&StorageManager.sharedPreferences.getBool("is_sagree")){


      }else{
        _showProtocolDialog(context);
      }

    });
    initPlatformState();
  }
  Future<void> initPlatformState() async {


    try {
      String uuid = await ImeiPlugin.getId();

            MiviceRepository().postTencentData("START_APP", uuid);
    } on PlatformException {

    }

  }

  void _showProtocolDialog(BuildContext context) async{

    await showDialog(context: context,barrierDismissible:false,builder: (BuildContext context){

      return CupertinoAlertDialog(

        title: Text("用户隐私及协议同意?",style: TextStyle(color: Colours.black_1e211c,fontSize: 17,fontWeight: FontWeight.bold),),
        content:Padding(
          padding:EdgeInsets.only(top: 20),
          child: Text.rich(

            TextSpan(
                children: [
                  TextSpan(

                    text: "欢迎使用APP。在使用本APP前，请细阅所有条款及细则",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colours.gray_8A8F8A
                    ),
                  ),
                  TextSpan(
                    text:  "用户协议",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colours.app_main,
                      decoration:TextDecoration.underline,
                    ),
                    recognizer: _tapGestureRecognizer1, //监听器
                  ),
                  TextSpan(
                    text: "&隐私政策",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colours.app_main,
                      decoration:TextDecoration.underline,
                    ),
                    recognizer: _tapGestureRecognizer2, //监听器
                  ),
                  TextSpan(
                    text:  "只有在您同意并接受所有条款和条件后，您才能开始我们的服务。",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colours.gray_8A8F8A
                    ),
                    recognizer: _tapGestureRecognizer2,
                  )
                ]
            ),
            textAlign: TextAlign.justify,

          ),
        ),
        actions:<Widget>[

          CupertinoDialogAction(
            child: Text("不同意",style: TextStyle(color: Colours.gray_C8C7CC,fontSize: 17,fontWeight: FontWeight.bold)),
            onPressed: (){
              SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            },
          ),

          CupertinoDialogAction(
            child:  Text("同意",style: TextStyle(color: Colours.app_main,fontSize: 17,fontWeight: FontWeight.bold)),
            onPressed: (){

              Navigator.of(context).pop();
              StorageManager.sharedPreferences.setBool("is_sagree", true);
            },
          ),
        ],
      );
    });
  }

}