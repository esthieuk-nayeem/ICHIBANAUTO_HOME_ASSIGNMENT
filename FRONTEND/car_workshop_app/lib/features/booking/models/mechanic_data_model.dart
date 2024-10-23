class MechanicDataModel {
  int? id;
  String? phone;
  String? email;
  bool? isActive;
  String? fullName;
  Null? dob;
  Null? gender;
  Null? occupation;

  MechanicDataModel(
      {this.id,
      this.phone,
      this.email,
      this.isActive,
      this.fullName,
      this.dob,
      this.gender,
      this.occupation});

  MechanicDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    email = json['email'];
    isActive = json['is_active'];
    fullName = json['full_name'];
    dob = json['dob'];
    gender = json['gender'];
    occupation = json['occupation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['is_active'] = this.isActive;
    data['full_name'] = this.fullName;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['occupation'] = this.occupation;
    return data;
  }
}
