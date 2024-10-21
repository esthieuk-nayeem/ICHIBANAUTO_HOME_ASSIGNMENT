import 'package:car_workshop_app/core/resources/color_pallete.dart';
import 'package:car_workshop_app/core/resources/strings_manager.dart';
import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:car_workshop_app/features/auth/presentation/components/gradientButton.dart';
import 'package:car_workshop_app/features/auth/presentation/components/loginField.dart';
import 'package:car_workshop_app/features/auth/presentation/components/passfield.dart';
import 'package:car_workshop_app/features/auth/presentation/pages/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.put(AuthController());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            height: height,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [AppPallete.gradient2, AppPallete.gradient1])),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  SizedBox(height: height * .08),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Image.asset(
                      //   'assets/default.png',
                      //   height: height * .1,
                      // ),
                      const Text(
                        AppStrings.companyName,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 50,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 50),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: AppStrings.email,
                    tcontroller: controller.loginEmailController,
                  ),
                  const SizedBox(height: 15),
                  PassField(
                    hintText: AppStrings.password,
                    tcontroller: controller.loginPasswordController,
                  ),
                  SizedBox(height: height * .05),
                  GradientButton(
                    text: AppStrings.login,
                    onPressed: () async {
                      await controller.login(context);
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'or',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 15),
                  GradientButton(
                    text: AppStrings.register,
                    onPressed: () {
                      Get.to(RegistrationScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
