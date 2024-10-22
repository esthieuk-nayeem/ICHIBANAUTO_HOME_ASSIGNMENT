import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerInfoCard extends StatelessWidget {
  final String fullName;
  final String phone;
  final String email;
  final VoidCallback onPhonePressed;
  final VoidCallback onEmailPressed;

  const CustomerInfoCard({
    Key? key,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.onPhonePressed,
    required this.onEmailPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFFFFFF),
        ),
        height: 118,
        width: MediaQuery.of(context).size.width - 20,
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.person_2_outlined),
                  const SizedBox(width: 10),
                  Text(
                    fullName,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF4157FF),
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: onPhonePressed,
                    icon: const Icon(
                      Icons.phone,
                      size: 17,
                      color: Color(0xFF4157FF),
                    ),
                  ),
                  IconButton(
                    onPressed: onEmailPressed,
                    icon: const Icon(
                      Icons.email_outlined,
                      size: 17,
                      color: Color(0xFF4157FF),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Phone",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: const Color(0xFF7A7A7A),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        phone,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "E-mail",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 12,
                          color: const Color(0xFF7A7A7A),
                        ),
                      ),
                      const SizedBox(height: 7),
                      Text(
                        email,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
