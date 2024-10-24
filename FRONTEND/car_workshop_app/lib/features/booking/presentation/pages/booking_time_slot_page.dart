import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/booking_confirmation_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookingTimeSlotPage extends StatefulWidget {
  final Map<String, dynamic> carDetails;

  const BookingTimeSlotPage({
    Key? key,
    required this.carDetails,
  }) : super(key: key);

  @override
  State<BookingTimeSlotPage> createState() => _BookingTimeSlotPageState();
}

class _BookingTimeSlotPageState extends State<BookingTimeSlotPage> {
  final List<String> timeSlots = [
    '08:01am-10:00am',
    '10:01am-12:00am',
    '12:01pm-02:00pm',
    '02:01am-04:00pm',
    '04:01am-06:00pm'
  ];

  DateTime selectedDate = DateTime.now();
  String? selectedTimeSlot;
  String? pickupAddress;
  bool isEditingAddress = false;
  final TextEditingController addressController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 30)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue.shade700,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BookingController controller = Get.put(BookingController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Time Slot'),
        backgroundColor: Colors.blue.shade700,
        elevation: 0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade700, Colors.blue.shade50],
            stops: [0.0, 0.2],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pickup Address Section
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16.0, vertical: 8.0),
                    child: isEditingAddress
                        ? Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: addressController,
                                  decoration: InputDecoration(
                                    hintText: 'Enter your pickup address',
                                    border: InputBorder.none,
                                  ),
                                  autofocus: true,
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.check,
                                    color: Colors.blue.shade700),
                                onPressed: () {
                                  setState(() {
                                    pickupAddress = addressController.text;
                                    isEditingAddress = false;
                                  });
                                },
                              ),
                            ],
                          )
                        : ListTile(
                            leading: Icon(Icons.location_on,
                                color: Colors.blue.shade700),
                            title: Text(
                              pickupAddress ?? 'Add Pick-up Address (Optional)',
                              style: TextStyle(
                                color: pickupAddress != null
                                    ? Colors.black
                                    : Colors.grey,
                              ),
                            ),
                            trailing: Icon(Icons.edit, size: 20),
                            onTap: () {
                              setState(() {
                                isEditingAddress = true;
                                addressController.text = pickupAddress ?? '';
                              });
                            },
                          ),
                  ),
                ),

                SizedBox(height: 24),

                // Date Selection Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'When do you want the service?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[800],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today,
                          color: Colors.blue.shade700),
                      onPressed: () => _selectDate(context),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                // Date Selection Cards
                Container(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      final date = DateTime.now().add(Duration(days: index));
                      final isSelected = selectedDate.day == date.day &&
                          selectedDate.month == date.month;

                      return Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedDate = date;
                            });
                          },
                          child: Container(
                            width: 70,
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.blue.shade700
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? Colors.blue.shade700
                                    : Colors.grey.shade300,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('E').format(date),
                                  style: TextStyle(
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.grey[600],
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  DateFormat('d').format(date),
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 24),

                // Time Slots Section
                Text(
                  'Select Pick-up Time Slot',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                SizedBox(height: 16),

                // Time Slot Grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: timeSlots.length,
                  itemBuilder: (context, index) {
                    final timeSlot = timeSlots[index];
                    final isSelected = selectedTimeSlot == timeSlot;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedTimeSlot = timeSlot;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color:
                              isSelected ? Colors.blue.shade700 : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue.shade700
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            timeSlot,
                            style: TextStyle(
                              color:
                                  isSelected ? Colors.white : Colors.grey[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),

                SizedBox(height: 32),

                // Confirm Button
                Container(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: selectedTimeSlot != null
                        ? () async {
                            // Combine all booking details
                            final bookingDetails = {
                              ...widget.carDetails,
                              'pickupAddress': pickupAddress,
                              'bookingDate':
                                  DateFormat('yyyy-MM-dd').format(selectedDate),
                              'timeSlot': selectedTimeSlot,
                            };
                            print(bookingDetails); // For testing
                            // Process booking
                            controller.bookingPostModel.pickupPoint =
                                addressController.text.isNotEmpty
                                    ? addressController.text
                                    : 'Not Selected';
                            controller.bookingPostModel.appointmentDate =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                            controller.bookingPostModel.appointmentTime =
                                selectedTimeSlot;

                            controller.bookingPostModel.status =
                                addressController.text.isNotEmpty
                                    ? "Requested"
                                    : "Pickup Requested";

                            await controller.bookAppointment(context);

                            Get.to(BookingConfirmationPage(
                                bookingDetails: bookingDetails));
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      'Confirm Booking',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
