import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:car_workshop_app/features/booking/models/booking_data_model.dart';
import 'package:car_workshop_app/features/booking/presentation/components/bottom_nav_bar.dart';
import 'package:car_workshop_app/features/booking/presentation/components/quick_menu_item.dart';
import 'package:car_workshop_app/features/booking/presentation/components/quick_menu_section.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/mechanic_dashboard.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/order_list_page.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminDashboardPage extends StatefulWidget {
  @override
  _AdminDashboardPageState createState() => _AdminDashboardPageState();
}

class _AdminDashboardPageState extends State<AdminDashboardPage> {
  BookingController controller = Get.put(BookingController());
  @override
  void initState() {
    super.initState();
    controller.getBookingDataCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              SizedBox(height: 16),
              Expanded(
                flex: 45,
                child: StatsGrid(),
              ),
              SizedBox(height: 16),
              Expanded(
                flex: 55,
                child: QuickMenuSection(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavBar(
          currentIndex: controller.currentMenuIndex.value,
          onItemSelected: (index) async {
            controller.currentMenuIndex.value = index;

            switch (index) {
              case 0:
                Get.offAll(AdminDashboardPage());
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
    );
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Home',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.notifications_none),
          onPressed: () {},
        ),
      ],
    );
  }
}

class StatsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BookingController controller = Get.put(BookingController());
    return Obx(
      () => GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5, // Adjusted child aspect ratio
          children: [
            StatCard(
              title: 'Total Bookings',
              value: controller.bookingCount.value.totalBookings == null
                  ? '0'
                  : controller.bookingCount.value.totalBookings.toString(),
              icon: Icons.event_available, // Represents scheduled bookings
              color: Colors.amber,
            ),
            StatCard(
              title: 'New Bookings',
              value: controller.bookingCount.value.newBookings == null
                  ? '0'
                  : controller.bookingCount.value.newBookings.toString(),
              icon: Icons.fiber_new, // Represents new bookings
              color: Colors.red,
            ),
            StatCard(
              title: 'Mechanics',
              value: controller.bookingCount.value.allMechanics == null
                  ? '0'
                  : controller.bookingCount.value.allMechanics.toString(),
              icon: Icons.build, // Represents mechanics or repair services
              color: Colors.blue,
            ),
            StatCard(
              title: 'Customers',
              value: controller.bookingCount.value.allCustomers == null
                  ? '0'
                  : controller.bookingCount.value.allCustomers.toString(),
              icon: Icons.group, // Represents people/customers
              color: Colors.orange,
            ),
          ]),
    );
  }
}

class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const StatCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(8), // Reduced padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24), // Reduced icon size
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold), // Reduced text size
            ),
            SizedBox(height: 2),
            Text(
              title,
              style: TextStyle(fontSize: 14), // Reduced text size
            ),
          ],
        ),
      ),
    );
  }
}
