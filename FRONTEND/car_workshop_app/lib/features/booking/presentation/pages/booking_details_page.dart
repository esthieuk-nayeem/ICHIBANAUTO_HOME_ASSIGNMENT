import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:car_workshop_app/features/booking/models/booking_data_model.dart';
import 'package:car_workshop_app/features/booking/presentation/components/booking_details_info_card.dart';
import 'package:car_workshop_app/features/booking/presentation/components/customer_details_card.dart';
import 'package:car_workshop_app/features/booking/presentation/components/dialouge_add_mechanic.dart';
import 'package:car_workshop_app/features/booking/presentation/components/mechanic_details_card.dart';
import 'package:car_workshop_app/features/booking/presentation/components/not_assigned_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BookingDetailsPage extends StatefulWidget {
  final BookingDataModel bookingData;
  final int index;
  const BookingDetailsPage(
      {super.key, required this.bookingData, required this.index});

  @override
  State<BookingDetailsPage> createState() => _BookingDetailsPageState();
}

class _BookingDetailsPageState extends State<BookingDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());
    AppStorage appStorage = AppStorage();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0, // No shadow for a flat, minimal look
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black87, // Subtle color for back arrow
            size: 20, // Smaller size for minimal design
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Booking Details',
              style: TextStyle(
                color: Colors.black87, // Softer black for text
                fontSize: 22,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2, // Adds a modern feel
              ),
            ),
            SizedBox(width: 8),
            Icon(
              Icons
                  .hourglass_bottom, // Adding a simple icon can add a modern touch
              color: Colors.black87,
              size: 24,
            ),
          ],
        ),
      ),
      body: controller.allBookings.isEmpty
          ? CircularProgressIndicator()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    if (appStorage.userGroup.val == "admin")
                      Obx(
                        () => Column(
                          children: [
                            controller.allBookings[widget.index].mechanic !=
                                    null
                                ? UserDetailsCard(
                                    index: widget.index,
                                    label: "Assigned Mechanic",
                                    onUpdateMechanic: () {
                                      // Handle mechanic update logic here
                                      controller.filteredMechanics.clear();
                                      controller.queryController.clear();
                                      Get.dialog(DialogAddUser(
                                        bookingID: widget.bookingData.id!,
                                      ));
                                    },
                                  )
                                : MechanicAssignmentCard(
                                    onAddMechanic: () {},
                                    onAssignMechanic: () {
                                      controller.filteredMechanics.clear();
                                      controller.queryController.clear();
                                      Get.dialog(DialogAddUser(
                                        bookingID: widget.bookingData.id!,
                                      ));
                                    },
                                  ),
                            SizedBox(
                              height: 8,
                            ),
                            CustomerDetailsCard(
                              index: widget.index,
                              label: "Customer",
                              customerName:
                                  widget.bookingData.user!.fullName.toString(),
                              email: widget.bookingData.user!.email.toString(),
                              phone: widget.bookingData.user!.phone.toString(),
                              onUpdateCustomer: () {
                                // Handle mechanic update logic here
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
                        ),
                      ),
                    BookingDetailsCard(
                      index: widget.index,
                      carMake: widget.bookingData.carMake.toString(),
                      carModel: widget.bookingData.carModel.toString(),
                      carYear: widget.bookingData.carYear!,
                      carRegistrationPlate:
                          widget.bookingData.carRegistrationPlate.toString(),
                      bookingDescription:
                          widget.bookingData.bookingDescription.toString(),
                      pickupPoint: widget.bookingData.pickupPoint.toString(),
                      appointmentDate:
                          widget.bookingData.appointmentDate.toString(),
                      appointmentTime:
                          widget.bookingData.appointmentTime.toString(),
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
