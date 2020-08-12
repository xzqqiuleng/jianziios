import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recruit_app/colours.dart';
import 'package:recruit_app/model/employe_list.dart';
import 'package:recruit_app/pages/employe/employ_libsboard.dart';
import 'package:recruit_app/pages/employe/employe_row_item.dart';
import 'package:recruit_app/pages/employe/employee_detail.dart';
import 'package:recruit_app/pages/home/search_bar.dart';
import 'package:recruit_app/pages/jobs/job_company_search.dart';

class EmployeeList extends StatefulWidget {
  @override
  _EmployeeListState createState() {
    // TODO: implement createState
    return _EmployeeListState();
  }
}

class _EmployeeListState extends State<EmployeeList> {
  List<Employee> _employeeList = EmployeeData.loadEmployees();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar (
         elevation: 0,
        title: Text("人才库",style: TextStyle(
          color: Colors.white
        ),),
        backgroundColor: Colours.app_main,

        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>JobCompanySearch(searchType: SearchType.jl)));
            },

          child: Image.asset("images/icon_home_search_20x20_@3x.png",height: 22,width: 22,
                color: Colors.white),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
      body: EmployLibsboard()
    );
  }
}
