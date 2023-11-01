import 'package:get/get.dart';
import 'package:kib_application/screens/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogoutController extends GetxController {
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    Get.offAll(LoginScreen());
  }
}
