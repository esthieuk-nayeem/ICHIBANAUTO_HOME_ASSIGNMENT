class BookingPostModel {
  String? carMake;
  String? carModel;
  String? carYear;
  String? carRegistrationPlate;
  String? bookingDescription;
  String? pickupPoint;
  String? appointmentDate;
  String? appointmentTime;
  String? status;

  BookingPostModel(
      {this.carMake,
      this.carModel,
      this.carYear,
      this.carRegistrationPlate,
      this.bookingDescription,
      this.pickupPoint,
      this.appointmentDate,
      this.appointmentTime,
      this.status});

  BookingPostModel.fromJson(Map<String, dynamic> json) {
    carMake = json['car_make'];
    carModel = json['car_model'];
    carYear = json['car_year'];
    carRegistrationPlate = json['car_registration_plate'];
    bookingDescription = json['booking_description'];
    pickupPoint = json['pickup_point'];
    appointmentDate = json['appointment_date'];
    appointmentTime = json['appointment_time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_make'] = this.carMake;
    data['car_model'] = this.carModel;
    data['car_year'] = this.carYear;
    data['car_registration_plate'] = this.carRegistrationPlate;
    data['booking_description'] = this.bookingDescription;
    data['pickup_point'] = this.pickupPoint;
    data['appointment_date'] = this.appointmentDate;
    data['appointment_time'] = this.appointmentTime;
    data['status'] = this.status;
    return data;
  }
}
