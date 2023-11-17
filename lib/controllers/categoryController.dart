import 'package:get/get.dart';
import 'package:kib_application/utils/apiEndpoints.dart';

class CategoryController extends GetxController {
  final _connect = GetConnect();
  RxList<Map<String, dynamic>> kategoriList = RxList<Map<String, dynamic>>([]);

  Future<void> getKategori(String kategori) async {
    final response = await _connect.get(ApiEndPoints.baseurl +
        ApiEndPoints.authEndPoints.getKategori +
        kategori);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.body;
      if (data['message'] == 'list kategori') {
        final List<dynamic> kategoriData = data['data'];
        kategoriList.assignAll(
          kategoriData.map((item) => Map<String, dynamic>.from(item)),
        );
      } else {}
    } else {}
  }
}
