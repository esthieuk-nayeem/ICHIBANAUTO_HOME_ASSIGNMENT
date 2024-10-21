import 'package:car_workshop_app/features/auth/presentation/pages/splash_screen_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened, this page will be the first to be shown
  static const initial = Routes.splashScreen;

  static final routes = [
    GetPage(
      name: _Paths.splashScreen,
      page: () => const SplashScreenView(),
    ),
  ];
}
