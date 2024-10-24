import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetailsCard extends StatefulWidget {
  final VoidCallback onUpdateMechanic;
  final String label;
  final int index;

  const UserDetailsCard({
    Key? key,
    required this.onUpdateMechanic,
    required this.label,
    required this.index,
  }) : super(key: key);

  @override
  _UserDetailsCardState createState() => _UserDetailsCardState();
}

class _UserDetailsCardState extends State<UserDetailsCard> {
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
            // Mechanic Header Section
            Row(
              children: [
                Icon(Icons.engineering, color: Color(0xFF4157FF)),
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
                IconButton(
                  onPressed: widget.onUpdateMechanic,
                  icon: Icon(
                    Icons.edit,
                    color: Color(0xFF4157FF),
                    size: 20,
                  ),
                  style: IconButton.styleFrom(
                    backgroundColor: Color(0xFF4157FF).withOpacity(0.1),
                    padding: EdgeInsets.all(8),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Mechanic Name
            _buildInfoRow(
                "Name",
                controller.allBookings[widget.index].mechanic!.fullName
                    .toString()),
            const SizedBox(height: 12),

            // Email
            _buildInfoRow(
                "Email",
                controller.allBookings[widget.index].mechanic!.email
                    .toString()),
            const SizedBox(height: 12),

            // Phone
            _buildInfoRow(
                "Phone",
                controller.allBookings[widget.index].mechanic!.phone
                    .toString()),
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
