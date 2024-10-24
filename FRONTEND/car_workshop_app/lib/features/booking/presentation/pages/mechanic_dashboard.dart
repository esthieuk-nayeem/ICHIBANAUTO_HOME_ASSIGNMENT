import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:car_workshop_app/features/booking/presentation/components/bottom_nav_bar.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MechanicDashboardPage extends StatefulWidget {
  const MechanicDashboardPage({Key? key}) : super(key: key);

  @override
  State<MechanicDashboardPage> createState() => _MechanicDashboardPageState();
}

class _MechanicDashboardPageState extends State<MechanicDashboardPage> {
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
                Get.offAll(MechanicDashboardPage());
                break;
              case 1:
                await controller.getBookings(context, true);
                break;
              case 2:
                // Add logic for other tasks
                await controller.getBookings(context, true);
                break;
              case 3:
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
            // Hero Section for Mechanic
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.green.shade800, Colors.green.shade600],
                ),
              ),
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome, Mechanic!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Your Work Assignments',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
            ),

            // Task Overview Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Assigned Tasks',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 20),

                  // Task Cards
                  // GridView.count(
                  //   shrinkWrap: true,
                  //   physics: NeverScrollableScrollPhysics(),
                  //   crossAxisCount: 2,
                  //   mainAxisSpacing: 15,
                  //   crossAxisSpacing: 15,
                  //   childAspectRatio: 1.5,
                  //   children: [
                  //     _buildTaskCard(
                  //       icon: Icons.build_circle,
                  //       title: 'Ongoing Repairs',
                  //       subtitle: '3 Pending',
                  //       color: Colors.orange,
                  //     ),
                  //     _buildTaskCard(
                  //       icon: Icons.check_circle_outline,
                  //       title: 'Completed Repairs',
                  //       subtitle: '12 Completed',
                  //       color: Colors.green,
                  //     ),
                  //     _buildTaskCard(
                  //       icon: Icons.schedule,
                  //       title: 'Scheduled Jobs',
                  //       subtitle: '2 Upcoming',
                  //       color: Colors.blue,
                  //     ),
                  //     _buildTaskCard(
                  //       icon: Icons.priority_high_outlined,
                  //       title: 'Urgent Tasks',
                  //       subtitle: '1 High Priority',
                  //       color: Colors.red,
                  //     ),
                  //   ],
                  // ),

                  SizedBox(height: 30),

                  // Tasks Button
                  Container(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: () {
                          // Navigation to task overview (e.g., to the second page or calendar page)
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 20),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[900], // Background color
                            borderRadius:
                                BorderRadius.circular(12), // Rounded corners
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.list_alt,
                                size: 24,
                                color: Colors.white, // Icon color
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  'View All Tasks in the 2nd page or in the calendar page',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white, // Text color
                                  ),
                                  textAlign:
                                      TextAlign.center, // Center the text
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),

                  SizedBox(height: 20),

                  // Mechanic Feature Section
                  Text(
                    'Why Work with Us?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 15),
                  _buildFeatureRow(Icons.verified, 'Reliable Job Assignments'),
                  _buildFeatureRow(Icons.timer, 'Timely Scheduling'),
                  _buildFeatureRow(Icons.star, 'High Customer Ratings'),
                  _buildFeatureRow(Icons.security, 'Safe Work Environment'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard({
    required IconData icon,
    required String title,
    required String subtitle,
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
            SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
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
            color: Colors.green.shade700,
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
