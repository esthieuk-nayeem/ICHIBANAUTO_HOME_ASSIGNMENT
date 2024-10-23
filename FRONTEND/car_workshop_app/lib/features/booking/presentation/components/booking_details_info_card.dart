import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingDetailsCard extends StatelessWidget {
  final String carMake;
  final String carModel;
  final int carYear;
  final String carRegistrationPlate;
  final String bookingDescription;
  final String pickupPoint;
  final String appointmentDate;
  final String appointmentTime;
  final String status;
  final String createdAt;

  const BookingDetailsCard({
    Key? key,
    required this.carMake,
    required this.carModel,
    required this.carYear,
    required this.carRegistrationPlate,
    required this.bookingDescription,
    required this.pickupPoint,
    required this.appointmentDate,
    required this.appointmentTime,
    required this.status,
    required this.createdAt,
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
            // Car Details Section
            Row(
              children: [
                Icon(Icons.directions_car_outlined, color: Color(0xFF4157FF)),
                const SizedBox(width: 10),
                Text(
                  "$carMake $carModel $carYear",
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

            Row(
              children: [
                Text(
                  "Status",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF4157FF),
                  ),
                ),
                const Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFF4157FF).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    status,
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF4157FF),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Car Registration
            _buildInfoRow("Registration", carRegistrationPlate),
            const SizedBox(height: 12),

            // Appointment Details
            _buildInfoRow("Appointment", "$appointmentDate, $appointmentTime"),
            const SizedBox(height: 12),

            // Pickup Point
            _buildInfoRow("Pickup Point", pickupPoint),
            const SizedBox(height: 12),

            // Description
            Text(
              "Description",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: const Color(0xFF7A7A7A),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              bookingDescription,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000000),
              ),
            ),
            const SizedBox(height: 12),

            // Created At
            Text(
              "Booking Created",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w400,
                fontSize: 12,
                color: const Color(0xFF7A7A7A),
              ),
            ),
            Text(
              createdAt,
              style: GoogleFonts.poppins(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000000),
              ),
            ),
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
