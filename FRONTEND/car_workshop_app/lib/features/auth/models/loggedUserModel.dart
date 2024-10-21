class LoggedUser {
  int? id;
  String? phone;
  String? whatsapp;
  String? email;
  bool? isActive;
  String? token;
  String? fullName;
  String? group;

  LoggedUser(
      {this.id,
      this.phone,
      this.whatsapp,
      this.email,
      this.isActive,
      this.token,
      this.fullName,
      this.group});

  LoggedUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    whatsapp = json['whatsapp'];
    email = json['email'];
    fullName = json['full_name'];
    group = json['group'];
    isActive = json['is_active'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['whatsapp'] = this.whatsapp;
    data['email'] = this.email;
    data['is_active'] = this.isActive;
    data['full_name'] = this.fullName;
    data['group'] = this.group;
    data['token'] = this.token;
    return data;
  }
}
