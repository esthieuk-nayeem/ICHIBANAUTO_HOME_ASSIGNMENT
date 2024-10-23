import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerDetailsCard extends StatefulWidget {
  final String customerName;
  final String email;
  final String phone;
  final VoidCallback onUpdateCustomer;
  final String label;
  final int index;

  const CustomerDetailsCard({
    Key? key,
    required this.customerName,
    required this.email,
    required this.phone,
    required this.onUpdateCustomer,
    required this.label,
    required this.index,
  }) : super(key: key);

  @override
  _CustomerDetailsCardState createState() => _CustomerDetailsCardState();
}

class _CustomerDetailsCardState extends State<CustomerDetailsCard> {
  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFFFFFF),
        ),
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Customer Header Section
            Row(
              children: [
                Icon(Icons.person, color: Color(0xFF4157FF)),
                const SizedBox(width: 10),
                Text(
                  widget.label,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4157FF),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const SizedBox(height: 16),

            // Customer Name
            _buildInfoRow("Name", widget.customerName),
            const SizedBox(height: 12),

            // Email
            _buildInfoRow("Email", widget.email),
            const SizedBox(height: 12),

            // Phone
            _buildInfoRow("Phone", widget.phone),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: const Color(0xFF7A7A7A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000000),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
