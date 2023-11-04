import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kib_application/screens/forms/editInventoryAScreen.dart';
import 'package:kib_application/screens/forms/editInventoryBScreen.dart';
import 'package:kib_application/screens/forms/editInventoryCScreen.dart';
import 'package:kib_application/screens/forms/editInventoryDScreen.dart';
import 'package:kib_application/screens/forms/editInventoryEScreen.dart';
import 'package:kib_application/screens/forms/editInventoryFScreen.dart';
import 'package:kib_application/screens/forms/editInventoryTGRScreen.dart';
import 'package:kib_application/screens/forms/editInventoryATBScreen.dart';
import 'package:kib_application/screens/forms/editInventoryBelumTerdaftarScreen.dart';
import 'package:kib_application/utils/apiEndpoints.dart';

class AppointmentController extends GetxController {
  final _connect = GetConnect();
  RxList<Map<String, dynamic>> penetapanList = RxList<Map<String, dynamic>>([]);
  RxList<Map<String, dynamic>> penetapanListById =
      RxList<Map<String, dynamic>>([]);

  late TextEditingController tahun;

  @override
  void onInit() {
    super.onInit();
    tahun = TextEditingController();
  }

  Future<void> getPenetapan(String id, String kategori, int page) async {
    final response = await _connect.get(ApiEndPoints.baseurl +
        ApiEndPoints.authEndPoints.getPenetapan +
        id +
        '/' +
        kategori +
        '?perPage=5&page=' +
        page.toString() +
        '&tahun=' +
        tahun.text);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.body;
      final List<dynamic> penetapanData = data['data'];

      penetapanList
          .assignAll(penetapanData.map((item) => item as Map<String, dynamic>));
    } else {}
  }

  Future<void> getPenetapanById(String id, String title) async {
    final response = await _connect.get(ApiEndPoints.baseurl +
        ApiEndPoints.authEndPoints.getPenetapanById +
        id);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.body;
      final Map<String, dynamic> penetapanDataById = data['data'];

      final List<Map<String, dynamic>> penetapanDataList = [penetapanDataById];

      penetapanListById.assignAll(penetapanDataList);

      if (title == "A") {
        Get.to(EditInventoryAScreen());
      } else if (title == "B") {
        Get.to(EditInventoryBScreen());
      } else if (title == "C") {
        Get.to(EditInventoryCScreen());
      } else if (title == "D") {
        Get.to(EditInventoryDScreen());
      } else if (title == "E") {
        Get.to(EditInventoryEScreen());
      } else if (title == "F") {
        Get.to(EditInventoryFScreen());
      } else if (title == "tgr") {
        Get.to(EditInventoryTGRScreen());
      } else if (title == "atb") {
        Get.to(EditInventoryATBScreen());
      } else if (title == "belumTerdaftar") {
        Get.to(EditInventoryBelumTerdaftarScreen());
      }
    } else {}
  }
}
