import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/pages/city_page.dart';
import 'package:recruit_app/pages/work_page.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

import 'me_desc.dart';

class MeEdu extends StatefulWidget {
  @override
  _MeEduState createState() => _MeEduState();
}

class _MeEduState extends State<MeEdu> {
  TextEditingController _phoneController = TextEditingController();
  String _schoolname="学校";
  String _schoolzy="专业";
  String _schooljl="在校经历";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _phoneController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFdFdFd),
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        title: Text("教育经历",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                wordSpacing: 1,
                letterSpacing: 1,
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(37, 38, 39, 1))),
        leading: IconButton(
            icon: Image.asset(
              'images/ic_back_arrow.png',
              width: 16,
              height: 16,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                'images/complete.png',
                width: 20,
                height: 20,
              ),
              onPressed: () {}),
        ],
      ),
      body:  SafeArea(
    top: false,
    child: SingleChildScrollView(
    physics: BouncingScrollPhysics(),

    child: Padding(
      padding: const EdgeInsets.only(
          left: 15.0, right: 15, top: 18, bottom: 18),
    child: Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: <Widget>[
      Text(
        '* 学校',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          color:Colors.black38,
        ),
      ),
      SizedBox(height: 16),
      Padding(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child:   GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async{
        var    reslut = await  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MeDesc(2),
                ));
            setState(() {
           if(reslut != null){
              _schoolname = reslut;
           }
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:   Text(_schoolname,
                    style: TextStyle(
                        wordSpacing: 1,
                        letterSpacing: 1,
                        fontSize: 16,
                        color:Colors.black87,
                        )),
              ),
              SizedBox(width: 8,),
              Image.asset(
                'images/arrow_right.png',
                width: 18,
                color: Colors.black87,
                height: 18,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        color: Color.fromRGBO(242, 243, 244, 1),
        height: 1,
      ),

      Text(
        '* 专业',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          color:Colors.black38,
        ),
      ),
      SizedBox(height: 16),
      Padding(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child:   GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async{
            var    reslut = await  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MeDesc(2),
                ));
            setState(() {
              if(reslut != null){
                _schoolzy  = reslut;
              }
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:   Text(_schoolzy,
                    style: TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 16,
                      color:Colors.black87,
                    )),
              ),
              SizedBox(width: 8,),
              Image.asset(
                'images/arrow_right.png',
                width: 18,
                color: Colors.black87,
                height: 18,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        color: Color.fromRGBO(242, 243, 244, 1),
        height: 1,
      ),
      Text(
        '* 学历',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          color:Colors.black38,
        ),
      ),
      SizedBox(height: 16),
      Padding(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child:   GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
          _showSexPop(context);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:   Text(_xl,
                    style: TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 16,
                      color:Colors.black87,
                    )),
              ),
              SizedBox(width: 8,),
              Image.asset(
                'images/arrow_right.png',
                width: 18,
                color: Colors.black87,
                height: 18,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        color: Color.fromRGBO(242, 243, 244, 1),
        height: 1,
      ),


      Text(
        '* 毕业时间',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          color:Colors.black38,
        ),
      ),
      SizedBox(height: 16),
      Padding(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child:   GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            _showDatePop(context,0);
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:   Text(datss,
                    style: TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 16,
                      color:Colors.black87,
                    )),
              ),
              SizedBox(width: 8,),
              Image.asset(
                'images/arrow_right.png',
                width: 18,
                color: Colors.black87,
                height: 18,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        color: Color.fromRGBO(242, 243, 244, 1),
        height: 1,
      ),
      Text(
        '* 在校经历',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          color:Colors.black38,
        ),
      ),
      SizedBox(height: 16),
      Padding(
        padding: EdgeInsets.only(top: 10,bottom: 10),
        child:   GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async{
            var    reslut = await  Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MeDesc(2),
                ));
            setState(() {
              if(reslut != null){
                 _schooljl= reslut;
              }
            });
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child:   Text(_schoolname,
                    style: TextStyle(
                      wordSpacing: 1,
                      letterSpacing: 1,
                      fontSize: 16,
                      color:Colors.black87,
                    )),
              ),
              SizedBox(width: 8,),
              Image.asset(
                'images/arrow_right.png',
                width: 18,
                color: Colors.black87,
                height: 18,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        color: Color.fromRGBO(242, 243, 244, 1),
        height: 1,
      ),
    ],


    )
       )
      ),
    )
    );

  }

  List _salaryList=["初中及以下","高中","中专","大专","本科","研究生","硕士","博士"];
  String _xl="";
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
                  if(mounted){
                    setState(() {

                        _xl = _salaryList[index];


                    });
                  }
                },
                children: List<Widget>.generate(_salaryList.length, (index){
                  return Center(
                    child: Text(_salaryList[index]),
                  );
                }),
              )
          );
        });
  }
  DateTime _initDate = DateTime.now();
  String  datss = "";
  void _showDatePop(BuildContext context,int type){

    showCupertinoModalPopup<void>(context: context, builder: (BuildContext cotext){

      return _buildBottonPicker(CupertinoDatePicker(
        minimumYear: _initDate.year-100,
        maximumYear: _initDate.year,
        mode: CupertinoDatePickerMode.date,
        initialDateTime: _initDate,
        onDateTimeChanged: (DateTime dataTime){
          if(mounted){
            setState(() {

                datss =     formatDate(dataTime, [yyyy,"-",mm,"-",dd]);

            });
          }
        },
      ));
    });
  }
  Widget _buildBottonPicker(Widget picker){
    return Container(
      height: 190,
      padding: EdgeInsets.only(top: 6),
      color: Colors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
            color:Colors.black87,
            fontSize: 18
        ),
        child: GestureDetector(
          child: SafeArea(
            top: false,
            child: picker,
          ),
        ),
      ),
    );
  }
}
