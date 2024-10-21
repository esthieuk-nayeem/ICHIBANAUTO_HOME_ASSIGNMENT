import 'package:car_workshop_app/core/resources/color_pallete.dart';
import 'package:car_workshop_app/core/resources/strings_manager.dart';
import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:car_workshop_app/features/auth/presentation/components/gradientButton.dart';
import 'package:car_workshop_app/features/auth/presentation/components/loginField.dart';
import 'package:car_workshop_app/features/auth/presentation/components/passfield.dart';
import 'package:car_workshop_app/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

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
                  const Text(
                    AppStrings.register,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 50,
                    ),
                  ),
                  const SizedBox(height: 50),
                  LoginField(
                    hintText: AppStrings.fullName,
                    tcontroller: controller.nameController,
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: AppStrings.email,
                    tcontroller: controller.emailController,
                  ),
                  const SizedBox(height: 15),
                  LoginField(
                    hintText: AppStrings.phone,
                    tcontroller: controller.phoneController,
                  ),
                  const SizedBox(height: 15),
                  PassField(
                    hintText: AppStrings.password,
                    tcontroller: controller.passController,
                  ),
                  SizedBox(height: height * .05),
                  GradientButton(
                    text: AppStrings.register,
                    onPressed: () async {
                      await controller.register(context);
                    },
                  ),
                  SizedBox(height: height * .05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.alreadyRegistered,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          // Navigate to login page
                          Get.offAll(LoginScreen());
                        },
                        child: Text(
                          AppStrings.login,
                          style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
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
