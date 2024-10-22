import 'package:car_workshop_app/features/booking/presentation/components/booking_details_info_card.dart';
import 'package:car_workshop_app/features/booking/presentation/components/mechanic_details_card.dart';
import 'package:flutter/material.dart';

class BookingDetailsPage extends StatefulWidget {
  const BookingDetailsPage({super.key});

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              UserDetailsCard(
                label: "Assigned Mechanic",
                mechanicName: "John Smith",
                email: "john.smith@example.com",
                phone: "+1 234 567 8900",
                onUpdateMechanic: () {
                  // Handle mechanic update logic here
                },
              ),
              SizedBox(
                height: 8,
              ),
              UserDetailsCard(
                label: "Customer",
                mechanicName: "John Smith",
                email: "john.smith@example.com",
                phone: "+1 234 567 8900",
                onUpdateMechanic: () {
                  // Handle mechanic update logic here
                },
              ),
              SizedBox(
                height: 8,
              ),
              BookingDetailsCard(
                carMake: "Toyota",
                carModel: "Camry",
                carYear: 2022,
                carRegistrationPlate: "ABC 123",
                bookingDescription: "Regular maintenance and oil change",
                pickupPoint: "123 Main Street, City",
                appointmentDate: "24 Oct 2024",
                appointmentTime: "10:30 AM",
                status: "Scheduled",
                createdAt: "23 Oct 2024, 15:45",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
