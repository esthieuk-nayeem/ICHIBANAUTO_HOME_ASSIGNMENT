class BookingCountModel {
  int? totalBookings;
  int? newBookings;
  int? allMechanics;
  int? allCustomers;

  BookingCountModel(
      {this.totalBookings,
      this.newBookings,
      this.allMechanics,
      this.allCustomers});

  BookingCountModel.fromJson(Map<String, dynamic> json) {
    totalBookings = json['total_bookings'];
    newBookings = json['new_bookings'];
    allMechanics = json['all_mechanics'];
    allCustomers = json['all_customers'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_bookings'] = this.totalBookings;
    data['new_bookings'] = this.newBookings;
    data['all_mechanics'] = this.allMechanics;
    data['all_customers'] = this.allCustomers;
    return data;
  }
}
