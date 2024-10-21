part of 'app_pages.dart';

/// used to switch pages
class Routes {
  static const splashScreen = _Paths.splashScreen;
  static const batch = _Paths.batch;
  static const auth = _Paths.auth;
}

/// contains a list of route names.
// made separately to make it easier to manage route naming
class _Paths {
  static const splashScreen = '/splashScreen';
  static const batch = '/batch';
  static const auth = '/auth';
}
