import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserDetailsCard extends StatelessWidget {
  final String mechanicName;
  final String email;
  final String phone;
  final VoidCallback onUpdateMechanic;
  final String label;

  const UserDetailsCard({
    Key? key,
    required this.mechanicName,
    required this.email,
    required this.phone,
    required this.onUpdateMechanic,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4157FF),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onUpdateMechanic,
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
            _buildInfoRow("Name", mechanicName),
            const SizedBox(height: 12),

            // Email
            _buildInfoRow("Email", email),
            const SizedBox(height: 12),

            // Phone
            _buildInfoRow("Phone", phone),
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
