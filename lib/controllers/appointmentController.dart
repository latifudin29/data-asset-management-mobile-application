import 'package:get/get.dart';
import 'package:kib_application/screens/forms/editInventoryAScreen.dart';
import 'package:kib_application/utils/apiEndpoints.dart';

class AppointmentController extends GetxController {
  final _connect = GetConnect();
  RxList<Map<String, dynamic>> penetapanList = RxList<Map<String, dynamic>>([]);
  RxList<Map<String, dynamic>> penetapanListById =
      RxList<Map<String, dynamic>>([]);

  Future<void> getPenetapan(String id, String kategori) async {
    final response = await _connect.get(ApiEndPoints.baseurl +
        ApiEndPoints.authEndPoints.getPenetapan +
        id +
        '/' +
        kategori +
        '?perPage=5&page=1');

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
      final List<dynamic> penetapanDataById = data['data'];

      penetapanListById.assignAll(
          penetapanDataById.map((item) => item as Map<String, dynamic>));

      if (title == "tanah") {
        Get.to(EditInventoryAScreen());
      } else if (title == "perkakas") {
      } else if (title == "bangunan") {
      } else if (title == "infrastruktur") {
      } else if (title == "aset") {
      } else if (title == "kdp") {
      } else if (title == "tgr") {
      } else if (title == "atb") {
      } else if (title == "lainnya") {}
    } else {}
  }
}
