import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kib_application/screens/homeScreen.dart';
import 'package:kib_application/utils/sharedPrefs.dart';
import 'package:kib_application/utils/snackbar.dart';
import 'package:flare_flutter/flare_actor.dart';

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
        user.setLoginStatus('1');

        List<dynamic> groups = response.body['result']['data'][0]['group'];
        if (groups.isNotEmpty) {
          String groupName = groups[0]['group_name'];
          user.setGroup(groupName);
        }

        user.setUsername(response.body['result']['data'][0]['user_name'] ?? "");
        user.setToken(response.body['result']['data'][0]['token'] ?? "");
        user.setNIK(response.body['result']['data'][0]['nik'] ?? "");
        user.setNama(response.body['result']['data'][0]['nama'] ?? "");
        user.setIsPegawai(response.body['result']['data'][0]['is_pegawai'] ?? "");
        user.setDepartemenID(response.body['result']['data'][0]['departemen_id'] ?? "");
        user.setDepartemenKode(response.body['result']['data'][0]['departemen_kd'] ?? "");
        user.setDepartemenNama(response.body['result']['data'][0]['departemen_nm'] ?? "");

        Get.dialog(
          Center(
            child: Container(
              width: 200,
              height: 200,
              child: FlareActor(
                'assets/success.flr',
                animation: 'play',
              ),
            ),
          ),
          barrierDismissible: false,
        );
        await Future.delayed(Duration(seconds: 3));
        Get.back();

        Get.off(HomeScreen());
        usernameController.clear();
        passwordController.clear();
      } else if (response.body.containsKey('error')) {
        customSnackBar("Error", 'Invalid username or password!', 'error');
      }
    }
  }
}
