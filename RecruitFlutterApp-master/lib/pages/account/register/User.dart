class User {
  String sex;
  String phone;
  String id;
  String nick_name;
  String head_img;
  String education;
  String wxId;
  String birthday;
  String desc;
  String school;
  String work;

  User(
      {this.sex,
        this.phone,
        this.id,
        this.nick_name,
        this.head_img,
        this.education,
        this.wxId,
        this.birthday,
        this.desc,
        this.school,
        this.work});

  User.fromJson(Map<String, dynamic> json) {
    sex = json['sex'];
    phone = json['phone'];
    id = json['id'].toString();
    nick_name = json['nick_name'];
    head_img = json['head_img'];
    education = json['education'];
    wxId = json['wxId'];
    birthday = json['birthday'];
    desc = json['desc'];
    school = json['school'];
    work = json['work'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sex'] = this.sex;
    data['phone'] = this.phone;
    data['id'] = this.id;
    data['nick_name'] = this.nick_name;
    data['head_img'] = this.head_img;
    data['education'] = this.education;
    data['wxId'] = this.wxId;
    data['birthday'] = this.birthday;
    data['desc'] = this.desc;
    data['school'] = this.school;
    data['work'] = this.work;
    return data;
  }
}