import 'package:car_workshop_app/core/resources/color_pallete.dart';
import 'package:car_workshop_app/features/auth/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PassField extends StatefulWidget {
  final String hintText;
  final TextEditingController tcontroller;

  const PassField({
    Key? key,
    required this.hintText,
    required this.tcontroller,
  }) : super(key: key);

  @override
  _PassFieldState createState() => _PassFieldState();
}

class _PassFieldState extends State<PassField> {
  late AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: Obx(() => TextFormField(
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            obscureText: !controller.isObscurePassword.value,
            onChanged: (value) {
              controller.passController.text = value;
            },
            controller: widget.tcontroller,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  controller.togglePasswordVisibility('password');
                },
                icon: Icon(
                  controller.isObscurePassword.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
              contentPadding: const EdgeInsets.all(27),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: AppPallete.gradient2,
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              hintText: widget.hintText,
              hintStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w200),
            ),
          )),
    );
  }
}
