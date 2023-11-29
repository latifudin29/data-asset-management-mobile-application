import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kib_application/utils/apiEndpoints.dart';
import 'package:kib_application/utils/snackbar.dart';

class InventoryBController extends GetxController {
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
      jumlah_akhir,
      jumlah_status,
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
      b_merk_awal,
      b_merk_akhir,
      b_merk_status,
      b_cc_awal,
      b_cc_akhir,
      b_cc_status,
      b_nomor_polisi_awal,
      b_nomor_polisi_akhir,
      b_nomor_polisi_status,
      b_nomor_rangka_awal,
      b_nomor_rangka_akhir,
      b_nomor_rangka_status,
      b_nomor_mesin_awal,
      b_nomor_mesin_akhir,
      b_nomor_mesin_status,
      b_nomor_bpkb_awal,
      b_nomor_bpkb_akhir,
      b_nomor_bpkb_status,
      b_bahan_awal,
      b_bahan_akhir,
      b_bahan_status,
      b_nomor_pabrik_awal,
      b_nomor_pabrik_akhir,
      b_nomor_pabrik_status,
      kartu_inv_awal,
      kartu_inv_akhir,
      kartu_inv_status,
      barcode_barang,
      barcode_barang_akhir,
      barcode_ruangan,
      barcode_ruangan_akhir,
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
    jumlah_akhir                         = TextEditingController();
    jumlah_status                        = TextEditingController();
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
    b_merk_awal                          = TextEditingController();
    b_merk_akhir                         = TextEditingController();
    b_merk_status                        = TextEditingController();
    b_cc_awal                            = TextEditingController();
    b_cc_akhir                           = TextEditingController();
    b_cc_status                          = TextEditingController();
    b_nomor_polisi_awal                  = TextEditingController();
    b_nomor_polisi_akhir                 = TextEditingController();
    b_nomor_polisi_status                = TextEditingController();
    b_nomor_rangka_awal                  = TextEditingController();
    b_nomor_rangka_akhir                 = TextEditingController();
    b_nomor_rangka_status                = TextEditingController();
    b_nomor_mesin_awal                   = TextEditingController();
    b_nomor_mesin_akhir                  = TextEditingController();
    b_nomor_mesin_status                 = TextEditingController();
    b_nomor_bpkb_awal                    = TextEditingController();
    b_nomor_bpkb_akhir                   = TextEditingController();
    b_nomor_bpkb_status                  = TextEditingController();
    b_bahan_awal                         = TextEditingController();
    b_bahan_akhir                        = TextEditingController();
    b_bahan_status                       = TextEditingController();
    b_nomor_pabrik_awal                  = TextEditingController();
    b_nomor_pabrik_akhir                 = TextEditingController();
    b_nomor_pabrik_status                = TextEditingController();
    kartu_inv_awal                       = TextEditingController();
    kartu_inv_akhir                      = TextEditingController();
    kartu_inv_status                     = TextEditingController();
    barcode_barang                       = TextEditingController();
    barcode_barang_akhir                 = TextEditingController();
    barcode_ruangan                      = TextEditingController();
    barcode_ruangan_akhir                = TextEditingController();
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
    lainnya                              = TextEditingController();
    keterangan                           = TextEditingController();
    file_nm                              = TextEditingController();
    petugas                              = TextEditingController();
  }

  Future<void> updateInventarisA(String kib_id, List<String> data) async {
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
        "jumlah_akhir"                     : _tryParseInt(_getValue(data[14])),   // int
        "jumlah_status"                    : _tryParseInt(_getValue(data[15])),   // int
        "a_luas_m2_awal"                   : _tryParseInt(_getValue(data[16])),   // int
        "a_luas_m2_akhir"                  : _tryParseInt(_getValue(data[17])),   // int
        "a_luas_m2_status"                 : _tryParseInt(_getValue(data[18])),   // int
        "satuan"                           : _getValue(data[19]),                 // String
        "cara_perolehan_awal"              : _getValue(data[20]),                 // String
        "cara_perolehan_akhir"             : _getValue(data[21]),                 // String
        "cara_perolehan_status"            : _tryParseInt(_getValue(data[22])),   // int
        "tgl_perolehan"                    : _getValue(data[23]),                 // date
        "tahun_perolehan"                  : _tryParseInt(_getValue(data[24])),   // int
        "perolehan_awal"                   : _tryParseInt(_getValue(data[25])),   // int
        "perolehan_akhir"                  : _tryParseInt(_getValue(data[26])),   // int
        "perolehan_status"                 : _tryParseInt(_getValue(data[27])),   // int
        "atribusi_status"                  : _tryParseInt(_getValue(data[28])),   // int
        "atribusi_nibar"                   : _getValue(data[29]),                 // String
        "atribusi_kode_barang"             : _getValue(data[30]),                 // String
        "atribusi_kode_lokasi"             : _getValue(data[31]),                 // String
        "atribusi_no_register"             : _getValue(data[32]),                 // String
        "atribusi_nama_barang"             : _getValue(data[33]),                 // String
        "atribusi_spesifikasi_barang"      : _getValue(data[34]),                 // String
        "a_alamat_awal"                    : _getValue(data[35]),                 // String
        "a_alamat_status"                  : _tryParseInt(_getValue(data[36])),   // int
        "alamat_kota"                      : _getValue(data[37]),                 // String
        "alamat_kecamatan"                 : _getValue(data[38]),                 // String
        "alamat_kelurahan"                 : _getValue(data[39]),                 // String
        "alamat_jalan"                     : _getValue(data[40]),                 // String
        "alamat_no"                        : _getValue(data[41]),                 // String
        "alamat_rt"                        : _getValue(data[42]),                 // String
        "alamat_rw"                        : _getValue(data[43]),                 // String
        "alamat_kodepos"                   : _getValue(data[44]),                 // String
        "a_hak_tanah_awal"                 : _getValue(data[45]),                 // String
        "a_hak_tanah_akhir"                : _getValue(data[46]),                 // String
        "a_hak_tanah_status"               : _tryParseInt(_getValue(data[47])),   // int
        "a_sertifikat_nomor_awal"          : _getValue(data[48]),                 // String
        "a_sertifikat_nomor_akhir"         : _getValue(data[49]),                 // String
        "a_sertifikat_nomor_status"        : _tryParseInt(_getValue(data[50])),   // int
        "a_sertifikat_tanggal_awal"        : _getValue(data[51]),                 // date
        "a_sertifikat_tanggal_akhir"       : _getValue(data[52]),                 // date
        "a_sertifikat_tanggal_status"      : _tryParseInt(_getValue(data[53])),   // int
        "keberadaan_barang_status"         : _tryParseInt(_getValue(data[54])),   // int
        "kondisi_awal"                     : _getValue(data[55]),                 // String
        "kondisi_akhir"                    : _getValue(data[56]),                 // String
        "kondisi_status"                   : _tryParseInt(_getValue(data[57])),   // int
        "asal_usul_awal"                   : _getValue(data[58]),                 // String
        "asal_usul_akhir"                  : _getValue(data[59]),                 // String
        "asal_usul_status"                 : _tryParseInt(_getValue(data[60])),   // int
        "penggunaan_status"                : _tryParseInt(_getValue(data[61])),   // int
        "penggunaan_awal"                  : _getValue(data[62]),                 // String
        "penggunaan_pemda_status"          : _tryParseInt(_getValue(data[63])),   // int
        "penggunaan_pemda_akhir"           : _getValue(data[64]),                 // String
        "penggunaan_pempus_status"         : _tryParseInt(_getValue(data[65])),   // int
        "penggunaan_pempus_yt"             : _tryParseInt(_getValue(data[66])),   // int
        "penggunaan_pempus_y_nm"           : _getValue(data[67]),                 // String
        "penggunaan_pempus_y_doc"          : _getValue(data[68]),                 // String
        "penggunaan_pempus_t_nm"           : _getValue(data[69]),                 // String
        "penggunaan_pdl_status"            : _tryParseInt(_getValue(data[70])),   // int
        "penggunaan_pdl_yt"                : _tryParseInt(_getValue(data[71])),   // int
        "penggunaan_pdl_y_nm"              : _getValue(data[72]),                 // String
        "penggunaan_pdl_y_doc"             : _getValue(data[73]),                 // String
        "penggunaan_pdl_t_nm"              : _getValue(data[74]),                 // String
        "penggunaan_pl_status"             : _tryParseInt(_getValue(data[75])),   // int
        "penggunaan_pl_yt"                 : _tryParseInt(_getValue(data[76])),   // int
        "penggunaan_pl_y_nm"               : _getValue(data[77]),                 // String
        "penggunaan_pl_y_doc"              : _getValue(data[78]),                 // String
        "penggunaan_pl_t_nm"               : _getValue(data[79]),                 // String
        "tercatat_ganda"                   : _tryParseInt(_getValue(data[80])),   // int
        "tercatat_ganda_nibar"             : _getValue(data[81]),                 // String
        "tercatat_ganda_no_register"       : _getValue(data[82]),                 // String
        "tercatat_ganda_kode_barang"       : _getValue(data[83]),                 // String
        "tercatat_ganda_nama_barang"       : _getValue(data[84]),                 // String
        "tercatat_ganda_spesifikasi_barang": _getValue(data[85]),                 // String
        "tercatat_ganda_luas"              : _getValue(data[86]),                 // String
        "tercatat_ganda_satuan"            : _getValue(data[87]),                 // String
        "tercatat_ganda_perolehan"         : _getValue(data[88]),                 // String
        "tercatat_ganda_tanggal_perolehan" : _getValue(data[89]),                 // date
        "tercatat_ganda_kuasa_pengguna"    : _getValue(data[90]),                 // String
        "pemilik_id"                       : _tryParseInt(_getValue(data[91])),   // int
        "lat"                              : _getValue(data[92]),                 // String
        "long"                             : _getValue(data[93]),                 // String
        "lainnya"                          : _getValue(data[94]),                 // String
        "keterangan"                       : _getValue(data[95]),                 // String
        "file_nm"                          : _getValue(data[96]),                 // json
        "petugas"                          : _getValue(data[97]),                 // json
        "tahun"                            : _tryParseInt(_getValue(data[98])),   // int
      }
    };

    // try {
    //   final response = await _connect.put(
    //     '${ApiEndPoints.baseurl}${ApiEndPoints.authEndPoints.putInventaris}B/edit/$kib_id',
    //     body,
    //   );

    //   if (response.statusCode == 200) {
    //     Get.back();
    //     customSnackBar("Success", response.body['message'], 'success');
    //   } else {
    //     print("Error: ${response.statusCode}");
    //     print("Response Body: ${response.body}");
    //     customSnackBar("Error", "Failed to update data!", 'error');
    //   }
    // } catch (error) {
    //   print("Error: $error");
    //   customSnackBar("Error", "An unexpected error occurred!", 'error');
    // }
  }
}

