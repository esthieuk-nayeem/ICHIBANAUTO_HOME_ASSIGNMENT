import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MechanicAssignmentCard extends StatelessWidget {
  final VoidCallback onAddMechanic;
  final VoidCallback onAssignMechanic;

  const MechanicAssignmentCard({
    Key? key,
    required this.onAddMechanic,
    required this.onAssignMechanic,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFFFFFF),
        ),
        width: MediaQuery.of(context).size.width - 20,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header Section
            Row(
              children: [
                Icon(Icons.engineering, color: Color(0xFF4157FF)),
                const SizedBox(width: 10),
                Text(
                  "Mechanic Status",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4157FF),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onAddMechanic,
                  icon: Icon(
                    Icons.add,
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
            const SizedBox(height: 24),

            // No Mechanic Status
            Text(
              "No Mechanic Assigned",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 24),

            // Assign Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onAssignMechanic,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4157FF),
                  padding: EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  "Assign a Mechanic Now",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
