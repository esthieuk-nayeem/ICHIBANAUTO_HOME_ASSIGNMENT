import 'package:car_workshop_app/features/auth/models/loggedUserModel.dart';
import 'package:get_storage/get_storage.dart';

class AppStorage {
  final instance = GetStorage();
  final userFullName = "".val("userFullName");
  final token = "".val("token");
  final userEmail = "".val("userEmail");
  final userGroup = "".val("userGroup");
  final onboardViewed = false.val("onboardViewed");

  Future<void> storeUserData(LoggedUser user) async {
    userFullName.val = user.fullName!;
    token.val = user.token!;
    userEmail.val = user.email!;
    userGroup.val = user.group!;
  }
}
