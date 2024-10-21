// // routes_manager.dart

// import 'package:car_workshop_app/core/resources/strings_manager.dart';
// import 'package:flutter/material.dart';

// class Routes {
//   static const String splashRoute = "/";
//   static const String onBoardingRoute = "/onBoardingRoute";
//   static const String loginRoute = "/loginRoute";
//   static const String registerRoute = "/registerRoute";
//   static const String forgotPasswordRoute = "/forgotPasswordRoute";
//   static const String mainRoute = "/mainRoute";
//   static const String newsPageRoute = "/newsPageRoute";
//   static const String personDetailsRoute = "/personDetailsRoute";
//   static const String articleFeedPage = "/articleFeedPage";
//   static const String commentScreen = "/commentScreen";
//   static const String article_details = "/article_details";
//   static const String key_persond_details = "/key_persond_details";
// }

// class RouteGenerator {
//   static Route<dynamic> getRoute(RouteSettings routeSettings) {
//     switch (routeSettings.name) {
//       // case Routes.splashRoute:
//       //   return MaterialPageRoute(builder: (_) => const SplashScreenView());
//       // case Routes.loginRoute:
//       //   return MaterialPageRoute(builder: (_) => const LoginPage());
//       // case Routes.onBoardingRoute:
//       //   return MaterialPageRoute(builder: (_) => const OnBoardPage());
//       // case Routes.registerRoute:
//       //   return MaterialPageRoute(builder: (_) => const SignUpPage());

//       default:
//         return UndefineddRoute();
//     }
//   }

//   static Route<dynamic> UndefineddRoute() {
//     return MaterialPageRoute(
//       builder: (_) => Scaffold(
//         appBar: AppBar(title: const Text(AppStrings.notRouteFound)),
//         body: const Center(
//           child: Text(AppStrings.notRouteFound),
//         ),
//       ),
//     );
//   }
// }
