import 'package:get/get.dart';

class SharedPrefs extends GetxController {
  var username = ''.obs;

  setUsername(args) {
    return username.value = args;
  }
}
