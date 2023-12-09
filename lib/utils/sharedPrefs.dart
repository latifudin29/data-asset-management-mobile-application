import 'package:get/get.dart';

class SharedPrefs extends GetxController {
  var info_login_status = ''.obs;
  var info_login_level  = ''.obs;

  var username      = ''.obs;
  var token         = ''.obs;
  var nik           = ''.obs;
  var nama          = ''.obs;
  var is_pegawai    = ''.obs;
  var departemen_id = ''.obs;
  var departemen_kd = ''.obs;
  var departemen_nm = ''.obs;

  var kategori      = ''.obs;
  var page          = ''.obs;

  setInfoLoginStatus(args) {
    return info_login_status.value = args;
  }

  setInfoLoginLevel(args) {
    return info_login_level.value = args;
  }

  setUsername(args) {
    return username.value = args;
  }

  setToken(args) {
    return token.value = args;
  }

  setNIK(args) {
    return nik.value = args;
  }

  setNama(args) {
    return nama.value = args;
  }

  setIsPegawai(args) {
    return is_pegawai.value = args.toString();
  }

  setDepartemenID(args) {
    return departemen_id.value = args.toString();
  }

  setDepartemenKode(args) {
    return departemen_kd.value = args;
  }

  setDepartemenNama(args) {
    return departemen_nm.value = args;
  }

  setKategori(args) {
    return kategori.value = args;
  }

  setPage(args) {
    return page.value = args;
  }
}
