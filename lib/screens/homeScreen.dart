import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:kib_application/controllers/logoutController.dart';
import 'package:kib_application/screens/changePasswordScreen.dart';
import 'package:kib_application/screens/inventoryScreen.dart';
import 'package:kib_application/utils/sharedPrefs.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key});

  final logoutController = Get.put(LogoutController());
  final SharedPrefs user = Get.put(SharedPrefs());

  void showPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilihan"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text("Ubah Password"),
                onTap: () {
                  Navigator.of(context).pop();
                  Get.to(ChangePasswordScreen());
                },
              ),
              ListTile(
                title: Text("Logout"),
                onTap: () {
                  Navigator.of(context).pop();
                  logoutController.logout();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    List<String> titleScreen = [
      "Tanah (A)",
      "Peralatan dan Mesin (B)",
      "Gedung dan Bangunan (C)",
      "Jalan, Jaringan, dan Irigasi (D)",
      "Aset Tetap Lainnya (E)",
      "KDP (F)",
      "Aset Lain-lain (TGR)",
      "Aset Lain-lain (ATB)",
      "Belum Terdaftar",
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Stack(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        height: 250,
                        width: double.infinity,
                        child: Image.asset(
                          'assets/images/appbar.png',
                          fit: BoxFit.fill,
                        ),
                      ),
                      Menus(titleScreen: titleScreen),
                    ],
                  ),
                  Positioned(
                    left: 0,
                    top: 50,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Row(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Selamat datang,',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                'Petugas ' + user.username(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                ),
                              ),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              showPopUp(context);
                            },
                            child: Icon(
                              Icons.settings,
                              color: Colors.white,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Menus extends StatelessWidget {
  const Menus({
    super.key,
    required this.titleScreen,
  });

  final List<String> titleScreen;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: List.generate(titleScreen.length, (index) {
          final title = titleScreen[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: InkWell(
              onTap: () {
                Get.to(InventoryScreen(title: title));
              },
              borderRadius: BorderRadius.circular(15),
              child: Container(
                padding: EdgeInsets.only(left: 20),
                height: 55,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white70,
                  border: Border.all(color: Color.fromARGB(255, 196, 196, 196)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.menu_book_rounded),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        '$title',
                        style: TextStyle(
                          color: primaryTextColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).map((widget) {
          return Column(
            children: <Widget>[
              widget,
              SizedBox(height: 15),
            ],
          );
        }).toList(),
      ),
    );
  }
}
