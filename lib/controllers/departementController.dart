import 'package:get/get.dart';
import 'package:kib_application/utils/apiEndpoints.dart';

class DepartemenController extends GetxController {
  final _connect = GetConnect();
  RxList<Map<String, dynamic>> departemenList =
      RxList<Map<String, dynamic>>([]);

  Future<void> getDepartemen() async {
    final response = await _connect
        .get(ApiEndPoints.baseurl + ApiEndPoints.authEndPoints.getDepartemen);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.body;
      if (data['message'] == 'list departemens') {
        final List<dynamic> departemenData = data['data'];
        departemenList.assignAll(
            departemenData.map((item) => item as Map<String, dynamic>));
      } else {}
    } else {}
  }
}
