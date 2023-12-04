import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kib_application/utils/apiEndpoints.dart';
import 'package:kib_application/utils/snackbar.dart';

class InventoryDController extends GetxController {
  final _connect = GetConnect();

  late TextEditingController kib_id,
      tgl_inventaris,
      skpd,
      skpd_uraian,
      no_register_awal,
      no_register_akhir,
      barang,
      kategori_id_awal,
      kategori_id_akhir,
      kategori_id_status,
      nama_spesifikasi_awal,
      nama_spesifikasi_akhir,
      nama_spesifikasi_status,
      jumlah_awal,
      satuan,
      cara_perolehan_awal,
      cara_perolehan_akhir,
      cara_perolehan_status,
      tgl_perolehan,
      tahun_perolehan,
      perolehan_awal,
      perolehan_akhir,
      perolehan_status,
      atribusi_status,
      atribusi_nibar,
      atribusi_kode_barang,
      atribusi_kode_lokasi,
      atribusi_no_register,
      atribusi_nama_barang,
      atribusi_spesifikasi_barang,
      a_alamat_awal,
      a_alamat_akhir,
      a_alamat_status,
      alamat_kota,
      alamat_kecamatan,
      alamat_kelurahan,
      alamat_jalan,
      alamat_no,
      alamat_rt,
      alamat_rw,
      alamat_kodepos,
      keberadaan_barang_status,
      kondisi_awal,
      kondisi_akhir,
      kondisi_status,
      asal_usul_awal,
      asal_usul_akhir,
      asal_usul_status,
      penggunaan_status,
      penggunaan_awal,
      penggunaan_pemda_status,
      penggunaan_pemda_akhir,
      penggunaan_pemda_nama_pemakai,
      penggunaan_pemda_nama_pemakai_status,
      penggunaan_pemda_nama_pemakai_akhir,
      penggunaan_pemda_status_pemakai,
      penggunaan_pemda_bast_pemakaian,
      penggunaan_pempus_status,
      penggunaan_pempus_yt,
      penggunaan_pempus_y_nm,
      penggunaan_pempus_y_doc,
      penggunaan_pempus_t_nm,
      penggunaan_pdl_status,
      penggunaan_pdl_yt,
      penggunaan_pdl_y_nm,
      penggunaan_pdl_y_doc,
      penggunaan_pdl_t_nm,
      penggunaan_pl_status,
      penggunaan_pl_yt,
      penggunaan_pl_y_nm,
      penggunaan_pl_y_doc,
      penggunaan_pl_t_nm,
      d_status_tanah_awal,
      d_status_tanah_akhir,
      d_status_tanah_status,
      d_lokasi_awal,
      d_lokasi_akhir,
      d_lokasi_status,
      d_jenis_pengkerasan_jln_awal,
      d_jenis_pengkerasan_jln_akhir,
      d_jenis_pengkerasan_jln_status,
      d_jenis_bahan_jembatan_awal,
      d_jenis_bahan_jembatan_akhir,
      d_jenis_bahan_jembatan_status,
      d_nomor_ruas_jln_awal,
      d_nomor_ruas_jln_akhir,
      d_nomor_ruas_jln_status,
      d_nomor_jaringan_irigasi_awal,
      d_nomor_jaringan_irigasi_akhir,
      d_nomor_jaringan_irigasi_status,
      d_konstruksi_awal,
      d_konstruksi_akhir,
      d_konstruksi_status,
      d_panjang_awal,
      d_panjang_akhir,
      d_panjang_status,
      d_panjang_satuan,
      d_lebar_awal,
      d_lebar_akhir,
      d_lebar_status,
      d_lebar_satuan,
      d_luas_awal,
      d_luas_akhir,
      d_luas_status,
      d_luas_satuan,
      d_luas_tanah,
      d_status_tanah,
      tercatat_ganda,
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
      pemilik_id,
      lat,
      long,
      lainnya,
      keterangan,
      file_nm,
      petugas;

  @override
  void onInit() {
    super.onInit();
    kib_id                               = TextEditingController();
    tgl_inventaris                       = TextEditingController();
    skpd                                 = TextEditingController();
    skpd_uraian                          = TextEditingController();
    no_register_awal                     = TextEditingController();
    no_register_akhir                    = TextEditingController();
    barang                               = TextEditingController();
    kategori_id_awal                     = TextEditingController();
    kategori_id_akhir                    = TextEditingController();
    kategori_id_status                   = TextEditingController();
    nama_spesifikasi_awal                = TextEditingController();
    nama_spesifikasi_akhir               = TextEditingController();
    nama_spesifikasi_status              = TextEditingController();
    jumlah_awal                          = TextEditingController();
    satuan                               = TextEditingController();
    cara_perolehan_awal                  = TextEditingController();
    cara_perolehan_akhir                 = TextEditingController();
    cara_perolehan_status                = TextEditingController();
    tgl_perolehan                        = TextEditingController();
    tahun_perolehan                      = TextEditingController();
    perolehan_awal                       = TextEditingController();
    perolehan_akhir                      = TextEditingController();
    perolehan_status                     = TextEditingController();
    atribusi_status                      = TextEditingController();
    atribusi_nibar                       = TextEditingController();
    atribusi_kode_barang                 = TextEditingController();
    atribusi_kode_lokasi                 = TextEditingController();
    atribusi_no_register                 = TextEditingController();
    atribusi_nama_barang                 = TextEditingController();
    atribusi_spesifikasi_barang          = TextEditingController();
    a_alamat_awal                        = TextEditingController();
    a_alamat_akhir                       = TextEditingController();
    a_alamat_status                      = TextEditingController();
    alamat_kota                          = TextEditingController();
    alamat_kecamatan                     = TextEditingController();
    alamat_kelurahan                     = TextEditingController();
    alamat_jalan                         = TextEditingController();
    alamat_no                            = TextEditingController();
    alamat_rt                            = TextEditingController();
    alamat_rw                            = TextEditingController();
    alamat_kodepos                       = TextEditingController();
    keberadaan_barang_status             = TextEditingController();
    kondisi_awal                         = TextEditingController();
    kondisi_akhir                        = TextEditingController();
    kondisi_status                       = TextEditingController();
    asal_usul_awal                       = TextEditingController();
    asal_usul_akhir                      = TextEditingController();
    asal_usul_status                     = TextEditingController();
    penggunaan_status                    = TextEditingController();
    penggunaan_awal                      = TextEditingController();
    penggunaan_pemda_status              = TextEditingController();
    penggunaan_pemda_akhir               = TextEditingController();
    penggunaan_pemda_nama_pemakai        = TextEditingController();
    penggunaan_pemda_nama_pemakai_status = TextEditingController();
    penggunaan_pemda_nama_pemakai_akhir  = TextEditingController();
    penggunaan_pemda_status_pemakai      = TextEditingController();
    penggunaan_pemda_bast_pemakaian      = TextEditingController();
    penggunaan_pempus_status             = TextEditingController();
    penggunaan_pempus_yt                 = TextEditingController();
    penggunaan_pempus_y_nm               = TextEditingController();
    penggunaan_pempus_y_doc              = TextEditingController();
    penggunaan_pempus_t_nm               = TextEditingController();
    penggunaan_pdl_status                = TextEditingController();
    penggunaan_pdl_yt                    = TextEditingController();
    penggunaan_pdl_y_nm                  = TextEditingController();
    penggunaan_pdl_y_doc                 = TextEditingController();
    penggunaan_pdl_t_nm                  = TextEditingController();
    penggunaan_pl_status                 = TextEditingController();
    penggunaan_pl_yt                     = TextEditingController();
    penggunaan_pl_y_nm                   = TextEditingController();
    penggunaan_pl_y_doc                  = TextEditingController();
    penggunaan_pl_t_nm                   = TextEditingController();
    d_status_tanah_awal                  = TextEditingController();
    d_status_tanah_akhir                 = TextEditingController();
    d_status_tanah_status                = TextEditingController();
    d_lokasi_awal                        = TextEditingController();
    d_lokasi_akhir                       = TextEditingController();
    d_lokasi_status                      = TextEditingController();
    d_jenis_pengkerasan_jln_awal         = TextEditingController();
    d_jenis_pengkerasan_jln_akhir        = TextEditingController();
    d_jenis_pengkerasan_jln_status       = TextEditingController();
    d_jenis_bahan_jembatan_awal          = TextEditingController();
    d_jenis_bahan_jembatan_akhir         = TextEditingController();
    d_jenis_bahan_jembatan_status        = TextEditingController();
    d_nomor_ruas_jln_awal                = TextEditingController();
    d_nomor_ruas_jln_akhir               = TextEditingController();
    d_nomor_ruas_jln_status              = TextEditingController();
    d_nomor_jaringan_irigasi_awal        = TextEditingController();
    d_nomor_jaringan_irigasi_akhir       = TextEditingController();
    d_nomor_jaringan_irigasi_status      = TextEditingController();
    d_konstruksi_awal                    = TextEditingController();
    d_konstruksi_akhir                   = TextEditingController();
    d_konstruksi_status                  = TextEditingController();
    d_panjang_awal                       = TextEditingController();
    d_panjang_akhir                      = TextEditingController();
    d_panjang_status                     = TextEditingController();
    d_panjang_satuan                     = TextEditingController();
    d_lebar_awal                         = TextEditingController();
    d_lebar_akhir                        = TextEditingController();
    d_lebar_status                       = TextEditingController();
    d_lebar_satuan                       = TextEditingController();
    d_luas_awal                          = TextEditingController();
    d_luas_akhir                         = TextEditingController();
    d_luas_status                        = TextEditingController();
    d_luas_satuan                        = TextEditingController();
    d_luas_tanah                         = TextEditingController();
    d_status_tanah                       = TextEditingController();
    tercatat_ganda                       = TextEditingController();
    tercatat_ganda_nibar                 = TextEditingController();
    tercatat_ganda_no_register           = TextEditingController();
    tercatat_ganda_kode_barang           = TextEditingController();
    tercatat_ganda_nama_barang           = TextEditingController();
    tercatat_ganda_spesifikasi_barang    = TextEditingController();
    tercatat_ganda_luas                  = TextEditingController();
    tercatat_ganda_satuan                = TextEditingController();
    tercatat_ganda_perolehan             = TextEditingController();
    tercatat_ganda_tanggal_perolehan     = TextEditingController();
    tercatat_ganda_kuasa_pengguna        = TextEditingController();
    pemilik_id                           = TextEditingController();
    lat                                  = TextEditingController();
    long                                 = TextEditingController();
    lainnya                              = TextEditingController();
    keterangan                           = TextEditingController();
    file_nm                              = TextEditingController();
    petugas                              = TextEditingController();
  }

  // Method Insert Inventarisasi
  Future<void> insertInventarisD(List<String> id, List<dynamic> data) async {
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

    Map<String, dynamic> body = {};

    Directory? directory = await getExternalStorageDirectory();
    
    if (directory != null) {
      String path = directory.path;
      String fileName = 'inventarisD-insert.json';
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
        '${ApiEndPoints.baseurl}${ApiEndPoints.authEndPoints.postInventaris}add/D',
        body,
      );

      if (response.statusCode == 201) {
        Get.back();
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
  Future<void> updateInventarisD(String kib_id, List<dynamic> data) async {
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
        "atribusi_status"                  : _tryParseInt(_getValue(data[25])),                                                   // int
        "atribusi_nibar"                   : _getValue(data[26]),                                                                 // String
        "atribusi_kode_barang"             : _getValue(data[27]),                                                                 // String
        "atribusi_kode_lokasi"             : _getValue(data[28]),                                                                 // String
        "atribusi_no_register"             : _getValue(data[29]),                                                                 // String
        "atribusi_nama_barang"             : _getValue(data[30]),                                                                 // String
        "atribusi_spesifikasi_barang"      : _getValue(data[31]),                                                                 // String
        "a_alamat_awal"                    : _getValue(data[32]),                                                                 // String
        "a_alamat_status"                  : _tryParseInt(_getValue(data[33])),                                                   // int
        "alamat_kota"                      : _getValue(data[34]),                                                                 // String
        "alamat_kecamatan"                 : _getValue(data[35]),                                                                 // String
        "alamat_kelurahan"                 : _getValue(data[36]),                                                                 // String
        "alamat_jalan"                     : _getValue(data[37]),                                                                 // String
        "alamat_no"                        : _getValue(data[38]),                                                                 // String
        "alamat_rt"                        : _getValue(data[39]),                                                                 // String
        "alamat_rw"                        : _getValue(data[40]),                                                                 // String
        "alamat_kodepos"                   : _getValue(data[41]),                                                                 // String
        "a_hak_tanah_awal"                 : _getValue(data[42]),                                                                 // String
        "a_hak_tanah_akhir"                : _getValue(data[43]),                                                                 // String
        "a_hak_tanah_status"               : _tryParseInt(_getValue(data[44])),                                                   // int
        "a_sertifikat_nomor_awal"          : _getValue(data[45]),                                                                 // String
        "a_sertifikat_nomor_akhir"         : _getValue(data[46]),                                                                 // String
        "a_sertifikat_nomor_status"        : _tryParseInt(_getValue(data[47])),                                                   // int
        "a_sertifikat_tanggal_awal"        : _getValue(data[48]),                                                                 // date
        "a_sertifikat_tanggal_akhir"       : _getValue(data[49]),                                                                 // date
        "a_sertifikat_tanggal_status"      : _tryParseInt(_getValue(data[50])),                                                   // int
        "keberadaan_barang_status"         : _tryParseInt(_getValue(data[51])),                                                   // int
        "kondisi_awal"                     : _getValue(data[52]),                                                                 // String
        "kondisi_akhir"                    : _getValue(data[53]),                                                                 // String
        "kondisi_status"                   : _tryParseInt(_getValue(data[54])),                                                   // int
        "asal_usul_awal"                   : _getValue(data[55]),                                                                 // String
        "asal_usul_akhir"                  : _getValue(data[56]),                                                                 // String
        "asal_usul_status"                 : _tryParseInt(_getValue(data[57])),                                                   // int
        "penggunaan_status"                : _tryParseInt(_getValue(data[58])),                                                   // int
        "penggunaan_awal"                  : _getValue(data[59]),                                                                 // String
        "penggunaan_pemda_status"          : _tryParseInt(_getValue(data[60])),                                                   // int
        "penggunaan_pemda_akhir"           : _getValue(data[61]),                                                                 // String
        "penggunaan_pempus_status"         : _tryParseInt(_getValue(data[62])),                                                   // int
        "penggunaan_pempus_yt"             : _tryParseInt(_getValue(data[63])),                                                   // int
        "penggunaan_pempus_y_nm"           : _getValue(data[64]),                                                                 // String
        "penggunaan_pempus_y_doc"          : _getValue(data[65]),                                                                 // String
        "penggunaan_pempus_t_nm"           : _getValue(data[66]),                                                                 // String
        "penggunaan_pdl_status"            : _tryParseInt(_getValue(data[67])),                                                   // int
        "penggunaan_pdl_yt"                : _tryParseInt(_getValue(data[68])),                                                   // int
        "penggunaan_pdl_y_nm"              : _getValue(data[69]),                                                                 // String
        "penggunaan_pdl_y_doc"             : _getValue(data[70]),                                                                 // String
        "penggunaan_pdl_t_nm"              : _getValue(data[71]),                                                                 // String
        "penggunaan_pl_status"             : _tryParseInt(_getValue(data[72])),                                                   // int
        "penggunaan_pl_yt"                 : _tryParseInt(_getValue(data[73])),                                                   // int
        "penggunaan_pl_y_nm"               : _getValue(data[74]),                                                                 // String
        "penggunaan_pl_y_doc"              : _getValue(data[75]),                                                                 // String
        "penggunaan_pl_t_nm"               : _getValue(data[76]),                                                                 // String
        "tercatat_ganda"                   : _tryParseInt(_getValue(data[77])),                                                   // int
        "tercatat_ganda_nibar"             : _getValue(data[78]),                                                                 // String
        "tercatat_ganda_no_register"       : _getValue(data[79]),                                                                 // String
        "tercatat_ganda_kode_barang"       : _getValue(data[80]),                                                                 // String
        "tercatat_ganda_nama_barang"       : _getValue(data[81]),                                                                 // String
        "tercatat_ganda_spesifikasi_barang": _getValue(data[82]),                                                                 // String
        "tercatat_ganda_luas"              : _getValue(data[83]),                                                                 // String
        "tercatat_ganda_satuan"            : _getValue(data[84]),                                                                 // String
        "tercatat_ganda_perolehan"         : _getValue(data[85]),                                                                 // String
        "tercatat_ganda_tanggal_perolehan" : _getValue(data[86]),                                                                 // date
        "tercatat_ganda_kuasa_pengguna"    : _getValue(data[87]),                                                                 // String
        "pemilik_id"                       : _tryParseInt(_getValue(data[88])),                                                   // int
        "lat"                              : _getValue(data[89]),                                                                 // String
        "long"                             : _getValue(data[90]),                                                                 // String
        "lainnya"                          : _getValue(data[91]),                                                                 // String
        "keterangan"                       : _getValue(data[92]),                                                                 // String
        "petugas"                          : _getValue(jsonEncode(data[93])) == '[""]' ? '[]': _getValue(jsonEncode(data[93])),   // JSON
        "tahun"                            : _tryParseInt(_getValue(data[94])),                                                   // int
      }
    };

    Directory? directory = await getExternalStorageDirectory();
    
    if (directory != null) {
      String path = directory.path;
      String fileName = 'inventarisD-update.json';
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
        '${ApiEndPoints.baseurl}${ApiEndPoints.authEndPoints.putInventaris}edit/D/$kib_id',
        body,
      );

      if (response.statusCode == 200) {
        Get.back();
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
