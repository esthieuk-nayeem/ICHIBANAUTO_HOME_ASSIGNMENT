import 'dart:convert';
import 'package:car_workshop_app/core/constants/api_path.dart';
import 'package:http/http.dart' as http;

class AuthProvider {
  // Get all service List

  Future<dynamic> login(String email, String password) async {
    var body = {"email": email, "password": password};

    try {
      final response = await http.post(
        Uri.parse(ApiPath.BASE_URL + "auth/login/"),
        body: body,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        print(responseData);
        return {"data": responseData, "status": response.statusCode};
      } else {
        print('Failed to logged in!!: ${response.statusCode}');
        print(responseData);
        return {"data": responseData, "status": response.statusCode};
      }
    } catch (error) {
      print("Error: $error");
      throw Exception('Error log in !: $error');
    }
  }

  Future<dynamic> register(
      String fullName, String email, String phone, String password) async {
    var body = {
      "full_name": fullName,
      "email": email,
      "phone": phone,
      "password": password
    };

    try {
      final response = await http.post(
        Uri.parse(ApiPath.BASE_URL + "auth/register/"),
        body: body,
      );

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 201) {
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
