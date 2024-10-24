import 'dart:convert';
import 'package:car_workshop_app/core/constants/api_path.dart';
import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:car_workshop_app/features/booking/models/booking_post_model.dart';
import 'package:http/http.dart' as http;

class BookingProvider {
  static AppStorage storage = AppStorage();
  final token = storage.token.val;
  // Get all service List

  Future<dynamic> getBookingData() async {
    try {
      final token = storage.token.val;
      print(token);

      final headers = {
        "Authorization": "token $token",
      };
      final response = await http.get(
        Uri.parse(ApiPath.BASE_URL + "bookings/"),
        headers: headers,
      );

      final responseData = jsonDecode(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(responseData);
        return {"data": responseData, "status": response.statusCode};
      } else {
        print('Failed to get data!!: ${response.statusCode}');
        print(responseData);
        return {"data": responseData, "status": response.statusCode};
        ;
      }
    } catch (error) {
      print("Error: $error");
      throw Exception('Error getting data !: $error');
    }
  }

  Future<dynamic> getMechanicData(String query) async {
    try {
      final token = storage.token.val;
      print(token);

      final headers = {
        "Authorization": "token $token",
      };
      final response = await http.get(
        Uri.parse(ApiPath.BASE_URL + "search/?search=" + query),
        headers: headers,
      );

      final responseData = jsonDecode(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(responseData);
        return {"data": responseData, "status": response.statusCode};
      } else {
        print('Failed to Get Mechanic data!!: ${response.statusCode}');
        print(responseData);
        return {"data": responseData, "status": response.statusCode};
        ;
      }
    } catch (error) {
      print("Error: $error");
      throw Exception('Error Geting Mechanic data !: $error');
    }
  }

  Future<dynamic> assignMechanic(String mechanicID, String bookingID) async {
    try {
      final token = storage.token.val;
      print(token);

      final body = {"id": mechanicID, "booking_id": bookingID};

      final headers = {
        "Authorization": "token $token",
      };
      final response = await http.patch(
          Uri.parse(ApiPath.BASE_URL + "assignmechanic/"),
          headers: headers,
          body: body);

      final responseData = jsonDecode(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(responseData);
        return {"data": responseData, "status": response.statusCode};
      } else {
        print('Failed to Get Mechanic data!!: ${response.statusCode}');
        print(responseData);
        return {"data": responseData, "status": response.statusCode};
        ;
      }
    } catch (error) {
      print("Error: $error");
      throw Exception('Error Geting Mechanic data !: $error');
    }
  }

  Future<dynamic> changeStatus(String status, String bookingID) async {
    try {
      final token = storage.token.val;
      print(token);

      final body = {"status": status};

      final headers = {
        "Authorization": "token $token",
      };
      final response = await http.patch(
          Uri.parse(ApiPath.BASE_URL + "bookings/" + bookingID + "/"),
          headers: headers,
          body: body);

      final responseData = jsonDecode(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(responseData);
        return {"data": responseData, "status": response.statusCode};
      } else {
        print('Failed to Update data!!: ${response.statusCode}');
        print(responseData);
        return {"data": responseData, "status": response.statusCode};
        ;
      }
    } catch (error) {
      print("Error: $error");
      throw Exception('Error Update data !: $error');
    }
  }

  Future<dynamic> postBooking(BookingPostModel booking) async {
    try {
      final token = storage.token.val;
      print(token);

      final body = booking.toJson();
      print(body);

      final headers = {
        "Authorization": "token $token",
        "Content-Type": "application/json"
      };
      final response = await http.post(
          Uri.parse(ApiPath.BASE_URL + "bookings/"),
          headers: headers,
          body: jsonEncode(body));

      final responseData = jsonDecode(response.body);
      print(response.statusCode);

      if (response.statusCode == 201) {
        print(responseData);
        return {"data": responseData, "status": response.statusCode};
      } else {
        print('Failed to post data!!: ${response.statusCode}');
        print(responseData);
        return {"data": responseData, "status": response.statusCode};
      }
    } catch (error) {
      print("Error: $error");
      throw Exception('Error posting data !: $error');
    }
  }
}
