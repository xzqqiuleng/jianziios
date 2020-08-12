import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:recruit_app/pages/companys/company_c_item.dart';
import 'package:recruit_app/pages/jobs/job_detail.dart';





class CompanyJob extends StatefulWidget{
  List data;
  CompanyJob(this.data);

  @override
  _JobState createState() {
    // TODO: implement createState
    return _JobState();
  }

}

class _JobState extends State<CompanyJob>{
  RefreshController _refreshController =
  RefreshController(initialRefresh: true);

  _OnRefresh(){
    _refreshController.refreshCompleted();
  }
  _loadMore(){
    _refreshController.loadComplete();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text("在招职位",
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
              width: 18,
              height: 18,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromRGBO(255, 255, 255, 1),
      ),
      body: SmartRefresher(

          header: WaterDropHeader(),
          footer: ClassicFooter(),
          controller: _refreshController,
          onRefresh: _OnRefresh,
          onLoading: _loadMore,
          enablePullUp: true,
          child: ListView.builder(itemBuilder: (context, index) {
            if (widget.data.length >0 && index <widget. data.length) {
              return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: CompanyCItem(
                      job: widget.data[index],
                      index: index,
                      lastItem: index ==  widget.data.length - 1),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JobDetail( 0,url: widget.data[index]["jobHref"]),
                        ));
                  });
            }
            return null;
          },
            itemCount: widget.data.length,
          )
      )
    );
  }


}