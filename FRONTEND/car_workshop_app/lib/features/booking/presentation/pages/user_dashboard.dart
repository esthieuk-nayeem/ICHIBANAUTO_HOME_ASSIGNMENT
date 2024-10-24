import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:car_workshop_app/features/booking/presentation/components/bottom_nav_bar.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/car_details_form_page.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserDashboardPage extends StatefulWidget {
  const UserDashboardPage({Key? key}) : super(key: key);

  @override
  State<UserDashboardPage> createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  @override
  Widget build(BuildContext context) {
    BookingController controller = Get.put(BookingController());
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavBar(
          currentIndex: controller.currentMenuIndex.value,
          onItemSelected: (index) async {
            controller.currentMenuIndex.value = index;

            switch (index) {
              case 0:
                Get.offAll(UserDashboardPage());
                break;
              case 1:
                await controller.getBookings(context, true);
                break;
              case 2:
                await controller.getBookings(context, true);
                break;
              case 3:
                // Add routing logic for index 3
                Get.to(ProfilePage());
                break;
            }
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.blue.shade800, Colors.blue.shade600],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ichiban Auto',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Excellence in Japanese Auto Care',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            // Services Overview
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Professional Auto Services',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Service Cards
                  GridView.count(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1.5,
                    children: [
                      _buildServiceCard(
                        icon: Icons.build,
                        title: 'Maintenance',
                        color: Colors.orange,
                      ),
                      _buildServiceCard(
                        icon: Icons.car_repair,
                        title: 'Repairs',
                        color: Colors.green,
                      ),
                      _buildServiceCard(
                        icon: Icons.speed,
                        title: 'Diagnostics',
                        color: Colors.purple,
                      ),
                      _buildServiceCard(
                        icon: Icons.electric_car,
                        title: 'Upgrades',
                        color: Colors.blue,
                      ),
                    ],
                  ),

                  SizedBox(height: 30),

                  // Booking Button
                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your booking navigation logic here
                        Get.to(CarDetailsForm());
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Book an Appointment Now',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  // Why Choose Us
                  Text(
                    'Why Choose Ichiban Auto?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 15),
                  _buildFeatureRow(Icons.verified, 'Certified Mechanics'),
                  _buildFeatureRow(Icons.timer, 'Quick Service'),
                  _buildFeatureRow(Icons.star, 'Quality Parts'),
                  _buildFeatureRow(Icons.price_check, 'Competitive Pricing'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 32,
              color: color,
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.blue.shade700,
          ),
          SizedBox(width: 12),
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}
