import 'dart:async';
import 'package:car_workshop_app/core/common/widgets/loader.dart';
import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:car_workshop_app/features/auth/presentation/pages/login_page.dart';
import 'package:car_workshop_app/features/auth/presentation/pages/onboard_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  @override
  void initState() {
    super.initState();

    AppStorage storage = AppStorage();

    Timer(const Duration(seconds: 3), () {
      if (storage.token.val.isNotEmpty) {
        // logic for going to home
      } else {
        if (storage.onboardViewed.val == false) {
          // go onboard  onBoardingRoute
          Get.to(OnBoardPage());
        } else {
          // go login
          Get.offAll(LoginScreen());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Loader(context: context);
  }
}
