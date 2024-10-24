import 'package:car_workshop_app/features/booking/controllers/booking_controller.dart';
import 'package:car_workshop_app/features/booking/presentation/components/quick_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuickMenuSection extends StatefulWidget {
  @override
  _QuickMenuSectionState createState() => _QuickMenuSectionState();
}

class _QuickMenuSectionState extends State<QuickMenuSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    _fadeAnimations = [
      _createFadeAnimation(0.0, 0.3),
      _createFadeAnimation(0.2, 0.5),
      _createFadeAnimation(0.4, 0.7),
    ];

    _controller.forward();
  }

  Animation<double> _createFadeAnimation(double startValue, double endValue) {
    return Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(startValue, endValue, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    BookingController controller = Get.put(BookingController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Menu',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 15),
        FadeTransition(
          opacity: _fadeAnimations[0],
          child: QuickMenuItem(
            title: 'View Bookings',
            icon: Icons.add_circle_outline,
            onTap: () async {
              controller.currentMenuIndex.value = 1;
              await controller.getBookings(context, true);
            },
          ),
        ),
        SizedBox(height: 15),
        FadeTransition(
          opacity: _fadeAnimations[1],
          child: QuickMenuItem(
            title: 'Calendar',
            icon: Icons.calendar_month_outlined,
            onTap: () async {
              controller.currentMenuIndex.value = 2;
              await controller.getBookings(context, true);
            },
          ),
        ),
        SizedBox(height: 15),
        FadeTransition(
          opacity: _fadeAnimations[2],
          child: QuickMenuItem(
            title: 'All Mechanics',
            icon: Icons.build,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

// Assuming you have already defined the QuickMenuItem widget
// If not, make sure to include its implementation