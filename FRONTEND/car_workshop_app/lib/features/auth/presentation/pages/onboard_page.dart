import 'package:flutter/material.dart';
import 'package:car_workshop_app/features/auth/presentation/pages/login_page.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingData {
  const OnBoardingData({
    required this.title,
    required this.svgWidget,
    required this.subTitle,
  });

  final Widget svgWidget;
  final String title;
  final String subTitle;
}

class OnBoardPage extends StatefulWidget {
  const OnBoardPage({super.key});

  @override
  State<OnBoardPage> createState() => _OnBoardPageState();
}

class _OnBoardPageState extends State<OnBoardPage> {
  final PageController onboardController = PageController();

  Widget _buildJDMServiceIcon() {
    return CustomPaint(
      size: const Size(200, 200),
      painter: JDMCarPainter(),
    );
  }

  Widget _buildMechanicIcon() {
    return CustomPaint(
      size: const Size(200, 200),
      painter: MechanicToolsPainter(),
    );
  }

  Widget _buildBookingIcon() {
    return CustomPaint(
      size: const Size(200, 200),
      painter: CalendarPainter(),
    );
  }

  late final List<OnBoardingData> data = [
    OnBoardingData(
      title: 'JDM Excellence',
      svgWidget: _buildJDMServiceIcon(),
      subTitle: 'Premier Japanese auto service specialist.',
    ),
    OnBoardingData(
      title: 'Expert Technicians',
      svgWidget: _buildMechanicIcon(),
      subTitle: 'Certified mechanics specialized in Japanese vehicles.',
    ),
    OnBoardingData(
      title: 'Easy Scheduling',
      svgWidget: _buildBookingIcon(),
      subTitle: 'Book your service slot in just a few taps.',
    ),
  ];

  @override
  void dispose() {
    onboardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: onboardController,
        itemCount: data.length,
        itemBuilder: (context, index) {
          OnBoardingData content = data[index];
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: content.svgWidget,
              ),
              const SizedBox(height: 30),
              Text(
                content.title,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  content.subTitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                ),
              ),
            ],
          );
        },
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                onboardController.jumpToPage(2);
              },
              child: const Text("Skip"),
            ),
            Center(
              child: SmoothPageIndicator(
                controller: onboardController,
                count: 3,
                effect: const ExpandingDotsEffect(
                  activeDotColor: Colors.black,
                  dotHeight: 10,
                  dotWidth: 10,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                int nextPage = onboardController.page!.toInt() + 1;
                if (nextPage < 3) {
                  onboardController.animateToPage(
                    nextPage,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  Get.offAll(() => LoginScreen());
                }
              },
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painters for minimal icons
class JDMCarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Draw car body
    final path = Path()
      ..moveTo(size.width * 0.2, size.height * 0.6)
      ..lineTo(size.width * 0.3, size.height * 0.4)
      ..lineTo(size.width * 0.7, size.height * 0.4)
      ..lineTo(size.width * 0.8, size.height * 0.6)
      ..lineTo(size.width * 0.2, size.height * 0.6);

    // Draw wheels
    final wheel1Center = Offset(size.width * 0.3, size.height * 0.7);
    final wheel2Center = Offset(size.width * 0.7, size.height * 0.7);

    canvas.drawPath(path, paint);
    canvas.drawCircle(wheel1Center, size.width * 0.08, paint);
    canvas.drawCircle(wheel2Center, size.width * 0.08, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class MechanicToolsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Draw wrench
    final wrenchPath = Path()
      ..moveTo(size.width * 0.3, size.height * 0.3)
      ..lineTo(size.width * 0.7, size.height * 0.7);

    // Draw circle for wrench head
    final wrenchHead = Offset(size.width * 0.3, size.height * 0.3);

    canvas.drawPath(wrenchPath, paint);
    canvas.drawCircle(wrenchHead, size.width * 0.1, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CalendarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    // Draw calendar outline
    final calendarRect = Rect.fromLTWH(
      size.width * 0.2,
      size.height * 0.2,
      size.width * 0.6,
      size.height * 0.6,
    );

    canvas.drawRect(calendarRect, paint);

    // Draw calendar lines
    canvas.drawLine(
      Offset(size.width * 0.2, size.height * 0.35),
      Offset(size.width * 0.8, size.height * 0.35),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
