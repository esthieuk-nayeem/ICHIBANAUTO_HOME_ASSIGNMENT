import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:car_workshop_app/features/booking/presentation/components/bottom_nav_bar.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/admin_dashboard.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/booking_details_page.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/mechanic_dashboard.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/profile_page.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:car_workshop_app/features/booking/models/booking_data_model.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class BookingCalendarScreen extends StatefulWidget {
  final List<BookingDataModel> bookings;

  const BookingCalendarScreen({Key? key, required this.bookings})
      : super(key: key);

  @override
  _BookingCalendarScreenState createState() => _BookingCalendarScreenState();
}

class _BookingCalendarScreenState extends State<BookingCalendarScreen> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  late Map<DateTime, List<BookingDataModel>> _bookingMap;
  BookingController controller = Get.put(BookingController());
  AppStorage appStorage = AppStorage();

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _createBookingMap();
  }

  void _createBookingMap() {
    _bookingMap = {};
    for (var booking in widget.bookings) {
      if (booking.appointmentDate != null) {
        try {
          // Parse the date string from API format
          final date = DateTime.parse(booking.appointmentDate!);
          final key = DateTime(date.year, date.month, date.day);

          if (_bookingMap.containsKey(key)) {
            _bookingMap[key]!.add(booking);
          } else {
            _bookingMap[key] = [booking];
          }
        } catch (e) {
          print('Error parsing date: ${booking.appointmentDate}');
        }
      }
    }
    // Debug print to verify bookings are properly mapped
    _bookingMap.forEach((key, value) {
      print('Date: $key, Bookings: ${value.length}');
    });
  }

  List<BookingDataModel> _getBookingsForDay(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    return _bookingMap[key] ?? [];
  }

  String _formatTimeRange(String? timeString) {
    if (timeString == null) return 'Not specified';
    // Handle the time range format like "04:01am-06:00pm"
    return timeString.replaceAll('am', ' AM').replaceAll('pm', ' PM');
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'confirmed':
        return Colors.green;
      case 'requested':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      case 'completed':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavBar(
          currentIndex: controller.currentMenuIndex.value,
          onItemSelected: (index) async {
            controller.currentMenuIndex.value = index;

            switch (index) {
              case 0:
                if (appStorage.userGroup.val == "admin") {
                  Get.offAll(AdminDashboardPage());
                } else if (appStorage.userGroup.val == "mechanic") {
                  Get.offAll(MechanicDashboardPage());
                } else if (appStorage.userGroup.val == "user") {
                  Get.offAll(UserDashboardPage());
                }
                break;
              case 1:
                await controller.getBookings(context, true);
                break;
              case 2:
                await controller.getBookings(context, true);
                break;
              case 3:
                Get.to(ProfilePage());
                // Add routing logic for index 3
                break;
            }
          },
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0, // No shadow for a flat, minimal look
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Calendar',
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
                  .calendar_month_outlined, // Adding a simple icon can add a modern touch
              color: Colors.black87,
              size: 24,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2024, 1, 1),
            lastDay: DateTime.utc(2025, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                final bookings = _getBookingsForDay(date);
                if (bookings.isEmpty) return null;

                return Positioned(
                  bottom: 1,
                  right: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    width: 16,
                    height: 16,
                    child: Center(
                      child: Text(
                        bookings.length.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: _selectedDay == null
                ? const Center(
                    child: Text('Please select a day to view bookings'),
                  )
                : _buildBookingsList(_getBookingsForDay(_selectedDay!)),
          ),
        ],
      ),
    );
  }

  Widget _buildBookingsList(List<BookingDataModel> dayBookings) {
    if (dayBookings.isEmpty) {
      return const Center(
        child: Text('No bookings for selected date'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: dayBookings.length,
      itemBuilder: (context, index) {
        final booking = dayBookings[index];
        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ExpansionTile(
            title: Text(booking.user?.fullName ??
                booking.user?.email ??
                'Unknown Customer'),
            subtitle: Text(_formatTimeRange(booking.appointmentTime)),
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: _getStatusColor(booking.status).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                booking.status ?? 'Pending',
                style: TextStyle(
                  color: _getStatusColor(booking.status),
                ),
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        'Car: ${booking.carMake} ${booking.carModel} (${booking.carYear})'),
                    if (booking.carRegistrationPlate != null)
                      Text('Plate: ${booking.carRegistrationPlate}'),
                    if (booking.pickupPoint != null)
                      Text('Pickup: ${booking.pickupPoint}'),
                    if (booking.bookingDescription != null)
                      Text('Description: ${booking.bookingDescription}'),
                    const SizedBox(height: 8),
                    Text(
                        'Mechanic: ${booking.mechanic?.fullName ?? 'Not assigned'}'),
                    Text('Contact: ${booking.mechanic?.phone ?? 'N/A'}'),
                    SizedBox(
                      height: 5,
                    ),
                    TextButton(
                      onPressed: () {
                        // Add your navigation or action logic here
                        Get.to(BookingDetailsPage(
                          index: index,
                          bookingData: booking,
                        ));
                      },
                      style: TextButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        minimumSize: Size(0, 0), // Makes the button small
                        tapTargetSize: MaterialTapTargetSize
                            .shrinkWrap, // Reduces the button's tap area
                      ),
                      child: Text(
                        'View Details',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors
                              .blueAccent, // You can change the color to fit your design
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
