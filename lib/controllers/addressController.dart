import 'package:get/get.dart';
import 'package:kib_application/utils/apiEndpoints.dart';

class AddressController extends GetxController {
  final _connect = GetConnect();
  RxList<Map<String, dynamic>> kecamatanList = RxList<Map<String, dynamic>>([]);
  RxList<Map<String, dynamic>> kelurahanList = RxList<Map<String, dynamic>>([]);

  Future<void> getKecamatan() async {
    final response = await _connect
        .get(ApiEndPoints.baseurl + ApiEndPoints.authEndPoints.getKecamatan);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.body;
      if (data['message'] == 'list kecamatan') {
        final List<dynamic> kecamatanData = data['data'];
        kecamatanList.assignAll(
          kecamatanData.map((item) => Map<String, dynamic>.from(item)),
        );
      } else {}
    } else {}
  }

  Future<void> getKelurahan(String id_kecamatan) async {
    final response = await _connect.get(ApiEndPoints.baseurl +
        ApiEndPoints.authEndPoints.getKelurahan +
        '/' +
        id_kecamatan);

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.body;
      if (data['message'] == 'list kelurahan') {
        final List<dynamic> kelurahanData = data['data'];
        kelurahanList.assignAll(
          kelurahanData.map((item) => Map<String, dynamic>.from(item)),
        );
      } else {}
    } else {}
  }
}
