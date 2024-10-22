import 'dart:convert';
import 'package:car_workshop_app/core/constants/api_path.dart';
import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:http/http.dart' as http;

class BookingProvider {
  static AppStorage storage = AppStorage();
  // Get all service List

  Future<dynamic> getBookingData() async {
    try {
      final token = storage.token.val;
      print(token);

      final headers = {
        "Authorization": "token 38d1a7012c63629151afffaf9e4ea83c3600e1ef",
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
        print('Failed to register!!: ${response.statusCode}');
        print(responseData);
        return {"data": responseData, "status": response.statusCode};
        ;
      }
    } catch (error) {
      print("Error: $error");
      throw Exception('Error registering !: $error');
    }
  }
}
