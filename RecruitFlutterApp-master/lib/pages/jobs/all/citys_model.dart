class CitysModel {
  String name;
  String currentCity;
  List<String> citys;
  List<String> historyCitys;
  List<String> allCitys;

  CitysModel({this.name,this.currentCity,this.citys,this.historyCitys,this.allCitys}):super();

  CitysModel.fromJson(Map data) {
    name = data["name"];
    List citylist = data["citys"];
    if (citylist != null && citylist.length > 0) {
      citys = [];
      citylist.forEach((city) {
        citys.add(city);
      });
    }
  }
}