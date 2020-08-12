class TopicTabModel {
  String picture;
  String link;
  String img;
  String txt;
  TopicTabModel({this.picture,this.link,this.img,this.txt});
  TopicTabModel.fromJson(Map data) {
    picture = data['pic'];
    link = data['link'];
  }
}