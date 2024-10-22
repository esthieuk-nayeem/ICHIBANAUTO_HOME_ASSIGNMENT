import 'package:car_workshop_app/features/booking/presentation/components/status_card.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderListCard extends StatelessWidget {
  final String carName;
  final String orderDate;
  final String carRegistrationPlate;
  final String status;
  final String mechanicName;
  final VoidCallback onTap;

  const OrderListCard({
    Key? key,
    required this.carName,
    required this.orderDate,
    required this.carRegistrationPlate,
    required this.status,
    required this.mechanicName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 3,
        child: Container(
          height: 91,
          width: width - 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Row(
            children: [
              SizedBox(
                width: 8,
              ),
              Container(
                width: (width - 50) * .4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      carName,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                        color: const Color(0xFF4157FF),
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      orderDate,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w400,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      carRegistrationPlate,
                      style: GoogleFonts.poppins(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              Container(
                width: (width - 50) * .4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      mechanicName,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    StatusCard(text: status),
                  ],
                ),
              ),
              SizedBox(
                width: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Usage example:
// OrderListCard(
//   carName: 'Laundry Services',
//   orderDate: '19 Oct 2023, 15:00',
//   carRegistrationPlate: '20 Oct 2023',
//   status: 'Pending',
//   mechanicName: '#ID:25031501',
// )