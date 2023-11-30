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
      kategori_id_akhir,
      kategori_id_status,
      nama_spesifikasi_awal,
      nama_spesifikasi_akhir,
      nama_spesifikasi_status,
      jumlah_awal,
      satuan,
      cara_perolehan_awal,
      tgl_perolehan,
      tahun_perolehan,
      perolehan_awal,
      perolehan_akhir,
      perolehan_status,
      atribusi_nibar,
      atribusi_kode_barang,
      atribusi_kode_lokasi,
      atribusi_no_register,
      atribusi_nama_barang,
      atribusi_spesifikasi_barang,
      a_alamat_awal,
      alamat_kota,
      alamat_kecamatan,
      alamat_kelurahan,
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
      kartu_inv_akhir,
      barcode_barang,
      barcode_barang_akhir,
      barcode_ruangan,
      barcode_ruangan_akhir,
      kondisi_awal,
      kondisi_akhir,
      asal_usul_awal,
      asal_usul_akhir,
      penggunaan_awal,
      penggunaan_pemda_akhir,
      penggunaan_pemda_nama_pemakai,
      penggunaan_pemda_nama_pemakai_status,
      penggunaan_pemda_nama_pemakai_akhir,
      penggunaan_pemda_bast_pemakaian,
      penggunaan_pempus_yt,
      penggunaan_pempus_y_nm,
      penggunaan_pempus_y_doc,
      penggunaan_pempus_t_nm,
      penggunaan_pdl_yt,
      penggunaan_pdl_y_nm,
      penggunaan_pdl_y_doc,
      penggunaan_pdl_t_nm,
      penggunaan_pl_yt,
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
    tgl_perolehan                        = TextEditingController();
    tahun_perolehan                      = TextEditingController();
    perolehan_awal                       = TextEditingController();
    perolehan_akhir                      = TextEditingController();
    perolehan_status                     = TextEditingController();
    atribusi_nibar                       = TextEditingController();
    atribusi_kode_barang                 = TextEditingController();
    atribusi_kode_lokasi                 = TextEditingController();
    atribusi_no_register                 = TextEditingController();
    atribusi_nama_barang                 = TextEditingController();
    atribusi_spesifikasi_barang          = TextEditingController();
    a_alamat_awal                        = TextEditingController();
    alamat_kota                          = TextEditingController();
    alamat_kecamatan                     = TextEditingController();
    alamat_kelurahan                     = TextEditingController();
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
    kartu_inv_akhir                      = TextEditingController();
    barcode_barang                       = TextEditingController();
    barcode_barang_akhir                 = TextEditingController();
    barcode_ruangan                      = TextEditingController();
    barcode_ruangan_akhir                = TextEditingController();
    kondisi_awal                         = TextEditingController();
    kondisi_akhir                        = TextEditingController();
    asal_usul_awal                       = TextEditingController();
    asal_usul_akhir                      = TextEditingController();
    penggunaan_awal                      = TextEditingController();
    penggunaan_pemda_akhir               = TextEditingController();
    penggunaan_pemda_nama_pemakai        = TextEditingController();
    penggunaan_pemda_nama_pemakai_status = TextEditingController();
    penggunaan_pemda_nama_pemakai_akhir  = TextEditingController();
    penggunaan_pemda_bast_pemakaian      = TextEditingController();
    penggunaan_pempus_yt                 = TextEditingController();
    penggunaan_pempus_y_nm               = TextEditingController();
    penggunaan_pempus_y_doc              = TextEditingController();
    penggunaan_pempus_t_nm               = TextEditingController();
    penggunaan_pdl_yt                    = TextEditingController();
    penggunaan_pdl_y_nm                  = TextEditingController();
    penggunaan_pdl_y_doc                 = TextEditingController();
    penggunaan_pdl_t_nm                  = TextEditingController();
    penggunaan_pl_yt                     = TextEditingController();
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
  }

  // Method Insert Inventarisasi
  Future<void> insertInventarisB(List<String> data) async {}

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
        "penetapan_id"                     : _tryParseInt(_getValue(data[0])),    // int
        "kib_id"                           : _tryParseInt(_getValue(data[1])),    // int
        "departemen_id"                    : _tryParseInt(_getValue(data[2])),    // int
        
        "tgl_inventaris"                   : _getValue(data[3]),                  // date
        "no_register_awal"                 : _tryParseInt(_getValue(data[4])),    // int
        "no_register_akhir"                : _tryParseInt(_getValue(data[5])),    // int
        "no_register_status"               : _tryParseInt(_getValue(data[6])),    // int
        "kategori_id_awal"                 : _tryParseInt(_getValue(data[7])),    // int
        "kategori_id_akhir"                : _tryParseInt(_getValue(data[8])),    // int
        "kategori_id_status"               : _tryParseInt(_getValue(data[9])),    // int
        "nama_spesifikasi_awal"            : _getValue(data[10]),                 // String
        "nama_spesifikasi_akhir"           : _getValue(data[11]),                 // String
        "nama_spesifikasi_status"          : _tryParseInt(_getValue(data[12])),   // int
        "jumlah_awal"                      : _tryParseInt(_getValue(data[13])),   // int
        "satuan"                           : _getValue(data[14]),                 // String
        "cara_perolehan_awal"              : _getValue(data[15]),                 // String
        "cara_perolehan_akhir"             : _getValue(data[16]),                 // String
        "cara_perolehan_status"            : _tryParseInt(_getValue(data[17])),   // int
        "tgl_perolehan"                    : _getValue(data[18]),                 // date
        "tahun_perolehan"                  : _tryParseInt(_getValue(data[19])),   // int
        "perolehan_awal"                   : _tryParseInt(_getValue(data[20])),   // int
        "perolehan_akhir"                  : _tryParseInt(_getValue(data[21])),   // int
        "perolehan_status"                 : _tryParseInt(_getValue(data[22])),   // int
        "atribusi_status"                  : _tryParseInt(_getValue(data[23])),   // int
        "atribusi_nibar"                   : _getValue(data[24]),                 // String
        "atribusi_kode_barang"             : _getValue(data[25]),                 // String
        "atribusi_kode_lokasi"             : _getValue(data[26]),                 // String
        "atribusi_no_register"             : _getValue(data[27]),                 // String
        "atribusi_nama_barang"             : _getValue(data[28]),                 // String
        "atribusi_spesifikasi_barang"      : _getValue(data[29]),                 // String
        "a_alamat_awal"                    : _getValue(data[30]),                 // String
        "a_alamat_status"                  : _tryParseInt(_getValue(data[31])),   // int
        "alamat_kota"                      : _getValue(data[32]),                 // String
        "alamat_kecamatan"                 : _getValue(data[33]),                 // String
        "alamat_kelurahan"                 : _getValue(data[34]),                 // String
        "alamat_jalan"                     : _getValue(data[35]),                 // String
        "alamat_no"                        : _getValue(data[36]),                 // String
        "alamat_rt"                        : _getValue(data[37]),                 // String
        "alamat_rw"                        : _getValue(data[38]),                 // String
        "alamat_kodepos"                   : _getValue(data[39]),                 // String
        
        "b_merk_awal"          : data[40],
        "b_merk_akhir"         : data[41],
        "b_merk_status"        : data[42],
        "b_cc_awal"            : data[43],
        "b_cc_akhir"           : data[44],
        "b_cc_status"          : data[45],
        "b_nomor_polisi_awal"  : data[46],
        "b_nomor_polisi_akhir" : data[47],
        "b_nomor_polisi_status": data[48],
        "b_nomor_rangka_awal"  : data[49],
        "b_nomor_rangka_akhir" : data[50],
        "b_nomor_rangka_status": data[51],
        "b_nomor_mesin_awal"   : data[52],
        "b_nomor_mesin_akhir"  : data[53],
        "b_nomor_mesin_status" : data[54],
        "b_nomor_bpkb_awal"    : data[55],
        "b_nomor_bpkb_akhir"   : data[56],
        "b_nomor_bpkb_status"  : data[57],
        "b_bahan_awal"         : data[58],
        "b_bahan_akhir"        : data[59],
        "b_bahan_status"       : data[60],
        "b_nomor_pabrik_awal"  : data[61],
        "b_nomor_pabrik_akhir" : data[62],
        "b_nomor_pabrik_status": data[63],
        "kartu_inv_awal"       : data[64],
        "kartu_inv_akhir"      : data[65],
        "kartu_inv_status"     : data[66],
        "barcode_barang"       : data[67],
        "barcode_barang_akhir" : data[68],
        "barcode_ruangan"      : data[69],
        "barcode_ruangan_akhir": data[70],
        
        "keberadaan_barang_status"         : _tryParseInt(_getValue(data[71])),   // int
        "kondisi_awal"                     : _getValue(data[72]),                 // String
        "kondisi_akhir"                    : _getValue(data[73]),                 // String
        "kondisi_status"                   : _tryParseInt(_getValue(data[74])),   // int
        "asal_usul_awal"                   : _getValue(data[75]),                 // String
        "asal_usul_akhir"                  : _getValue(data[76]),                 // String
        "asal_usul_status"                 : _tryParseInt(_getValue(data[77])),   // int
        "penggunaan_status"                : _tryParseInt(_getValue(data[78])),   // int
        "penggunaan_awal"                  : _getValue(data[79]),                 // String
        "penggunaan_pemda_status"          : _tryParseInt(_getValue(data[80])),   // int
        "penggunaan_pemda_akhir"           : _getValue(data[81]),                 // String
        "penggunaan_pempus_status"         : _tryParseInt(_getValue(data[82])),   // int
        "penggunaan_pempus_yt"             : _tryParseInt(_getValue(data[83])),   // int
        "penggunaan_pempus_y_nm"           : _getValue(data[84]),                 // String
        "penggunaan_pempus_y_doc"          : _getValue(data[85]),                 // String
        "penggunaan_pempus_t_nm"           : _getValue(data[86]),                 // String
        "penggunaan_pdl_status"            : _tryParseInt(_getValue(data[87])),   // int
        "penggunaan_pdl_yt"                : _tryParseInt(_getValue(data[88])),   // int
        "penggunaan_pdl_y_nm"              : _getValue(data[89]),                 // String
        "penggunaan_pdl_y_doc"             : _getValue(data[90]),                 // String
        "penggunaan_pdl_t_nm"              : _getValue(data[91]),                 // String
        "penggunaan_pl_status"             : _tryParseInt(_getValue(data[92])),   // int
        "penggunaan_pl_yt"                 : _tryParseInt(_getValue(data[93])),   // int
        "penggunaan_pl_y_nm"               : _getValue(data[94]),                 // String
        "penggunaan_pl_y_doc"              : _getValue(data[95]),                 // String
        "penggunaan_pl_t_nm"               : _getValue(data[96]),                 // String
        "tercatat_ganda"                   : _tryParseInt(_getValue(data[97])),   // int
        "tercatat_ganda_nibar"             : _getValue(data[98]),                 // String
        "tercatat_ganda_no_register"       : _getValue(data[99]),                 // String
        "tercatat_ganda_kode_barang"       : _getValue(data[100]),                 // String
        "tercatat_ganda_nama_barang"       : _getValue(data[101]),                 // String
        "tercatat_ganda_spesifikasi_barang": _getValue(data[102]),                 // String
        "tercatat_ganda_luas"              : _getValue(data[103]),                 // String
        "tercatat_ganda_satuan"            : _getValue(data[104]),                 // String
        "tercatat_ganda_perolehan"         : _getValue(data[105]),                 // String
        "tercatat_ganda_tanggal_perolehan" : _getValue(data[106]),                 // date
        "tercatat_ganda_kuasa_pengguna"    : _getValue(data[107]),                 // String
        "pemilik_id"                       : _tryParseInt(_getValue(data[108])),   // int
        "lainnya"                          : _getValue(data[109]),                 // String
        "keterangan"                       : _getValue(data[110]),                 // String
        "file_nm"                          : _getValue(data[111]),                 // json
        "petugas"                          : _getValue(data[112]),                 // json
        "tahun"                            : _tryParseInt(_getValue(data[113])),   // int
      }
    };

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

    // Directory? directory = await getExternalStorageDirectory();
    
    // if (directory != null) {
    //   String path = directory.path;
    //   String fileName = 'inventarisB-output.json';
    //   String filePath = '$path/$fileName';
    //   String jsonString = jsonEncode(body);

    //   File file = File(filePath);
    //   await file.writeAsString(jsonString);

    //   print('File JSON disimpan di: $filePath');
    // } else {
    //   print('Error: Direktori penyimpanan eksternal null.');
    // }
  }
}

