import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kib_application/screens/homeScreen.dart';
import 'package:kib_application/utils/loader.dart';
import 'package:kib_application/utils/sharedPrefs.dart';
import 'package:kib_application/utils/snackbar.dart';

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

  checkLogin() {
    if (usernameController.text.isEmpty && passwordController.text.isEmpty) {
      customSnackBar("Error", 'Username dan password harus diisi!', 'error');
    } else if (usernameController.text.isEmpty) {
      customSnackBar("Error", 'Password tidak boleh kosong!', 'error');
    } else if (passwordController.text.isEmpty) {
      customSnackBar("Error", 'Password tidak boleh kosong!', 'error');
    } else {
      Get.showOverlay(
          asyncFunction: () => login(), loadingWidget: const Loader());
    }
  }

  login() async {
    Map<String, String> headers = {
      'Userid': 'ws-inventaris',
      'Signature': 'MOTGI7vibUgwL6gJyyVDi+DD1YIB7hOzo14jl2F5uGA=',
      'Key': '1699093787'
    };

    Map<String, dynamic> body = {
      "jsonrpc": "2.0",
      "method": "login",
      "params": {
        "data": [
          {
            "user_name": usernameController.text,
            "password": passwordController.text,
          }
        ]
      },
      "id": 1
    };

    final response = await _connect.post(
        'https://aset.bogorkota.net/inventaris/rpc/user', body,
        headers: headers);

    if (response.statusCode == 200) {
      if (response.body.containsKey('result')) {
        String username = response.body['result']['data'][0]['user_name'];
        user.setUsername(username);

        Get.off(HomeScreen());
        customSnackBar("Success", 'Login success!', 'success');
        usernameController.clear();
        passwordController.clear();
      } else if (response.body.containsKey('error')) {
        customSnackBar("Error", 'Invalid username or password!', 'error');
      }
    }
  }
}
