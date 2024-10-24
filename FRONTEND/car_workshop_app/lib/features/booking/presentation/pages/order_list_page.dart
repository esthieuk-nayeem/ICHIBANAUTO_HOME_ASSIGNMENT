import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:car_workshop_app/features/booking/models/booking_data_model.dart';
import 'package:car_workshop_app/features/booking/presentation/components/bottom_nav_bar.dart';
import 'package:car_workshop_app/features/booking/presentation/components/empty_booking_state.dart';
import 'package:car_workshop_app/features/booking/presentation/components/order_card_item.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/admin_dashboard.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/booking_details_page.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/mechanic_dashboard.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/profile_page.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';

class BookingListPage extends StatefulWidget {
  final List<BookingDataModel> orders;

  BookingListPage({Key? key, required this.orders}) : super(key: key);

  @override
  _BookingListPageState createState() => _BookingListPageState();
}

class _BookingListPageState extends State<BookingListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<String> statuses = [
    'All',
    'Canceled',
    'Delivered',
    'Pending Delivery',
    'Pending Pickup',
    'Pickup In Progress',
    'Pickup Requested',
    'Repair In Progress',
    'Requested'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: statuses.length, vsync: this);
  }

  List<BookingDataModel> filterBookingsByStatus(String status) {
    if (status == 'All') {
      return widget.orders;
    } else {
      return widget.orders.where((order) => order.status == status).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    BookingController controller = Get.put(BookingController());
    AppStorage appStorage = AppStorage();

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
              'Booking List',
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
                  .schedule_outlined, // Adding a simple icon can add a modern touch
              color: Colors.black87,
              size: 24,
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.blueAccent,
          labelStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontSize: 14.0),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Colors.blueAccent,
          ),
          tabs: statuses.map((status) {
            return Tab(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.blueAccent, width: 1),
                ),
                child: Text(status),
              ),
            );
          }).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: statuses.map((status) {
          List<BookingDataModel> filteredBookings =
              filterBookingsByStatus(status);
          return filteredBookings.isNotEmpty
              ? AnimationLimiter(
                  child: ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemCount: filteredBookings.length,
                    itemBuilder: (BuildContext context, int index) {
                      BookingDataModel booking = filteredBookings[index];
                      return AnimationConfiguration.staggeredList(
                        position: index,
                        duration: const Duration(milliseconds: 375),
                        child: SlideAnimation(
                          verticalOffset: 50.0,
                          child: FadeInAnimation(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 16.0),
                              child: OrderListCard(
                                onTap: () {
                                  Get.to(BookingDetailsPage(
                                    index: index,
                                    bookingData: booking,
                                  ));
                                },
                                carName: booking.carMake.toString(),
                                orderDate: booking.appointmentDate.toString(),
                                carRegistrationPlate:
                                    booking.carRegistrationPlate.toString(),
                                status: booking.status.toString(),
                                mechanicName:
                                    booking.mechanic?.fullName?.toString() ??
                                        '',
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : EmptyBookingState(); // Display an empty state if no bookings match the status
        }).toList(),
      ),
    );
  }
}
