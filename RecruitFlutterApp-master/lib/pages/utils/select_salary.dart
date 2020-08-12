import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/pages/event_heper.dart';
import 'package:recruit_app/pages/jobs/all/citys_model.dart';
import 'package:recruit_app/pages/share_helper.dart';
import 'package:recruit_app/pages/utils/screen.dart';

class SelectSalary extends StatefulWidget {
  @override
  _SelectSalaryState createState() => _SelectSalaryState();
}

class _SelectSalaryState extends State<SelectSalary> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text('选择薪资',
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
              width: 24,
              height: 24,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body:  _buildCitysItem(salarys)
    );
  }
  List <String>salarys=["全部","2000以下","2000-4000","4000-6000","6000-8000","8000-10000","10000以上",];
  Widget _buildCitysItem(List<String> citys) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 15.0,
      crossAxisSpacing: 15.0,
      childAspectRatio: 5 / 2.5,
      children: citys.map((cityName) {
        return new InkWell(
          onTap: () {
            switch(cityName){
              case "全部":
                eventBus.fire(JobRefreshEvent("0",1));
              Navigator.of(context).pop();
                break;
              case "2000以下":

                eventBus.fire(JobRefreshEvent("2000-0",1));
                Navigator.of(context).pop();
                break;
              case "2000-4000":

                eventBus.fire(JobRefreshEvent("2000_4000",1));
                Navigator.of(context).pop();
                break;
              case "4000-6000":

                eventBus.fire(JobRefreshEvent("4000_6000",1));
                Navigator.of(context).pop();
                break;
              case "6000-8000":
                eventBus.fire(JobRefreshEvent("6000_8000",1));
                Navigator.of(context).pop();
                break;

              case "8000-10000":

                eventBus.fire(JobRefreshEvent("8000_10000",1));
                Navigator.of(context).pop();
                break;
              case "10000以上":

                eventBus.fire(JobRefreshEvent("10000",1));
                Navigator.of(context).pop();
                break;
            }

          },
          child: new Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2),
                color:  Colors.transparent,
                border: Border.all(width: 1.0,
                    color:  new Color.fromARGB(255, 242, 242, 245))
            ),
            child: new Center(
              child: new Text(cityName, softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: new TextStyle(
                    color: Colors.black87
                ),),
            ),
          ),
        );
      }).toList(),
    );
  }
}

