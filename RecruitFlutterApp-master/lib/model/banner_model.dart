
class BannerModel {
  String imageUrl;
  String link;
  String type;
  BannerModel({this.imageUrl,this.link,this.type});
  BannerModel.fromJson(Map data) {
    imageUrl = data['image_url'];
    link = data['link_url'];
  }
}