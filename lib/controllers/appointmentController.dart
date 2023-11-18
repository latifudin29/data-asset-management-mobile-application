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
  RxInt totalPage = RxInt(0);

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
        '?perPage=10&page=' +
        page.toString() +
        '&tahun=' +
        tahun.text);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.body;
      final List<dynamic> penetapanData = data['data'];

      penetapanList
          .assignAll(penetapanData.map((item) => item as Map<String, dynamic>));
      totalPage.value = data['total_page'];
    } else {}
  }

  Future<void> getPenetapanById(String id, String kategori) async {
    final response = await _connect.get(ApiEndPoints.baseurl +
        ApiEndPoints.authEndPoints.getPenetapanById +
        id +
        '/' +
        kategori);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.body;
      final Map<String, dynamic> penetapanDataById = data['data'];

      final List<Map<String, dynamic>> penetapanDataList = [penetapanDataById];

      penetapanListById.assignAll(penetapanDataList);

      if (kategori == "A") {
        Get.to(EditInventoryAScreen());
      } else if (kategori == "B") {
        Get.to(EditInventoryBScreen());
      } else if (kategori == "C") {
        Get.to(EditInventoryCScreen());
      } else if (kategori == "D") {
        Get.to(EditInventoryDScreen());
      } else if (kategori == "E") {
        Get.to(EditInventoryEScreen());
      } else if (kategori == "F") {
        Get.to(EditInventoryFScreen());
      } else if (kategori == "tgr") {
        Get.to(EditInventoryTGRScreen());
      } else if (kategori == "atb") {
        Get.to(EditInventoryATBScreen());
      } else if (kategori == "belumTerdaftar") {
        Get.to(EditInventoryBelumTerdaftarScreen());
      }
    } else {}
  }
}
