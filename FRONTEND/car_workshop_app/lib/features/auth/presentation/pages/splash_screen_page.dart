import 'dart:async';
import 'package:car_workshop_app/features/booking/presentation/pages/mechanic_dashboard.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/user_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:car_workshop_app/core/utils/services/local_storage_service.dart';
import 'package:car_workshop_app/features/auth/presentation/pages/login_page.dart';
import 'package:car_workshop_app/features/auth/presentation/pages/onboard_page.dart';
import 'package:car_workshop_app/features/booking/presentation/pages/admin_dashboard.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  _SplashScreenViewState createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _handleNavigation();
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Interval(0.0, 0.5, curve: Curves.easeOut),
    ));

    _controller.forward();
  }

  void _handleNavigation() {
    AppStorage storage = AppStorage();

    Timer(const Duration(seconds: 3), () {
      if (storage.token.val.isNotEmpty) {
        if (storage.userGroup.val == "admin") {
          Get.offAll(AdminDashboardPage());
        } else if (storage.userGroup.val == "mechanic") {
          Get.offAll(MechanicDashboardPage());
        } else if (storage.userGroup.val == "user") {
          Get.offAll(UserDashboardPage());
        }
      } else {
        if (storage.onboardViewed.val == false) {
          Get.to(() => OnBoardPage());
        } else {
          Get.offAll(() => LoginScreen());
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4157FF),
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Opacity(
                opacity: _fadeAnimation.value,
                child: Transform.scale(
                  scale: _scaleAnimation.value,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo or Icon
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.car_repair,
                          size: 60,
                          color: Color(0xFF4157FF),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // App Name
                      Text(
                        'Ichiban Auto',
                        style: GoogleFonts.poppins(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 8),

                      // Tagline
                      Text(
                        'Professional Auto Care',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),

                      const SizedBox(height: 48),

                      // Loading Indicator
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white.withOpacity(0.9),
                          ),
                          strokeWidth: 3,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
