import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kib_application/utils/apiEndpoints.dart';
import 'package:kib_application/utils/snackbar.dart';

class InventoryBController extends GetxController {
  final _connect = GetConnect();

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
      b_merk_awal,
      b_merk_akhir,
      b_cc_awal,
      b_cc_akhir,
      b_nomor_polisi_awal,
      b_nomor_polisi_akhir,
      b_nomor_rangka_awal,
      b_nomor_rangka_akhir,
      b_nomor_mesin_awal,
      b_nomor_mesin_akhir,
      b_nomor_bpkb_awal,
      b_nomor_bpkb_akhir,
      b_bahan_awal,
      b_bahan_akhir,
      b_nomor_pabrik_awal,
      b_nomor_pabrik_akhir,
      kartu_inv_awal,
      barcode_barang,
      barcode_barang_akhir,
      barcode_ruangan,
      barcode_ruangan_akhir,
      kondisi_awal,
      asal_usul_awal,
      asal_usul_akhir,
      penggunaan_awal,
      penggunaan_pemda_akhir,
      penggunaan_pemda_nama_pemakai,
      penggunaan_pemda_nama_pemakai_akhir,
      penggunaan_pemda_status_pemakai,
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
      lainnya,
      keterangan,
      file_nm,
      petugas,
      tahun;

  @override
  void onInit() {
    super.onInit();
    kib_id                               = TextEditingController();
    penetapan_id                         = TextEditingController();
    departemen_id                        = TextEditingController();
    tgl_inventaris                       = TextEditingController();
    skpd                                 = TextEditingController();
    skpd_uraian                          = TextEditingController();
    no_register_awal                     = TextEditingController();
    no_register_akhir                    = TextEditingController();
    barang                               = TextEditingController();
    kategori_id_awal                     = TextEditingController();
    nama_spesifikasi_awal                = TextEditingController();
    nama_spesifikasi_akhir               = TextEditingController();
    jumlah_awal                          = TextEditingController();
    cara_perolehan_awal                  = TextEditingController();
    tgl_perolehan                        = TextEditingController();
    tahun_perolehan                      = TextEditingController();
    perolehan_awal                       = TextEditingController();
    perolehan_akhir                      = TextEditingController();
    atribusi_nibar                       = TextEditingController();
    atribusi_kode_barang                 = TextEditingController();
    atribusi_kode_lokasi                 = TextEditingController();
    atribusi_no_register                 = TextEditingController();
    atribusi_nama_barang                 = TextEditingController();
    atribusi_spesifikasi_barang          = TextEditingController();
    a_alamat_awal                        = TextEditingController();
    alamat_kota                          = TextEditingController();
    alamat_jalan                         = TextEditingController();
    alamat_no                            = TextEditingController();
    alamat_rt                            = TextEditingController();
    alamat_rw                            = TextEditingController();
    alamat_kodepos                       = TextEditingController(); 
    b_merk_awal                          = TextEditingController();
    b_merk_akhir                         = TextEditingController();
    b_cc_awal                            = TextEditingController();
    b_cc_akhir                           = TextEditingController();
    b_nomor_polisi_awal                  = TextEditingController();
    b_nomor_polisi_akhir                 = TextEditingController();
    b_nomor_rangka_awal                  = TextEditingController();
    b_nomor_rangka_akhir                 = TextEditingController();
    b_nomor_mesin_awal                   = TextEditingController();
    b_nomor_mesin_akhir                  = TextEditingController();
    b_nomor_bpkb_awal                    = TextEditingController();
    b_nomor_bpkb_akhir                   = TextEditingController();
    b_bahan_awal                         = TextEditingController();
    b_bahan_akhir                        = TextEditingController();
    b_nomor_pabrik_awal                  = TextEditingController();
    b_nomor_pabrik_akhir                 = TextEditingController();
    kartu_inv_awal                       = TextEditingController();
    barcode_barang                       = TextEditingController();
    barcode_barang_akhir                 = TextEditingController();
    barcode_ruangan                      = TextEditingController();
    barcode_ruangan_akhir                = TextEditingController();
    kondisi_awal                         = TextEditingController();
    asal_usul_awal                       = TextEditingController();
    asal_usul_akhir                      = TextEditingController();
    penggunaan_awal                      = TextEditingController();
    penggunaan_pemda_akhir               = TextEditingController();
    penggunaan_pemda_nama_pemakai        = TextEditingController();
    penggunaan_pemda_nama_pemakai_akhir  = TextEditingController();
    penggunaan_pemda_status_pemakai      = TextEditingController();
    penggunaan_pempus_y_nm               = TextEditingController();
    penggunaan_pempus_y_doc              = TextEditingController();
    penggunaan_pempus_t_nm               = TextEditingController();
    penggunaan_pdl_y_nm                  = TextEditingController();
    penggunaan_pdl_y_doc                 = TextEditingController();
    penggunaan_pdl_t_nm                  = TextEditingController();
    penggunaan_pl_y_nm                   = TextEditingController();
    penggunaan_pl_y_doc                  = TextEditingController();
    penggunaan_pl_t_nm                   = TextEditingController();
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
    lainnya                              = TextEditingController();
    keterangan                           = TextEditingController();
    file_nm                              = TextEditingController();
    petugas                              = TextEditingController();
    tahun                                = TextEditingController();
  }

  // Method Insert Inventarisasi
  Future<void> insertInventarisB(List<String> id, List<String> data) async {
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
        "kib_id"                              : _tryParseInt(_getValue(id[0])),                 // int
        "penetapan_id"                        : _tryParseInt(_getValue(id[1])),                 // int
        "departemen_id"                       : _tryParseInt(_getValue(id[2])),                 // int
        "tgl_inventaris"                      : _getValue(data[0]),                             // date
        "no_register_awal"                    : _tryParseInt(_getValue(data[1])),               // int
        "no_register_akhir"                   : _tryParseInt(_getValue(data[2])),               // int
        "no_register_status"                  : _tryParseInt(_getValue(data[3])),               // int
        "kategori_id_awal"                    : _tryParseInt(_getValue(data[4])),               // int
        "kategori_id_akhir"                   : _tryParseInt(_getValue(data[5])),               // int
        "kategori_id_status"                  : _tryParseInt(_getValue(data[6])),               // int
        "nama_spesifikasi_awal"               : _getValue(data[7]),                             // String
        "nama_spesifikasi_akhir"              : _getValue(data[8]),                             // String
        "nama_spesifikasi_status"             : _tryParseInt(_getValue(data[9])),               // int
        "jumlah_awal"                         : _tryParseInt(_getValue(data[10])),              // int
        "satuan"                              : _getValue(data[11]),                            // String
        "cara_perolehan_awal"                 : _getValue(data[12]),                            // String
        "cara_perolehan_akhir"                : _getValue(data[13]),                            // String
        "cara_perolehan_status"               : _tryParseInt(_getValue(data[14])),              // int
        "tgl_perolehan"                       : _getValue(data[15]),                            // date
        "tahun_perolehan"                     : _tryParseInt(_getValue(data[16])),              // int
        "perolehan_awal"                      : _tryParseInt(removeDot(_getValue(data[17]))),   // int
        "perolehan_akhir"                     : _tryParseInt(removeDot(_getValue(data[18]))),   // int
        "perolehan_status"                    : _tryParseInt(_getValue(data[19])),              // int
        "atribusi_status"                     : _tryParseInt(_getValue(data[20])),              // int
        "atribusi_nibar"                      : _getValue(data[21]),                            // String
        "atribusi_kode_barang"                : _getValue(data[22]),                            // String
        "atribusi_kode_lokasi"                : _getValue(data[23]),                            // String
        "atribusi_no_register"                : _getValue(data[24]),                            // String
        "atribusi_nama_barang"                : _getValue(data[25]),                            // String
        "atribusi_spesifikasi_barang"         : _getValue(data[26]),                            // String
        "a_alamat_awal"                       : _getValue(data[27]),                            // String
        "a_alamat_status"                     : _tryParseInt(_getValue(data[28])),              // int
        "alamat_kota"                         : _getValue(data[29]),                            // String
        "alamat_kecamatan"                    : _getValue(data[30]),                            // String
        "alamat_kelurahan"                    : _getValue(data[31]),                            // String
        "alamat_jalan"                        : _getValue(data[32]),                            // String
        "alamat_no"                           : _getValue(data[33]),                            // String
        "alamat_rt"                           : _getValue(data[34]),                            // String
        "alamat_rw"                           : _getValue(data[35]),                            // String
        "alamat_kodepos"                      : _getValue(data[36]),                            // String
        "b_merk_awal"                         : _getValue(data[37]),                            // String
        "b_merk_akhir"                        : _getValue(data[38]),                            // String
        "b_merk_status"                       : _tryParseInt(_getValue(data[39])),              // int
        "b_cc_awal"                           : _getValue(data[40]),                            // String
        "b_cc_akhir"                          : _getValue(data[41]),                            // String
        "b_cc_status"                         : _tryParseInt(_getValue(data[42])),              // int
        "b_nomor_polisi_awal"                 : _getValue(data[43]),                            // String
        "b_nomor_polisi_akhir"                : _getValue(data[44]),                            // String
        "b_nomor_polisi_status"               : _tryParseInt(_getValue(data[45])),              // int
        "b_nomor_rangka_awal"                 : _getValue(data[46]),                            // String
        "b_nomor_rangka_akhir"                : _getValue(data[47]),                            // String
        "b_nomor_rangka_status"               : _tryParseInt(_getValue(data[48])),              // int
        "b_nomor_mesin_awal"                  : _getValue(data[49]),                            // String
        "b_nomor_mesin_akhir"                 : _getValue(data[50]),                            // String
        "b_nomor_mesin_status"                : _tryParseInt(_getValue(data[51])),              // int
        "b_nomor_bpkb_awal"                   : _getValue(data[52]),                            // String
        "b_nomor_bpkb_akhir"                  : _getValue(data[53]),                            // String
        "b_nomor_bpkb_status"                 : _tryParseInt(_getValue(data[54])),              // int
        "b_bahan_awal"                        : _getValue(data[55]),                            // String
        "b_bahan_akhir"                       : _getValue(data[56]),                            // String
        "b_bahan_status"                      : _tryParseInt(_getValue(data[57])),              // int
        "b_nomor_pabrik_awal"                 : _getValue(data[58]),                            // String
        "b_nomor_pabrik_akhir"                : _getValue(data[59]),                            // String
        "b_nomor_pabrik_status"               : _tryParseInt(_getValue(data[60])),              // int
        "kartu_inv_awal"                      : _getValue(data[61]),                            // String
        "kartu_inv_akhir"                     : _getValue(data[62]),                            // String
        "kartu_inv_status"                    : _tryParseInt(_getValue(data[63])),              // int
        "barcode_barang"                      : _tryParseInt(_getValue(data[64])),              // int
        "barcode_ruangan"                     : _tryParseInt(_getValue(data[65])),              // int
        "keberadaan_barang_status"            : _tryParseInt(_getValue(data[66])),              // int
        "kondisi_awal"                        : _getValue(data[67]),                            // String
        "kondisi_akhir"                       : _getValue(data[68]),                            // String
        "kondisi_status"                      : _tryParseInt(_getValue(data[69])),              // int
        "asal_usul_awal"                      : _getValue(data[70]),                            // String
        "asal_usul_akhir"                     : _getValue(data[71]),                            // String
        "asal_usul_status"                    : _tryParseInt(_getValue(data[72])),              // int
        "penggunaan_status"                   : _tryParseInt(_getValue(data[73])),              // int
        "penggunaan_awal"                     : _getValue(data[74]),                            // String
        "penggunaan_pemda_status"             : _tryParseInt(_getValue(data[75])),              // int
        "penggunaan_pemda_akhir"              : _getValue(data[76]),                            // String
        "penggunaan_pemda_nama_pemakai"       : _getValue(data[77]),                            // String
        "penggunaan_pemda_nama_pemakai_akhir" : _getValue(data[78]),                            // String
        "penggunaan_pemda_nama_pemakai_status": _tryParseInt(_getValue(data[79])),              // int
        "penggunaan_pemda_status_pemakai"     : _getValue(data[80]),                            // String
        "penggunaan_pemda_bast_pemakaian"     : _tryParseInt(_getValue(data[81])),              // int
        "penggunaan_pempus_status"            : _tryParseInt(_getValue(data[82])),              // int
        "penggunaan_pempus_yt"                : _tryParseInt(_getValue(data[83])),              // int
        "penggunaan_pempus_y_nm"              : _getValue(data[84]),                            // String
        "penggunaan_pempus_y_doc"             : _getValue(data[85]),                            // String
        "penggunaan_pempus_t_nm"              : _getValue(data[86]),                            // String
        "penggunaan_pdl_status"               : _tryParseInt(_getValue(data[87])),              // int
        "penggunaan_pdl_yt"                   : _tryParseInt(_getValue(data[88])),              // int
        "penggunaan_pdl_y_nm"                 : _getValue(data[89]),                            // String
        "penggunaan_pdl_y_doc"                : _getValue(data[90]),                            // String
        "penggunaan_pdl_t_nm"                 : _getValue(data[91]),                            // String
        "penggunaan_pl_status"                : _tryParseInt(_getValue(data[92])),              // int
        "penggunaan_pl_yt"                    : _tryParseInt(_getValue(data[93])),              // int
        "penggunaan_pl_y_nm"                  : _getValue(data[94]),                            // String
        "penggunaan_pl_y_doc"                 : _getValue(data[95]),                            // String
        "penggunaan_pl_t_nm"                  : _getValue(data[96]),                            // String
        "tercatat_ganda"                      : _tryParseInt(_getValue(data[97])),              // int
        "tercatat_ganda_nibar"                : _getValue(data[98]),                            // String
        "tercatat_ganda_no_register"          : _getValue(data[99]),                            // String
        "tercatat_ganda_kode_barang"          : _getValue(data[100]),                           // String
        "tercatat_ganda_nama_barang"          : _getValue(data[101]),                           // String
        "tercatat_ganda_spesifikasi_barang"   : _getValue(data[102]),                           // String
        "tercatat_ganda_luas"                 : _getValue(data[103]),                           // String
        "tercatat_ganda_satuan"               : _getValue(data[104]),                           // String
        "tercatat_ganda_perolehan"            : _getValue(data[105]),                           // String
        "tercatat_ganda_tanggal_perolehan"    : _getValue(data[106]),                           // date
        "tercatat_ganda_kuasa_pengguna"       : _getValue(data[107]),                           // String
        "pemilik_id"                          : _tryParseInt(_getValue(data[108])),             // int
        "lainnya"                             : _getValue(data[109]),                           // String
        "keterangan"                          : _getValue(data[110]),                           // String
        "tahun"                               : _tryParseInt(_getValue(data[111])),             // int
        "status"                              : 0
      }
    };

    Directory? directory = await getExternalStorageDirectory();
    
    if (directory != null) {
      String path = directory.path;
      String fileName = 'inventarisB-insert.json';
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
        '${ApiEndPoints.baseurl}${ApiEndPoints.authEndPoints.putInventaris}add/B',
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
  Future<void> updateInventarisB(String kib_id, List<String> data) async {
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
        "tgl_inventaris"                      : _getValue(data[0]),                             // date
        "no_register_awal"                    : _tryParseInt(_getValue(data[1])),               // int
        "no_register_akhir"                   : _tryParseInt(_getValue(data[2])),               // int
        "no_register_status"                  : _tryParseInt(_getValue(data[3])),               // int
        "kategori_id_awal"                    : _tryParseInt(_getValue(data[4])),               // int
        "kategori_id_akhir"                   : _tryParseInt(_getValue(data[5])),               // int
        "kategori_id_status"                  : _tryParseInt(_getValue(data[6])),               // int
        "nama_spesifikasi_awal"               : _getValue(data[7]),                             // String
        "nama_spesifikasi_akhir"              : _getValue(data[8]),                             // String
        "nama_spesifikasi_status"             : _tryParseInt(_getValue(data[9])),               // int
        "jumlah_awal"                         : _tryParseInt(_getValue(data[10])),              // int
        "satuan"                              : _getValue(data[11]),                            // String
        "cara_perolehan_awal"                 : _getValue(data[12]),                            // String
        "cara_perolehan_akhir"                : _getValue(data[13]),                            // String
        "cara_perolehan_status"               : _tryParseInt(_getValue(data[14])),              // int
        "tgl_perolehan"                       : _getValue(data[15]),                            // date
        "tahun_perolehan"                     : _tryParseInt(_getValue(data[16])),              // int
        "perolehan_awal"                      : _tryParseInt(removeDot(_getValue(data[17]))),   // int
        "perolehan_akhir"                     : _tryParseInt(removeDot(_getValue(data[18]))),   // int
        "perolehan_status"                    : _tryParseInt(_getValue(data[19])),              // int
        "atribusi_status"                     : _tryParseInt(_getValue(data[20])),              // int
        "atribusi_nibar"                      : _getValue(data[21]),                            // String
        "atribusi_kode_barang"                : _getValue(data[22]),                            // String
        "atribusi_kode_lokasi"                : _getValue(data[23]),                            // String
        "atribusi_no_register"                : _getValue(data[24]),                            // String
        "atribusi_nama_barang"                : _getValue(data[25]),                            // String
        "atribusi_spesifikasi_barang"         : _getValue(data[26]),                            // String
        "a_alamat_awal"                       : _getValue(data[27]),                            // String
        "a_alamat_status"                     : _tryParseInt(_getValue(data[28])),              // int
        "alamat_kota"                         : _getValue(data[29]),                            // String
        "alamat_kecamatan"                    : _getValue(data[30]),                            // String
        "alamat_kelurahan"                    : _getValue(data[31]),                            // String
        "alamat_jalan"                        : _getValue(data[32]),                            // String
        "alamat_no"                           : _getValue(data[33]),                            // String
        "alamat_rt"                           : _getValue(data[34]),                            // String
        "alamat_rw"                           : _getValue(data[35]),                            // String
        "alamat_kodepos"                      : _getValue(data[36]),                            // String
        "b_merk_awal"                         : _getValue(data[37]),                            // String
        "b_merk_akhir"                        : _getValue(data[38]),                            // String
        "b_merk_status"                       : _tryParseInt(_getValue(data[39])),              // int
        "b_cc_awal"                           : _getValue(data[40]),                            // String
        "b_cc_akhir"                          : _getValue(data[41]),                            // String
        "b_cc_status"                         : _tryParseInt(_getValue(data[42])),              // int
        "b_nomor_polisi_awal"                 : _getValue(data[43]),                            // String
        "b_nomor_polisi_akhir"                : _getValue(data[44]),                            // String
        "b_nomor_polisi_status"               : _tryParseInt(_getValue(data[45])),              // int
        "b_nomor_rangka_awal"                 : _getValue(data[46]),                            // String
        "b_nomor_rangka_akhir"                : _getValue(data[47]),                            // String
        "b_nomor_rangka_status"               : _tryParseInt(_getValue(data[48])),              // int
        "b_nomor_mesin_awal"                  : _getValue(data[49]),                            // String
        "b_nomor_mesin_akhir"                 : _getValue(data[50]),                            // String
        "b_nomor_mesin_status"                : _tryParseInt(_getValue(data[51])),              // int
        "b_nomor_bpkb_awal"                   : _getValue(data[52]),                            // String
        "b_nomor_bpkb_akhir"                  : _getValue(data[53]),                            // String
        "b_nomor_bpkb_status"                 : _tryParseInt(_getValue(data[54])),              // int
        "b_bahan_awal"                        : _getValue(data[55]),                            // String
        "b_bahan_akhir"                       : _getValue(data[56]),                            // String
        "b_bahan_status"                      : _tryParseInt(_getValue(data[57])),              // int
        "b_nomor_pabrik_awal"                 : _getValue(data[58]),                            // String
        "b_nomor_pabrik_akhir"                : _getValue(data[59]),                            // String
        "b_nomor_pabrik_status"               : _tryParseInt(_getValue(data[60])),              // int
        "kartu_inv_awal"                      : _getValue(data[61]),                            // String
        "kartu_inv_akhir"                     : _getValue(data[62]),                            // String
        "kartu_inv_status"                    : _tryParseInt(_getValue(data[63])),              // int
        "barcode_barang"                      : _tryParseInt(_getValue(data[64])),              // int
        "barcode_ruangan"                     : _tryParseInt(_getValue(data[65])),              // int
        "keberadaan_barang_status"            : _tryParseInt(_getValue(data[66])),              // int
        "kondisi_awal"                        : _getValue(data[67]),                            // String
        "kondisi_akhir"                       : _getValue(data[68]),                            // String
        "kondisi_status"                      : _tryParseInt(_getValue(data[69])),              // int
        "asal_usul_awal"                      : _getValue(data[70]),                            // String
        "asal_usul_akhir"                     : _getValue(data[71]),                            // String
        "asal_usul_status"                    : _tryParseInt(_getValue(data[72])),              // int
        "penggunaan_status"                   : _tryParseInt(_getValue(data[73])),              // int
        "penggunaan_awal"                     : _getValue(data[74]),                            // String
        "penggunaan_pemda_status"             : _tryParseInt(_getValue(data[75])),              // int
        "penggunaan_pemda_akhir"              : _getValue(data[76]),                            // String
        "penggunaan_pemda_nama_pemakai"       : _getValue(data[77]),                            // String
        "penggunaan_pemda_nama_pemakai_akhir" : _getValue(data[78]),                            // String
        "penggunaan_pemda_nama_pemakai_status": _tryParseInt(_getValue(data[79])),              // int
        "penggunaan_pemda_status_pemakai"     : _getValue(data[80]),                            // String
        "penggunaan_pemda_bast_pemakaian"     : _tryParseInt(_getValue(data[81])),              // int
        "penggunaan_pempus_status"            : _tryParseInt(_getValue(data[82])),              // int
        "penggunaan_pempus_yt"                : _tryParseInt(_getValue(data[83])),              // int
        "penggunaan_pempus_y_nm"              : _getValue(data[84]),                            // String
        "penggunaan_pempus_y_doc"             : _getValue(data[85]),                            // String
        "penggunaan_pempus_t_nm"              : _getValue(data[86]),                            // String
        "penggunaan_pdl_status"               : _tryParseInt(_getValue(data[87])),              // int
        "penggunaan_pdl_yt"                   : _tryParseInt(_getValue(data[88])),              // int
        "penggunaan_pdl_y_nm"                 : _getValue(data[89]),                            // String
        "penggunaan_pdl_y_doc"                : _getValue(data[90]),                            // String
        "penggunaan_pdl_t_nm"                 : _getValue(data[91]),                            // String
        "penggunaan_pl_status"                : _tryParseInt(_getValue(data[92])),              // int
        "penggunaan_pl_yt"                    : _tryParseInt(_getValue(data[93])),              // int
        "penggunaan_pl_y_nm"                  : _getValue(data[94]),                            // String
        "penggunaan_pl_y_doc"                 : _getValue(data[95]),                            // String
        "penggunaan_pl_t_nm"                  : _getValue(data[96]),                            // String
        "tercatat_ganda"                      : _tryParseInt(_getValue(data[97])),              // int
        "tercatat_ganda_nibar"                : _getValue(data[98]),                            // String
        "tercatat_ganda_no_register"          : _getValue(data[99]),                            // String
        "tercatat_ganda_kode_barang"          : _getValue(data[100]),                           // String
        "tercatat_ganda_nama_barang"          : _getValue(data[101]),                           // String
        "tercatat_ganda_spesifikasi_barang"   : _getValue(data[102]),                           // String
        "tercatat_ganda_luas"                 : _getValue(data[103]),                           // String
        "tercatat_ganda_satuan"               : _getValue(data[104]),                           // String
        "tercatat_ganda_perolehan"            : _getValue(data[105]),                           // String
        "tercatat_ganda_tanggal_perolehan"    : _getValue(data[106]),                           // date
        "tercatat_ganda_kuasa_pengguna"       : _getValue(data[107]),                           // String
        "pemilik_id"                          : _tryParseInt(_getValue(data[108])),             // int
        "lainnya"                             : _getValue(data[109]),                           // String
        "keterangan"                          : _getValue(data[110]),                           // String
        "tahun"                               : _tryParseInt(_getValue(data[111])),             // int
      }
    };

    // Membuat File JSON
    Directory? directory = await getExternalStorageDirectory();
    
    if (directory != null) {
      String path = directory.path;
      String fileName = 'inventarisB-update.json';
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
        '${ApiEndPoints.baseurl}${ApiEndPoints.authEndPoints.putInventaris}B/edit/$kib_id',
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

