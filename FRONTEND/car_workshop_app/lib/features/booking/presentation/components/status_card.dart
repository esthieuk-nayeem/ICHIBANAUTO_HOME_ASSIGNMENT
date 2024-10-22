import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StatusCard extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color labelColor;

  const StatusCard({
    Key? key,
    required this.text,
    this.textColor = const Color(0xFFFFFFFF),
    this.labelColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Color statusColor;
    switch (text.toLowerCase()) {
      case 'requested':
        statusColor = Colors.cyan;
        break;
      case 'new':
        statusColor = Colors.cyan;
        break;
      case 'pickup in progress':
        statusColor = Colors.blue;
        break;
      case 'in progress':
        statusColor = Colors.purple;
        break;
      case 'pending delivery':
        statusColor = Colors.deepOrangeAccent;
        break;
      case 'pending pickup':
        statusColor = Colors.orangeAccent;
        break;
      case 'delivery in progress':
        statusColor = Colors.lightBlue;
        break;
      case 'delivered':
        statusColor = Colors.green;
        break;
      case 'cancelled':
        statusColor = Colors.red;
        break;

      default:
        statusColor = Colors.grey;
        break;
    }
    return Container(
        height: 28,
        width: width * .28,
        decoration: BoxDecoration(
            color: statusColor, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: Text(text.toLowerCase() == "requested" ? "New" : text,
              style: GoogleFonts.poppins(
                  color: textColor, fontSize: 10, fontWeight: FontWeight.w400)),
        ));
  }
}
