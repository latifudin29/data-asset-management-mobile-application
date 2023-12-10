import 'package:get/get.dart';
import 'package:kib_application/utils/apiEndpoints.dart';

class KuasaController extends GetxController {
  final _connect = GetConnect();
  RxList<Map<String, dynamic>> kuasaList = RxList<Map<String, dynamic>>([]);

  Future<void> getKuasa(String id_departemen) async {
    final response = await _connect
        .get(ApiEndPoints.baseurl + ApiEndPoints.authEndPoints.getKuasa + id_departemen);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.body;
      if (data['message'] == 'list kuasa') {
        final List<dynamic> kuasaData = data['data'];
        kuasaList.assignAll(
            kuasaData.map((item) => item as Map<String, dynamic>));
      } else {}
    } else {}
  }
}
