import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusBadge extends StatelessWidget {
  final String status;

  const StatusBadge({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'requested':
        statusColor = Colors.cyan;
        break;
      case 'new':
        statusColor = Colors.cyan;
        break;
      case 'pickup in progress':
        statusColor = Colors.blue;
        break;
      case 'repair in progress':
        statusColor = Colors.purple;
        break;
      case 'pending delivery':
        statusColor = Colors.deepOrangeAccent;
        break;
      case 'pending pickup':
        statusColor = Colors.orangeAccent;
        break;
      case 'pickup requested':
        statusColor = Colors.lightBlue;
        break;
      case 'delivered':
        statusColor = Colors.green;
        break;
      case 'canceled':
        statusColor = Colors.red;
        break;

      default:
        statusColor = Colors.grey;
        break;
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: GoogleFonts.poppins(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    );
  }
}
