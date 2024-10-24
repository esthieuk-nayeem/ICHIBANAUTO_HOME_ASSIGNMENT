import 'dart:async';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:car_workshop_app/core/common/widgets/loading_indicator.dart';
import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:car_workshop_app/features/auth/data/auth_provider.dart';
import 'package:car_workshop_app/features/auth/models/loggedUserModel.dart';
import 'package:car_workshop_app/features/auth/presentation/pages/login_page.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/admin_dashboard.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/mechanic_dashboard.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/user_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  final AuthProvider authProvider = AuthProvider();
  final AppStorage storage = AppStorage();
  RxBool isObscurePassword = false.obs;
  RxBool isObscureReTypePassword = false.obs;

  void togglePasswordVisibility(String type) {
    if (type == 'password') {
      isObscurePassword.value = !isObscurePassword.value;
    } else {
      isObscureReTypePassword.value = !isObscureReTypePassword.value;
    }
  }

  Future<void> login(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const MinimalLoadingIndicator();
      },
    );
    try {
      final response = await authProvider.login(
          loginEmailController.text, loginPasswordController.text);

      if (response['status'] != 200) {
        Get.back();
        final errorMessage = response['data'];
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Login Failed!',
            message: '$errorMessage',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        return;
      }

      LoggedUser loginResponse = LoggedUser.fromJson(response['data']);
      await storage.storeUserData(loginResponse);

      Timer(Duration(seconds: 1), () {
        Get.back();
        if (storage.token.val.isNotEmpty) {
          if (storage.userGroup.val == "admin") {
            Get.offAll(AdminDashboardPage());
          } else if (storage.userGroup.val == "mechanic") {
            Get.offAll(MechanicDashboardPage());
          } else if (storage.userGroup.val == "user") {
            Get.offAll(UserDashboardPage());
          }
        } else {
          Get.offAll(LoginScreen());
        }
      });
    } catch (error) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Login Failed',
          message: '$error!',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      print('Error occurred during login: $error');
    }
  }

  Future<void> register(BuildContext context) async {
    try {
      final response = await authProvider.register(
        nameController.text,
        emailController.text,
        phoneController.text,
        passController.text,
      );

      if (response['status'] != 201) {
        final errorMessage = response['data'];
        final snackBar = SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: AwesomeSnackbarContent(
            title: 'Registration Failed!',
            message: '$errorMessage',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
        return;
      }
      Get.offAll(LoginScreen());
    } catch (error) {
      final snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        content: AwesomeSnackbarContent(
          title: 'Registration Failed',
          message: '$error!',
          contentType: ContentType.failure,
        ),
      );
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
      print('Error occurred during registration: $error');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
