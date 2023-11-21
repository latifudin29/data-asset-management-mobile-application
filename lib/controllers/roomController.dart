import 'package:get/get.dart';
import 'package:kib_application/utils/apiEndpoints.dart';

class RoomController extends GetxController {
  final _connect = GetConnect();
  RxList<Map<String, dynamic>> ruangList = RxList<Map<String, dynamic>>([]);

  Future<void> getRuang() async {
    final response = await _connect
        .get(ApiEndPoints.baseurl + ApiEndPoints.authEndPoints.getRuangan);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.body;
      if (data['message'] == 'list ruang') {
        final List<dynamic> ruangData = data['data'];
        ruangList.assignAll(
          ruangData.map((item) => Map<String, dynamic>.from(item)),
        );
      } else {}
    } else {}
  }
}
