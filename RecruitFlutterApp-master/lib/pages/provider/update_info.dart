/// CheckApp更新接口
class AppUpdateInfo {
  bool forbidden;
  String minVersion;
  bool mustUpdate;
  String nowVersion;
  String updateMessage;
  String updateUrl;


  bool buildHaveNewVersion = false;  //写入状态

  AppUpdateInfo(
      {this.forbidden,
        this.minVersion,
        this.mustUpdate,
        this.nowVersion,
        this.updateMessage,
        this.updateUrl});

  AppUpdateInfo.fromMap(Map<String, dynamic> json) {
    forbidden = json['forbidden'];
    minVersion = json['minVersion'];
    mustUpdate = json['mustUpdate'];
    nowVersion = json['nowVersion'];
    updateMessage = json['updateMessage'];
    updateUrl = json['updateUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['forbidden'] = this.forbidden;
    data['minVersion'] = this.minVersion;
    data['mustUpdate'] = this.mustUpdate;
    data['nowVersion'] = this.nowVersion;
    data['updateMessage'] = this.updateMessage;
    data['updateUrl'] = this.updateUrl;
    return data;
  }
}