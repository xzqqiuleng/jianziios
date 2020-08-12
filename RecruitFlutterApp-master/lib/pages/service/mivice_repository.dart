import 'package:dio/dio.dart';
import 'package:recruit_app/pages/share_helper.dart';

import '../share_helper.dart';

class MiviceRepository{

//  static String baseUrl = 'http://116.62.45.24/crawler/';      //开发

//  static String baseUrl = 'http://192.168.1.16:8080/';      //开发
  static String baseUrl = 'http://62.60.174.78/partApi/';      //开发
  static String socketUrl = 'ws://192.168.1.14:8080/ws/msg?';      //开发

  static Dio dio;

  MiviceRepository(){
      print("初始化");


        dio = new Dio();
      dio.options.baseUrl = baseUrl;

  }
  Future getJzList(String url) async {
    var response = await dio.post<Map>('/resolve/list', data: {

      'url': url,


    });
    return response;
  }
   Future getWorkList(int page,int searchType) async {
      var response = await dio.post<Map>('/job/list', data: {

      'pageSize': 10,
      'page': page,
      'searchType': searchType,

    });
    return response;
  }
  Future getFilterList(int page,int searchType,{String address,String education,String experience,String salary,int jobType,String searchText}) async {
    var response = await dio.post<Map>('/job/filterList', data: {

      'pageSize': 10,
      'page': page,
      'searchType': searchType,
      'address': address,
      'experience': experience,
      'education': education,
      'salary': salary,
      'jobType': jobType,
      'searchText': searchText

    });
    return response;
  }
  Future getMsgWorkList(int page,int searchType) async {
    var response = await dio.post<Map>('/job/randomList', data: {

      'pageSize': 10,
      'page': page,
      'searchType': searchType,
    });
    return response;
  }
  Future getCompanyList(int page,{int searchType,String searchText}) async {
    var response = await dio.post<Map>('/company/list', data: {

      'pageSize': 10,
      'page': page,
      'searchType': searchType,
      'searchText': searchText,
    });
    return response;
  }
  Future getJobDetail(int jobId) async {
    var response = await dio.post<Map>('/job/info',queryParameters: {

      'jobId': jobId,
    });
    return response;
  }

  Future getJZDetail(String url) async {
    var response = await dio.post<Map>('/resolve/info',data: {

      'url': url,
    });
    return response;
  }
  Future getHomeBaner() async {
    var response = await dio.post<Map>('/banner/getBanners');
    return response;
  }
  Future getCompanyDetail(int jobId) async {
    var response = await dio.post<Map>('/company/info',queryParameters: {

      'comId': jobId,
    });
    return response;
  }
  Future getJzCompanyDetail(String url) async {
    var response = await dio.post<Map>('/resolve/company',data: {

      'url': url,
    });
    return response;
  }
  Future registerPd(String phone,String pwd) async {
    var response = await dio.post<Map>('/user/register',data: {

      'phone': phone,
      'password': pwd,
    });
    return response;
  }
  Future forgetPd(String phone,String pwd) async {
    var response = await dio.post<Map>('/user/forgetPassword',data: {

      'phone': phone,
      'new_password': pwd,
    });
    return response;
  }
  Future upDateInfo(String key,String info) async {
    var response = await dio.post<Map>('/user/edit',data: {
       "id":ShareHelper.getUser().id,
      key: info,
    });
    return response;
  }
  Future loginPd(String phone,String pwd) async {
    var response = await dio.post<Map>('/user/login',data: {

      'phone': phone,
      'password': pwd,

    });
    return response;
  }


  Future getFilterJlList(int page,{int searchType,String address,String education,String sex,String salary,int jobType,String searchText}) async {
    var response = await dio.post<Map>('/resume/list', data: {

      'pageSize': 10,
      'page': page,
      'searchType': searchType,  //4
      'address': address,
      'sex': sex,
      'education': education,
      'salary': salary,
      'jobType': jobType,   //3
      'searchText': searchText

    });
    return response;
  }

  Future getMessageList(String userId,int type) async {
    var response = await dio.post<Map>('/user/getMsgList', data: {

      'userId': 10,
      'type': type,
    });
    return response;
  }

  Future upDateJL(String json)async{
    var response = await dio.post<Map>('/user/getMsgList', data: {

      'userId': 10,
      'type': json,
    });
    return response;
  }
  Future getWxID()async{
    var response = await dio.post<Map>('/wx/getWxList');
    return response;
  }

  static Future upLoadPicture(String path) async{
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    var image = await MultipartFile.fromFile(
      path,
      filename: name,
    );
    FormData formData = FormData.fromMap({
      "file": image
    });
    var response = await Dio().post('http://62.60.174.78:8088/upload', data: formData);
    return response;
  }

  Future deletAuthor()async{
    var response = await dio.post<Map>('/user/del', data: {

      'id': ShareHelper.getUser().id,

    });
    return response;
  }
  Future postTencentData(String actionType,String imei) async {
    var response = await dio.get<Map>('/banner/userActionAdd', queryParameters: {
      "imei":imei,
      "actionType":actionType
    });
    return response;
  }
}
