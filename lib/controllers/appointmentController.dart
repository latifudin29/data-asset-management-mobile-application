import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kib_application/screens/forms/editInventoryAScreen.dart';
import 'package:kib_application/screens/forms/editInventoryBScreen.dart';
import 'package:kib_application/screens/forms/editInventoryCScreen.dart';
import 'package:kib_application/screens/forms/editInventoryDScreen.dart';
import 'package:kib_application/screens/forms/editInventoryEScreen.dart';
import 'package:kib_application/screens/forms/editInventoryTGRScreen.dart';
import 'package:kib_application/screens/forms/editInventoryATBScreen.dart';
import 'package:kib_application/screens/forms/editInventoryBelumTerdaftarScreen.dart';
import 'package:kib_application/utils/apiEndpoints.dart';
import 'package:kib_application/controllers/addressController.dart';
import 'package:kib_application/controllers/categoryController.dart';
import 'package:kib_application/controllers/unitController.dart';
import 'package:kib_application/controllers/roomController.dart';

class AppointmentController extends GetxController {
  final _connect = GetConnect();
  final kategoriController = Get.put(CategoryController());
  final satuanController = Get.put(UnitController());
  final ruangController = Get.put(RoomController());
  final addressController = Get.put(AddressController());

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
    try {
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      satuanController.getSatuan();
      ruangController.getRuang(id);
      addressController.getKecamatan();

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

        penetapanList.assignAll(
            penetapanData.map((item) => item as Map<String, dynamic>));
        totalPage.value = data['total_page'];
      }
    } finally {
      Get.back();
    }
  }

  Future<void> getPenetapanById(String id, String kategori) async {
    try {
      Get.dialog(Center(child: CircularProgressIndicator()),
          barrierDismissible: false);

      if (kategori == "A") {
        await kategoriController.getKategori("A");
      } else if (kategori == "B"){
        await kategoriController.getKategori("B");
      } else if (kategori == "C"){
        await kategoriController.getKategori("C");
      } else if (kategori == "D"){
        await kategoriController.getKategori("D");
      }  else if (kategori == "E"){
        await kategoriController.getKategori("E");
      }

      final response = await _connect.get(ApiEndPoints.baseurl +
          ApiEndPoints.authEndPoints.getPenetapanById +
          kategori +
          '/' +
          id);
      
      print('INI ID: $id');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.body;
        final Map<String, dynamic> penetapanDataById = data['data'];

        penetapanDataById.forEach((key, value) {
          if (value == null || value == "-" || value == "_") {
            penetapanDataById[key] = "";
          }
        });

        final List<Map<String, dynamic>> penetapanDataList = [
          penetapanDataById
        ];

        penetapanListById.assignAll(penetapanDataList);

        final filteredList = addressController.kecamatanList.where((kecamatan) =>
          kecamatan['kecamatan_kd'].toString() == penetapanListById[0]['alamat_kecamatan'].toString());

        if (filteredList.isNotEmpty) {
          Map<String, dynamic> kecamatanData = filteredList.first;
          int idKecamatan = kecamatanData['id'];
          await addressController.getKelurahan(idKecamatan.toString());
        }
      }
      
    } finally {
      Get.back();

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
      } else if (kategori == "tgr") {
        Get.to(EditInventoryTGRScreen());
      } else if (kategori == "atb") {
        Get.to(EditInventoryATBScreen());
      } else if (kategori == "belumTerdaftar") {
        Get.to(EditInventoryBelumTerdaftarScreen());
      }
    }
  }
}
