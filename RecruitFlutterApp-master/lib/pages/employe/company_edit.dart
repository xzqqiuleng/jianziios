import 'package:flutter/material.dart';
import 'package:recruit_app/widgets/log_reg_textfield.dart';

class CompanyEdit extends StatefulWidget {
  @override
  _CompanyEditState createState() => _CompanyEditState();
}

class _CompanyEditState extends State<CompanyEdit> {
  final _companyController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar:AppBar(

        elevation: 0,
        centerTitle: true,
        title: Text("公司信息",
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
      body:SafeArea(
        top: false,
        child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
      padding: const EdgeInsets.only(
    left: 15.0, right: 15, top: 18, bottom: 18),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        SizedBox(height: 30),
        Text("请完成公司实名认证！",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),),
        SizedBox(height: 30),
        Text(
          '* 公司名称',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontSize: 14,
            color:Colors.black38,
          ),
        ),
        SizedBox(height: 10),
        LogRegTextField(

          label: "请填写营业执照上的公司名称",
          controller:  _companyController,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.phone,
          obscureText: false,

        ),
        SizedBox(height: 20),
        Text(
          '* 城市',
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

            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child:   Text("选择",
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
        SizedBox(height: 10),
        Text(
          '* 公司地址',
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

            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child:   Text("请填写详细地址",
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
        LogRegTextField(

          label: "统一信用代码",
          controller:  _companyController,
          textInputAction: TextInputAction.next,
          textInputType: TextInputType.phone,
          obscureText: false,

        ),
      ],

    )

      ),
    )
    );
  }
}
