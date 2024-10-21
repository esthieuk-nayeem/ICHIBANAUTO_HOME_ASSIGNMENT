import 'package:car_workshop_app/core/resources/color_pallete.dart';
import 'package:flutter/material.dart';

class LoginField extends StatelessWidget {
  final String hintText;
  final TextEditingController tcontroller;
  const LoginField({
    Key? key,
    required this.hintText,
    required this.tcontroller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxWidth: 400,
      ),
      child: TextFormField(
        controller: tcontroller,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(27),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppPallete.borderColor,
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
            hintText: hintText,
            hintStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w200)),
      ),
    );
  }
}
