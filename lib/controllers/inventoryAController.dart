import 'dart:convert';
import 'dart:io';
import 'package:kib_application/controllers/appointmentController.dart';
import 'package:kib_application/utils/sharedPrefs.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kib_application/utils/apiEndpoints.dart';
import 'package:kib_application/utils/snackbar.dart';

class InventoryAController extends GetxController {
  final _connect = GetConnect();
  final SharedPrefs user     = Get.put(SharedPrefs());
  final penetapanController  = Get.put(AppointmentController());

  DateTime now = DateTime.now();

  late TextEditingController kib_id,
      penetapan_id,
      departemen_id,
      tgl_inventaris,
      skpd,
      skpd_uraian,
      no_register_awal,
      no_register_akhir,
      barang,
      kategori_id_awal,
      nama_spesifikasi_awal,
      nama_spesifikasi_akhir,
      jumlah_awal,
      jumlah_akhir,
      a_luas_m2_awal,
      a_luas_m2_akhir,
      cara_perolehan_awal,
      tgl_perolehan,
      tahun_perolehan,
      perolehan_awal,
      perolehan_akhir,
      atribusi_nibar,
      atribusi_kode_barang,
      atribusi_kode_lokasi,
      atribusi_no_register,
      atribusi_nama_barang,
      atribusi_spesifikasi_barang,
      a_alamat_awal,
      alamat_kota,
      alamat_jalan,
      alamat_no,
      alamat_rt,
      alamat_rw,
      alamat_kodepos,
      a_hak_tanah_awal,
      a_hak_tanah_akhir,
      a_sertifikat_nomor_awal,
      a_sertifikat_nomor_akhir,
      a_sertifikat_tanggal_awal,
      a_sertifikat_tanggal_akhir,
      kondisi_awal,
      asal_usul_awal,
      asal_usul_akhir,
      penggunaan_awal,
      penggunaan_pemda_akhir,
      penggunaan_pempus_y_nm,
      penggunaan_pempus_y_doc,
      penggunaan_pempus_t_nm,
      penggunaan_pdl_y_nm,
      penggunaan_pdl_y_doc,
      penggunaan_pdl_t_nm,
      penggunaan_pl_y_nm,
      penggunaan_pl_y_doc,
      penggunaan_pl_t_nm,
      tercatat_ganda_nibar,
      tercatat_ganda_no_register,
      tercatat_ganda_kode_barang,
      tercatat_ganda_nama_barang,
      tercatat_ganda_spesifikasi_barang,
      tercatat_ganda_luas,
      tercatat_ganda_satuan,
      tercatat_ganda_perolehan,
      tercatat_ganda_tanggal_perolehan,
      tercatat_ganda_kuasa_pengguna,
      lat,
      long,
      lainnya,
      keterangan,
      file_nm,
      petugas,
      tahun;

  @override
  void onInit() {
    super.onInit();
    kib_id                            = TextEditingController();
    penetapan_id                      = TextEditingController();
    departemen_id                     = TextEditingController();
    tgl_inventaris                    = TextEditingController();
    skpd                              = TextEditingController();
    skpd_uraian                       = TextEditingController();
    no_register_awal                  = TextEditingController();
    no_register_akhir                 = TextEditingController();
    barang                            = TextEditingController();
    kategori_id_awal                  = TextEditingController();
    nama_spesifikasi_awal             = TextEditingController();
    nama_spesifikasi_akhir            = TextEditingController();
    jumlah_awal                       = TextEditingController();
    jumlah_akhir                      = TextEditingController();
    a_luas_m2_awal                    = TextEditingController();
    a_luas_m2_akhir                   = TextEditingController();
    cara_perolehan_awal               = TextEditingController();
    tgl_perolehan                     = TextEditingController();
    tahun_perolehan                   = TextEditingController();
    perolehan_awal                    = TextEditingController();
    perolehan_akhir                   = TextEditingController();
    atribusi_nibar                    = TextEditingController();
    atribusi_kode_barang              = TextEditingController();
    atribusi_kode_lokasi              = TextEditingController();
    atribusi_no_register              = TextEditingController();
    atribusi_nama_barang              = TextEditingController();
    atribusi_spesifikasi_barang       = TextEditingController();
    a_alamat_awal                     = TextEditingController();
    alamat_kota                       = TextEditingController();
    alamat_jalan                      = TextEditingController();
    alamat_no                         = TextEditingController();
    alamat_rt                         = TextEditingController();
    alamat_rw                         = TextEditingController();
    alamat_kodepos                    = TextEditingController();
    a_hak_tanah_awal                  = TextEditingController();
    a_hak_tanah_akhir                 = TextEditingController();
    a_sertifikat_nomor_awal           = TextEditingController();
    a_sertifikat_nomor_akhir          = TextEditingController();
    a_sertifikat_tanggal_awal         = TextEditingController();
    a_sertifikat_tanggal_akhir        = TextEditingController();
    kondisi_awal                      = TextEditingController();
    asal_usul_awal                    = TextEditingController();
    asal_usul_akhir                   = TextEditingController();
    penggunaan_awal                   = TextEditingController();
    penggunaan_pemda_akhir            = TextEditingController();
    penggunaan_pempus_y_nm            = TextEditingController();
    penggunaan_pempus_y_doc           = TextEditingController();
    penggunaan_pempus_t_nm            = TextEditingController();
    penggunaan_pdl_y_nm               = TextEditingController();
    penggunaan_pdl_y_doc              = TextEditingController();
    penggunaan_pdl_t_nm               = TextEditingController();
    penggunaan_pl_y_nm                = TextEditingController();
    penggunaan_pl_y_doc               = TextEditingController();
    penggunaan_pl_t_nm                = TextEditingController();
    tercatat_ganda_nibar              = TextEditingController();
    tercatat_ganda_no_register        = TextEditingController();
    tercatat_ganda_kode_barang        = TextEditingController();
    tercatat_ganda_nama_barang        = TextEditingController();
    tercatat_ganda_spesifikasi_barang = TextEditingController();
    tercatat_ganda_luas               = TextEditingController();
    tercatat_ganda_satuan             = TextEditingController();
    tercatat_ganda_perolehan          = TextEditingController();
    tercatat_ganda_tanggal_perolehan  = TextEditingController();
    tercatat_ganda_kuasa_pengguna     = TextEditingController();
    lat                               = TextEditingController();
    long                              = TextEditingController();
    lainnya                           = TextEditingController();
    keterangan                        = TextEditingController();
    file_nm                           = TextEditingController();
    petugas                           = TextEditingController();
    tahun                             = TextEditingController();
  }

  // Method Insert Inventarisasi
  Future<void> insertInventarisA(List<String>id, List<dynamic> data) async {
    String? _getValue(String value) {
      return value.isNotEmpty ? value : null;
    }

    int? _tryParseInt(String? value) {
      if (value != null && value.isNotEmpty) {
        return int.tryParse(value);
      }
      return null;
    }

    String removeDot(String? value) {
      return value?.replaceAll('.', '') ?? '';
    }

    Map<String, dynamic> body = {
      "data": {
        "kib_id"                           : _tryParseInt(_getValue(id[0])),                                                      // int
        "penetapan_id"                     : _tryParseInt(_getValue(id[1])),                                                      // int
        "departemen_id"                    : _tryParseInt(_getValue(id[2])),                                                      // int
        "tgl_inventaris"                   : _getValue(data[0]),                                                                  // date
        "no_register_awal"                 : _tryParseInt(_getValue(data[1])),                                                    // int
        "no_register_akhir"                : _tryParseInt(_getValue(data[2])),                                                    // int
        "no_register_status"               : _tryParseInt(_getValue(data[3])),                                                    // int
        "kategori_id_awal"                 : _tryParseInt(_getValue(data[4])),                                                    // int
        "kategori_id_akhir"                : _tryParseInt(_getValue(data[5])),                                                    // int
        "kategori_id_status"               : _tryParseInt(_getValue(data[6])),                                                    // int
        "nama_spesifikasi_awal"            : _getValue(data[7]),                                                                  // String
        "nama_spesifikasi_akhir"           : _getValue(data[8]),                                                                  // String
        "nama_spesifikasi_status"          : _tryParseInt(_getValue(data[9])),                                                    // int
        "jumlah_awal"                      : _tryParseInt(_getValue(data[10])),                                                   // int
        "jumlah_akhir"                     : _tryParseInt(_getValue(data[11])),                                                   // int
        "jumlah_status"                    : _tryParseInt(_getValue(data[12])),                                                   // int
        "a_luas_m2_awal"                   : _tryParseInt(_getValue(data[13])),                                                   // int
        "a_luas_m2_akhir"                  : _tryParseInt(_getValue(data[14])),                                                   // int
        "a_luas_m2_status"                 : _tryParseInt(_getValue(data[15])),                                                   // int
        "satuan"                           : _getValue(data[16]),                                                                 // String
        "cara_perolehan_awal"              : _getValue(data[17]),                                                                 // String
        "cara_perolehan_akhir"             : _getValue(data[18]),                                                                 // String
        "cara_perolehan_status"            : _tryParseInt(_getValue(data[19])),                                                   // int
        "tgl_perolehan"                    : _getValue(data[20]),                                                                 // date
        "tahun_perolehan"                  : _tryParseInt(_getValue(data[21])),                                                   // int
        "perolehan_awal"                   : _tryParseInt(removeDot(_getValue(data[22]))),                                        // int
        "perolehan_akhir"                  : _tryParseInt(removeDot(_getValue(data[23]))),                                        // int
        "perolehan_status"                 : _tryParseInt(_getValue(data[24])),                                                   // int
        "atribusi_biaya"                   : _tryParseInt(_getValue(data[25])),                                                   // int
        "atribusi_status"                  : _tryParseInt(_getValue(data[26])),                                                   // int
        "atribusi_nibar"                   : _getValue(data[27]),                                                                 // String
        "atribusi_kode_barang"             : _getValue(data[28]),                                                                 // String
        "atribusi_kode_lokasi"             : _getValue(data[29]),                                                                 // String
        "atribusi_no_register"             : _getValue(data[30]),                                                                 // String
        "atribusi_nama_barang"             : _getValue(data[31]),                                                                 // String
        "atribusi_spesifikasi_barang"      : _getValue(data[32]),                                                                 // String
        "a_alamat_awal"                    : _getValue(data[33]),                                                                 // String
        "a_alamat_status"                  : _tryParseInt(_getValue(data[34])),                                                   // int
        "alamat_kota"                      : _getValue(data[35]),                                                                 // String
        "alamat_kecamatan"                 : _getValue(data[36]),                                                                 // String
        "alamat_kelurahan"                 : _getValue(data[37]),                                                                 // String
        "alamat_jalan"                     : _getValue(data[38]),                                                                 // String
        "alamat_no"                        : _getValue(data[39]),                                                                 // String
        "alamat_rt"                        : _getValue(data[40]),                                                                 // String
        "alamat_rw"                        : _getValue(data[41]),                                                                 // String
        "alamat_kodepos"                   : _getValue(data[42]),                                                                 // String
        "a_hak_tanah_awal"                 : _getValue(data[43]),                                                                 // String
        "a_hak_tanah_akhir"                : _getValue(data[44]),                                                                 // String
        "a_hak_tanah_status"               : _tryParseInt(_getValue(data[45])),                                                   // int
        "a_sertifikat_nomor_awal"          : _getValue(data[46]),                                                                 // String
        "a_sertifikat_nomor_akhir"         : _getValue(data[47]),                                                                 // String
        "a_sertifikat_nomor_status"        : _tryParseInt(_getValue(data[48])),                                                   // int
        "a_sertifikat_tanggal_awal"        : _getValue(data[49]),                                                                 // date
        "a_sertifikat_tanggal_akhir"       : _getValue(data[50]),                                                                 // date
        "a_sertifikat_tanggal_status"      : _tryParseInt(_getValue(data[51])),                                                   // int
        "keberadaan_barang_status"         : _tryParseInt(_getValue(data[52])),                                                   // int
        "kondisi_awal"                     : _getValue(data[53]),                                                                 // String
        "kondisi_akhir"                    : _getValue(data[54]),                                                                 // String
        "kondisi_status"                   : _tryParseInt(_getValue(data[55])),                                                   // int
        "asal_usul_awal"                   : _getValue(data[56]),                                                                 // String
        "asal_usul_akhir"                  : _getValue(data[57]),                                                                 // String
        "asal_usul_status"                 : _tryParseInt(_getValue(data[58])),                                                   // int
        "penggunaan_status"                : _tryParseInt(_getValue(data[59])),                                                   // int
        "penggunaan_awal"                  : _getValue(data[60]),                                                                 // String
        "penggunaan_pemda_status"          : _tryParseInt(_getValue(data[61])),                                                   // int
        "penggunaan_pemda_akhir"           : _getValue(data[62]),                                                                 // String
        "penggunaan_pempus_status"         : _tryParseInt(_getValue(data[63])),                                                   // int
        "penggunaan_pempus_yt"             : _tryParseInt(_getValue(data[64])),                                                   // int
        "penggunaan_pempus_y_nm"           : _getValue(data[65]),                                                                 // String
        "penggunaan_pempus_y_doc"          : _getValue(data[66]),                                                                 // String
        "penggunaan_pempus_t_nm"           : _getValue(data[67]),                                                                 // String
        "penggunaan_pdl_status"            : _tryParseInt(_getValue(data[68])),                                                   // int
        "penggunaan_pdl_yt"                : _tryParseInt(_getValue(data[69])),                                                   // int
        "penggunaan_pdl_y_nm"              : _getValue(data[70]),                                                                 // String
        "penggunaan_pdl_y_doc"             : _getValue(data[71]),                                                                 // String
        "penggunaan_pdl_t_nm"              : _getValue(data[72]),                                                                 // String
        "penggunaan_pl_status"             : _tryParseInt(_getValue(data[73])),                                                   // int
        "penggunaan_pl_yt"                 : _tryParseInt(_getValue(data[74])),                                                   // int
        "penggunaan_pl_y_nm"               : _getValue(data[75]),                                                                 // String
        "penggunaan_pl_y_doc"              : _getValue(data[76]),                                                                 // String
        "penggunaan_pl_t_nm"               : _getValue(data[77]),                                                                 // String
        "tercatat_ganda"                   : _tryParseInt(_getValue(data[78])),                                                   // int
        "tercatat_ganda_nibar"             : _getValue(data[79]),                                                                 // String
        "tercatat_ganda_no_register"       : _getValue(data[80]),                                                                 // String
        "tercatat_ganda_kode_barang"       : _getValue(data[81]),                                                                 // String
        "tercatat_ganda_nama_barang"       : _getValue(data[82]),                                                                 // String
        "tercatat_ganda_spesifikasi_barang": _getValue(data[83]),                                                                 // String
        "tercatat_ganda_luas"              : _getValue(data[84]),                                                                 // String
        "tercatat_ganda_satuan"            : _getValue(data[85]),                                                                 // String
        "tercatat_ganda_perolehan"         : _getValue(data[86]),                                                                 // String
        "tercatat_ganda_tanggal_perolehan" : _getValue(data[87]),                                                                 // date
        "tercatat_ganda_kuasa_pengguna"    : _getValue(data[88]),                                                                 // String
        "pemilik_id"                       : _tryParseInt(_getValue(data[89])),                                                   // int
        "lat"                              : _getValue(data[90]),                                                                 // String
        "long"                             : _getValue(data[91]),                                                                 // String
        "lainnya"                          : _getValue(data[92]),                                                                 // String
        "keterangan"                       : _getValue(data[93]),                                                                 // String
        "petugas"                          : _getValue(jsonEncode(data[94])) == '[""]' ? '[]': _getValue(jsonEncode(data[94])),   // JSON
        "tahun"                            : now.year,                                                                            // int
        "status"                           : 0
      }
    };

    Directory? directory = await getExternalStorageDirectory();
    
    if (directory != null) {
      String path = directory.path;
      String fileName = 'inventarisA-insert.json';
      String filePath = '$path/$fileName';
      String jsonString = jsonEncode(body);

      File file = File(filePath);
      await file.writeAsString(jsonString);

      print('File JSON disimpan di: $filePath');
    } else {
      print('Error: Direktori penyimpanan eksternal null.');
    }

    try {
      final response = await _connect.post(
        '${ApiEndPoints.baseurl}${ApiEndPoints.authEndPoints.postInventaris}add/A',
        body,
      );

      if (response.statusCode == 201) {
        Get.back();
        await penetapanController.getPenetapan(user.departemen_id.value, user.kategori.value, int.parse(user.page.value));
        customSnackBar("Success", response.body['message'], 'success');
      } else {
        print("Error: ${response.statusCode}");
        print("Response Body: ${response.body}");
        customSnackBar("Error", "Failed to inventarisasi data!", 'error');
      }
    } catch (error) {
      print("Error: $error");
      customSnackBar("Error", "An unexpected error occurred!", 'error');
    }
  }

  // Method Update Inventarisasi
  Future<void> updateInventarisA(String kib_id, List<dynamic> data) async {
    String? _getValue(String value) {
      return value.isNotEmpty ? value : null;
    }

    int? _tryParseInt(String? value) {
      if (value != null && value.isNotEmpty) {
        return int.tryParse(value);
      }
      return null;
    }

    String removeDot(String? value) {
      return value?.replaceAll('.', '') ?? '';
    }

    Map<String, dynamic> body = {
      "data": {
        "tgl_inventaris"                   : _getValue(data[0]),                                                                // date
        "no_register_awal"                 : _tryParseInt(_getValue(data[1])),                                                  // int
        "no_register_akhir"                : _tryParseInt(_getValue(data[2])),                                                  // int
        "no_register_status"               : _tryParseInt(_getValue(data[3])),                                                  // int
        "kategori_id_awal"                 : _tryParseInt(_getValue(data[4])),                                                  // int
        "kategori_id_akhir"                : _tryParseInt(_getValue(data[5])),                                                  // int
        "kategori_id_status"               : _tryParseInt(_getValue(data[6])),                                                  // int
        "nama_spesifikasi_awal"            : _getValue(data[7]),                                                                // String
        "nama_spesifikasi_akhir"           : _getValue(data[8]),                                                                // String
        "nama_spesifikasi_status"          : _tryParseInt(_getValue(data[9])),                                                  // int
        "jumlah_awal"                      : _tryParseInt(_getValue(data[10])),                                                 // int
        "jumlah_akhir"                     : _tryParseInt(_getValue(data[11])),                                                 // int
        "jumlah_status"                    : _tryParseInt(_getValue(data[12])),                                                 // int
        "a_luas_m2_awal"                   : _tryParseInt(_getValue(data[13])),                                                 // int
        "a_luas_m2_akhir"                  : _tryParseInt(_getValue(data[14])),                                                 // int
        "a_luas_m2_status"                 : _tryParseInt(_getValue(data[15])),                                                 // int
        "satuan"                           : _getValue(data[16]),                                                               // String
        "cara_perolehan_awal"              : _getValue(data[17]),                                                               // String
        "cara_perolehan_akhir"             : _getValue(data[18]),                                                               // String
        "cara_perolehan_status"            : _tryParseInt(_getValue(data[19])),                                                 // int
        "tgl_perolehan"                    : _getValue(data[20]),                                                               // date
        "tahun_perolehan"                  : _tryParseInt(_getValue(data[21])),                                                 // int
        "perolehan_awal"                   : _tryParseInt(removeDot(_getValue(data[22]))),                                      // int
        "perolehan_akhir"                  : _tryParseInt(removeDot(_getValue(data[23]))),                                      // int
        "perolehan_status"                 : _tryParseInt(_getValue(data[24])),                                                 // int
        "atribusi_biaya"                   : _tryParseInt(_getValue(data[25])),                                                 // int
        "atribusi_status"                  : _tryParseInt(_getValue(data[26])),                                                 // int
        "atribusi_nibar"                   : _getValue(data[27]),                                                               // String
        "atribusi_kode_barang"             : _getValue(data[28]),                                                               // String
        "atribusi_kode_lokasi"             : _getValue(data[29]),                                                               // String
        "atribusi_no_register"             : _getValue(data[30]),                                                               // String
        "atribusi_nama_barang"             : _getValue(data[31]),                                                               // String
        "atribusi_spesifikasi_barang"      : _getValue(data[32]),                                                               // String
        "a_alamat_awal"                    : _getValue(data[33]),                                                               // String
        "a_alamat_status"                  : _tryParseInt(_getValue(data[34])),                                                 // int
        "alamat_kota"                      : _getValue(data[35]),                                                               // String
        "alamat_kecamatan"                 : _getValue(data[36]),                                                               // String
        "alamat_kelurahan"                 : _getValue(data[37]),                                                               // String
        "alamat_jalan"                     : _getValue(data[38]),                                                               // String
        "alamat_no"                        : _getValue(data[39]),                                                               // String
        "alamat_rt"                        : _getValue(data[40]),                                                               // String
        "alamat_rw"                        : _getValue(data[41]),                                                               // String
        "alamat_kodepos"                   : _getValue(data[42]),                                                               // String
        "a_hak_tanah_awal"                 : _getValue(data[43]),                                                               // String
        "a_hak_tanah_akhir"                : _getValue(data[44]),                                                               // String
        "a_hak_tanah_status"               : _tryParseInt(_getValue(data[45])),                                                 // int
        "a_sertifikat_nomor_awal"          : _getValue(data[46]),                                                               // String
        "a_sertifikat_nomor_akhir"         : _getValue(data[47]),                                                               // String
        "a_sertifikat_nomor_status"        : _tryParseInt(_getValue(data[48])),                                                 // int
        "a_sertifikat_tanggal_awal"        : _getValue(data[49]),                                                               // date
        "a_sertifikat_tanggal_akhir"       : _getValue(data[50]),                                                               // date
        "a_sertifikat_tanggal_status"      : _tryParseInt(_getValue(data[51])),                                                 // int
        "keberadaan_barang_status"         : _tryParseInt(_getValue(data[52])),                                                 // int
        "kondisi_awal"                     : _getValue(data[53]),                                                               // String
        "kondisi_akhir"                    : _getValue(data[54]),                                                               // String
        "kondisi_status"                   : _tryParseInt(_getValue(data[55])),                                                 // int
        "asal_usul_awal"                   : _getValue(data[56]),                                                               // String
        "asal_usul_akhir"                  : _getValue(data[57]),                                                               // String
        "asal_usul_status"                 : _tryParseInt(_getValue(data[58])),                                                 // int
        "penggunaan_status"                : _tryParseInt(_getValue(data[59])),                                                 // int
        "penggunaan_awal"                  : _getValue(data[60]),                                                               // String
        "penggunaan_pemda_status"          : _tryParseInt(_getValue(data[61])),                                                 // int
        "penggunaan_pemda_akhir"           : _getValue(data[62]),                                                               // String
        "penggunaan_pempus_status"         : _tryParseInt(_getValue(data[63])),                                                 // int
        "penggunaan_pempus_yt"             : _tryParseInt(_getValue(data[64])),                                                 // int
        "penggunaan_pempus_y_nm"           : _getValue(data[65]),                                                               // String
        "penggunaan_pempus_y_doc"          : _getValue(data[66]),                                                               // String
        "penggunaan_pempus_t_nm"           : _getValue(data[67]),                                                               // String
        "penggunaan_pdl_status"            : _tryParseInt(_getValue(data[68])),                                                 // int
        "penggunaan_pdl_yt"                : _tryParseInt(_getValue(data[69])),                                                 // int
        "penggunaan_pdl_y_nm"              : _getValue(data[70]),                                                               // String
        "penggunaan_pdl_y_doc"             : _getValue(data[71]),                                                               // String
        "penggunaan_pdl_t_nm"              : _getValue(data[72]),                                                               // String
        "penggunaan_pl_status"             : _tryParseInt(_getValue(data[73])),                                                 // int
        "penggunaan_pl_yt"                 : _tryParseInt(_getValue(data[74])),                                                 // int
        "penggunaan_pl_y_nm"               : _getValue(data[75]),                                                               // String
        "penggunaan_pl_y_doc"              : _getValue(data[76]),                                                               // String
        "penggunaan_pl_t_nm"               : _getValue(data[77]),                                                               // String
        "tercatat_ganda"                   : _tryParseInt(_getValue(data[78])),                                                 // int
        "tercatat_ganda_nibar"             : _getValue(data[79]),                                                               // String
        "tercatat_ganda_no_register"       : _getValue(data[80]),                                                               // String
        "tercatat_ganda_kode_barang"       : _getValue(data[81]),                                                               // String
        "tercatat_ganda_nama_barang"       : _getValue(data[82]),                                                               // String
        "tercatat_ganda_spesifikasi_barang": _getValue(data[83]),                                                               // String
        "tercatat_ganda_luas"              : _getValue(data[84]),                                                               // String
        "tercatat_ganda_satuan"            : _getValue(data[85]),                                                               // String
        "tercatat_ganda_perolehan"         : _getValue(data[86]),                                                               // String
        "tercatat_ganda_tanggal_perolehan" : _getValue(data[87]),                                                               // date
        "tercatat_ganda_kuasa_pengguna"    : _getValue(data[88]),                                                               // String
        "pemilik_id"                       : _tryParseInt(_getValue(data[89])),                                                 // int
        "lat"                              : _getValue(data[90]),                                                               // String
        "long"                             : _getValue(data[91]),                                                               // String
        "lainnya"                          : _getValue(data[92]),                                                               // String
        "keterangan"                       : _getValue(data[93]),                                                               // String
        "petugas"                          : _getValue(jsonEncode(data[94])) == '[""]' ? '[]': _getValue(jsonEncode(data[94]))  // JSON
      }
    };

    Directory? directory = await getExternalStorageDirectory();
    
    if (directory != null) {
      String path = directory.path;
      String fileName = 'inventarisA-update.json';
      String filePath = '$path/$fileName';
      String jsonString = jsonEncode(body);

      File file = File(filePath);
      await file.writeAsString(jsonString);

      print('File JSON disimpan di: $filePath');
    } else {
      print('Error: Direktori penyimpanan eksternal null.');
    }

    try {
      final response = await _connect.put(
        '${ApiEndPoints.baseurl}${ApiEndPoints.authEndPoints.putInventaris}edit/A/$kib_id',
        body,
      );

      if (response.statusCode == 200) {
        Get.back();
        await penetapanController.getPenetapan(user.departemen_id.value, user.kategori.value, int.parse(user.page.value));
        customSnackBar("Success", response.body['message'], 'success');
      } else {
        print("Error: ${response.statusCode}");
        print("Response Body: ${response.body}");
        customSnackBar("Error", "Failed to update data!", 'error');
      }
    } catch (error) {
      print("Error: $error");
      customSnackBar("Error", "An unexpected error occurred!", 'error');
    }
  }
}