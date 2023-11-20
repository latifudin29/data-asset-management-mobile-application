import 'package:get/get.dart';
import 'package:kib_application/utils/apiEndpoints.dart';

class UnitController extends GetxController {
  final _connect = GetConnect();
  RxList<Map<String, dynamic>> satuanList = RxList<Map<String, dynamic>>([]);

  Future<void> getSatuan() async {
    final response = await _connect
        .get(ApiEndPoints.baseurl + ApiEndPoints.authEndPoints.getSatuan);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.body;
      if (data['message'] == 'list satuan') {
        final List<dynamic> satuanData = data['data'];
        satuanList
            .assignAll(satuanData.map((item) => item as Map<String, dynamic>));
      } else {}
    } else {}
  }
}
