import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kib_application/screens/homeScreen.dart';
import 'package:kib_application/utils/apiEndpoints.dart';
import 'package:kib_application/utils/sharedPrefs.dart';

class LoginController extends GetxController {
  final _connect = GetConnect();
  final SharedPrefs user = Get.put(SharedPrefs());

  late TextEditingController usernameController, passwordController;

  @override
  void onInit() {
    super.onInit();
    usernameController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    usernameController.dispose();
    passwordController.dispose();
  }

  Future<void> login() async {
    final response = await _connect.post(
      ApiEndPoints.baseurl + ApiEndPoints.authEndPoints.login,
      {
        "username": usernameController.text,
        "password": passwordController.text,
      },
    );

    if (response.body['success'] == true) {
      String username = response.body['data'][0]['username'];
      user.setUsername(username);

      Get.off(HomeScreen());
      usernameController.clear();
      passwordController.clear();
    } else {
      print('Login Gagal!');
    }
  }
}
