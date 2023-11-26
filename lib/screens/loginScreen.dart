import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:kib_application/controllers/loginController.dart';
import 'package:kib_application/screens/homeScreen.dart';
import 'package:kib_application/utils/sharedPrefs.dart';

class LoginScreen extends StatelessWidget {
  final loginController = Get.put(LoginController());
  final SharedPrefs user = Get.put(SharedPrefs());
  final bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logo_kib.png",
                        height: 120,
                        width: 120,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'FORM KIB',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        '(Kartu Inventarisasi Barang)',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 80),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Username',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: TextFormField(
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Masukan username',
                              hintStyle: TextStyle(color: secondaryTextColor),
                              icon: FaIcon(
                                FontAwesomeIcons.solidUser,
                                size: 18,
                                color: secondaryTextColor,
                              ),
                            ),
                            controller: loginController.usernameController,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: TextFormField(
                            obscureText: _isObscure,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Masukan password',
                              hintStyle: TextStyle(color: secondaryTextColor),
                              icon: FaIcon(
                                FontAwesomeIcons.lock,
                                size: 18,
                                color: secondaryTextColor,
                              ),
                            ),
                            controller: loginController.passwordController,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                          child: Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 2,
                        ),
                      )),
                    ),
                    onTap: () {
                      // loginController.checkLogin();
                      Get.to(HomeScreen());
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
