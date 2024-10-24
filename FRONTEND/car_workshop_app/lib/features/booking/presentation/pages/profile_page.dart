import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:car_workshop_app/features/auth/presentation/pages/login_page.dart';
import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:car_workshop_app/features/booking/presentation/components/bottom_nav_bar.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/admin_dashboard.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/mechanic_dashboard.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppStorage appStorage = AppStorage();
    BookingController controller = Get.put(BookingController());
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0, // No shadow for a flat, minimal look
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Profile',
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
                  .person_outline, // Adding a simple icon can add a modern touch
              color: Colors.black87,
              size: 24,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Profile Image and Name Section
            Center(
              child: Column(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    appStorage.userFullName.val,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    appStorage.userEmail.val,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Profile Info Section
            _buildInfoSection(
              title: 'Personal Information',
              children: [
                _buildInfoTile(
                  icon: Icons.phone,
                  title: 'Phone',
                  subtitle: '+1 234 567 890',
                ),
                _buildInfoTile(
                  icon: Icons.location_on,
                  title: 'Address',
                  subtitle: '123 Street, City, Country',
                ),
                _buildInfoTile(
                  icon: Icons.calendar_today,
                  title: 'Date of Birth',
                  subtitle: 'January 1, 1990',
                ),
              ],
            ),

            const SizedBox(height: 24),

            _buildInfoSection(
              title: 'App Settings',
              children: [
                _buildInfoTile(
                  icon: Icons.notifications,
                  title: 'Notifications',
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Colors.blue,
                  ),
                ),
                _buildInfoTile(
                  icon: Icons.dark_mode,
                  title: 'Dark Mode',
                  trailing: Switch(
                    value: false,
                    onChanged: (value) {},
                    activeColor: Colors.blue,
                  ),
                ),
              ],
            ),

            // Spacer to push logout button to bottom
            const SizedBox(height: 48),

            // Logout Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () {
                  // Add logout logic here

                  appStorage.instance.remove('token');
                  appStorage.instance.remove('userFullName');
                  appStorage.instance.remove('userEmail');
                  appStorage.instance.remove('userGroup');

                  Get.offAll(LoginScreen());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red[400],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.grey.withOpacity(0.2),
            ),
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 24,
            color: Colors.grey[600],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }
}
