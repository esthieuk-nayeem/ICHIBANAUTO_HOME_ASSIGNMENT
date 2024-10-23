import 'package:car_workshop_app/features/booking/models/booking_data_model.dart';
import 'package:car_workshop_app/features/booking/presentation/components/booking_details_info_card.dart';
import 'package:car_workshop_app/features/booking/presentation/components/mechanic_details_card.dart';
import 'package:car_workshop_app/features/booking/presentation/components/not_assigned_card.dart';
import 'package:flutter/material.dart';

class BookingDetailsPage extends StatefulWidget {
  final BookingDataModel bookingData;
  const BookingDetailsPage({super.key, required this.bookingData});

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
              widget.bookingData.mechanic != null
                  ? UserDetailsCard(
                      label: "Assigned Mechanic",
                      mechanicName:
                          widget.bookingData.mechanic!.fullName.toString(),
                      email: widget.bookingData.mechanic!.email.toString(),
                      phone: widget.bookingData.mechanic!.phone.toString(),
                      onUpdateMechanic: () {
                        // Handle mechanic update logic here
                      },
                    )
                  : MechanicAssignmentCard(
                      onAddMechanic: () {},
                      onAssignMechanic: () {},
                    ),
              SizedBox(
                height: 8,
              ),
              UserDetailsCard(
                label: "Customer",
                mechanicName: widget.bookingData.user!.fullName.toString(),
                email: widget.bookingData.user!.email.toString(),
                phone: widget.bookingData.user!.phone.toString(),
                onUpdateMechanic: () {
                  // Handle mechanic update logic here
                },
              ),
              SizedBox(
                height: 8,
              ),
              BookingDetailsCard(
                carMake: widget.bookingData.carMake.toString(),
                carModel: widget.bookingData.carModel.toString(),
                carYear: widget.bookingData.carYear!,
                carRegistrationPlate:
                    widget.bookingData.carRegistrationPlate.toString(),
                bookingDescription:
                    widget.bookingData.bookingDescription.toString(),
                pickupPoint: widget.bookingData.pickupPoint.toString(),
                appointmentDate: widget.bookingData.appointmentDate.toString(),
                appointmentTime: widget.bookingData.appointmentTime.toString(),
                status: widget.bookingData.status.toString(),
                createdAt: widget.bookingData.createdAt.toString(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
