import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:car_workshop_app/features/booking/presentation/components/status_chip.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingDetailsCard extends StatefulWidget {
  final int index;
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
    required this.index,
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
  _BookingDetailsCardState createState() => _BookingDetailsCardState();
}

class _BookingDetailsCardState extends State<BookingDetailsCard> {
  @override
  Widget build(BuildContext context) {
    final BookingController controller = Get.put(BookingController());
    AppStorage appStorage = AppStorage();
    List<String> statusList = [
      'Canceled',
      'Delivered',
      'Pending Delivery',
      'Pending Pickup',
      'Pickup In Progress',
      'Pickup Requested',
      'Repair In Progress',
      'Requested'
    ];
    return Card(
      child: Obx(
        () => Container(
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
                    controller.allBookings[widget.index].carMake.toString() +
                        " " +
                        controller.allBookings[widget.index].carModel
                            .toString() +
                        " " +
                        controller.allBookings[widget.index].carYear.toString(),
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
                  if (appStorage.userGroup.val == "user")
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Color(0xFF4157FF).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        controller.allBookings[widget.index].status.toString(),
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4157FF),
                        ),
                      ),
                    ),
                  if (appStorage.userGroup.val != "user")
                    DropdownButton(
                        isDense: true,
                        value: controller.allBookings[widget.index].status
                            .toString(),
                        items: statusList.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Center(
                              child: StatusBadge(status: status),
                            ),
                          );
                        }).toList(),
                        onChanged: (newValue) async {
                          await controller.changeBookingStatus(
                              context,
                              newValue.toString(),
                              controller.allBookings[widget.index].id
                                  .toString());
                        })
                ],
              ),

              const SizedBox(height: 12),

              // Car Registration
              _buildInfoRow(
                  "Registration",
                  controller.allBookings[widget.index].carRegistrationPlate
                      .toString()),
              const SizedBox(height: 12),

              // Appointment Details
              _buildInfoRow(
                  "Appointment",
                  controller.allBookings[widget.index].appointmentDate
                          .toString() +
                      " " +
                      controller.allBookings[widget.index].appointmentTime
                          .toString()),
              const SizedBox(height: 12),

              // Pickup Point
              _buildInfoRow("Pickup Point",
                  controller.allBookings[widget.index].pickupPoint.toString()),
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
                controller.allBookings[widget.index].bookingDescription
                    .toString(),
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
                controller.allBookings[widget.index].createdAt.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF000000),
                ),
              ),
            ],
          ),
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
