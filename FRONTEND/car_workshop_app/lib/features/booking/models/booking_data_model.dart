class BookingDataModel {
  int? id;
  User? user;
  Mechanic? mechanic;
  String? carMake;
  String? carModel;
  int? carYear;
  String? carRegistrationPlate;
  String? bookingDescription;
  String? pickupPoint;
  String? appointmentDate;
  String? appointmentTime;
  String? status;
  String? createdAt;

  BookingDataModel(
      {this.id,
      this.user,
      this.mechanic,
      this.carMake,
      this.carModel,
      this.carYear,
      this.carRegistrationPlate,
      this.bookingDescription,
      this.pickupPoint,
      this.appointmentDate,
      this.appointmentTime,
      this.status,
      this.createdAt});

  BookingDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    mechanic = json['mechanic'] != null
        ? new Mechanic.fromJson(json['mechanic'])
        : null;
    carMake = json['car_make'];
    carModel = json['car_model'];
    carYear = json['car_year'];
    carRegistrationPlate = json['car_registration_plate'];
    bookingDescription = json['booking_description'];
    pickupPoint = json['pickup_point'];
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.mechanic != null) {
      data['mechanic'] = this.mechanic!.toJson();
    }
    data['car_make'] = this.carMake;
    data['car_model'] = this.carModel;
    data['car_year'] = this.carYear;
    data['car_registration_plate'] = this.carRegistrationPlate;
    data['booking_description'] = this.bookingDescription;
    data['pickup_point'] = this.pickupPoint;
    data['appointment_date'] = this.appointmentDate;
    data['appointment_time'] = this.appointmentTime;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    return data;
  }
}

class User {
  int? id;
  String? phone;
  String? email;
  bool? isActive;
  String? fullName;
  String? dob;
  String? gender;
  String? occupation;

  User(
      {this.id,
      this.phone,
      this.email,
      this.isActive,
      this.fullName,
      this.dob,
      this.gender,
      this.occupation});

  User.fromJson(Map<String, dynamic> json) {
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

class Mechanic {
  int? id;
  String? phone;
  String? email;
  bool? isActive;
  String? fullName;
  String? dob;
  String? gender;
  String? occupation;

  Mechanic(
      {this.id,
      this.phone,
      this.email,
      this.isActive,
      this.fullName,
      this.dob,
      this.gender,
      this.occupation});

  Mechanic.fromJson(Map<String, dynamic> json) {
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
