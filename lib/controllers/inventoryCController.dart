import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kib_application/utils/apiEndpoints.dart';
import 'package:kib_application/utils/snackbar.dart';

class InventoryCController extends GetxController {
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
      c_luas_lantai,
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
      // 
      c_bertingkat,
      c_beton,
      c_luas_tanah_awal,
      c_luas_tanah_akhir,
      c_luas_tanah_status,
      c_satuan_tanah,
      c_status_tanah,
      // 
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
      lat,
      long,
      lainnya,
      keterangan,
      file_nm,
      petugas;

  @override
  void onInit() {
    super.onInit();
    kib_id                            = TextEditingController();
    tgl_inventaris                    = TextEditingController();
    skpd                              = TextEditingController();
    skpd_uraian                       = TextEditingController();
    no_register_awal                  = TextEditingController();
    no_register_akhir                 = TextEditingController();
    barang                            = TextEditingController();
    kategori_id_awal                  = TextEditingController();
    kategori_id_akhir                 = TextEditingController();
    kategori_id_status                = TextEditingController();
    nama_spesifikasi_awal             = TextEditingController();
    nama_spesifikasi_akhir            = TextEditingController();
    nama_spesifikasi_status           = TextEditingController();
    jumlah_awal                       = TextEditingController();
    c_luas_lantai                     = TextEditingController();
    satuan                            = TextEditingController();
    cara_perolehan_awal               = TextEditingController();
    cara_perolehan_akhir              = TextEditingController();
    cara_perolehan_status             = TextEditingController();
    tgl_perolehan                     = TextEditingController();
    tahun_perolehan                   = TextEditingController();
    perolehan_awal                    = TextEditingController();
    perolehan_akhir                   = TextEditingController();
    perolehan_status                  = TextEditingController();
    atribusi_status                   = TextEditingController();
    atribusi_nibar                    = TextEditingController();
    atribusi_kode_barang              = TextEditingController();
    atribusi_kode_lokasi              = TextEditingController();
    atribusi_no_register              = TextEditingController();
    atribusi_nama_barang              = TextEditingController();
    atribusi_spesifikasi_barang       = TextEditingController();
    a_alamat_awal                     = TextEditingController();
    a_alamat_akhir                    = TextEditingController();
    a_alamat_status                   = TextEditingController();
    alamat_kota                       = TextEditingController();
    alamat_kecamatan                  = TextEditingController();
    alamat_kelurahan                  = TextEditingController();
    alamat_jalan                      = TextEditingController();
    alamat_no                         = TextEditingController();
    alamat_rt                         = TextEditingController();
    alamat_rw                         = TextEditingController();
    alamat_kodepos                    = TextEditingController();
    c_bertingkat                      = TextEditingController();
    c_beton                           = TextEditingController();
    c_luas_tanah_awal                 = TextEditingController();
    c_luas_tanah_akhir                = TextEditingController();
    c_luas_tanah_status               = TextEditingController();
    c_satuan_tanah                    = TextEditingController();
    c_status_tanah                    = TextEditingController();
    keberadaan_barang_status          = TextEditingController();
    kondisi_awal                      = TextEditingController();
    kondisi_akhir                     = TextEditingController();
    kondisi_status                    = TextEditingController();
    asal_usul_awal                    = TextEditingController();
    asal_usul_akhir                   = TextEditingController();
    asal_usul_status                  = TextEditingController();
    penggunaan_status                 = TextEditingController();
    penggunaan_awal                   = TextEditingController();
    penggunaan_pemda_status           = TextEditingController();
    penggunaan_pemda_akhir            = TextEditingController();
    penggunaan_pempus_status          = TextEditingController();
    penggunaan_pempus_yt              = TextEditingController();
    penggunaan_pempus_y_nm            = TextEditingController();
    penggunaan_pempus_y_doc           = TextEditingController();
    penggunaan_pempus_t_nm            = TextEditingController();
    penggunaan_pdl_status             = TextEditingController();
    penggunaan_pdl_yt                 = TextEditingController();
    penggunaan_pdl_y_nm               = TextEditingController();
    penggunaan_pdl_y_doc              = TextEditingController();
    penggunaan_pdl_t_nm               = TextEditingController();
    penggunaan_pl_status              = TextEditingController();
    penggunaan_pl_yt                  = TextEditingController();
    penggunaan_pl_y_nm                = TextEditingController();
    penggunaan_pl_y_doc               = TextEditingController();
    penggunaan_pl_t_nm                = TextEditingController();
    tercatat_ganda                    = TextEditingController();
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
    pemilik_id                        = TextEditingController();
    lat                               = TextEditingController();
    long                              = TextEditingController();
    lainnya                           = TextEditingController();
    keterangan                        = TextEditingController();
    file_nm                           = TextEditingController();
    petugas                           = TextEditingController();
  }

  Future<void> editInsertInventarisC(String kib_id, List<String> data) async {
    String? _getValue(String value) {
      return value.isNotEmpty ? value : null;
    }

    String removeDot(String? value) {
      return value?.replaceAll('.', '') ?? '';
    }

    Map<String, dynamic> body = {
      "data": {
        "tgl_inventaris"         : _getValue(data[0]),
        "no_register_awal"       : int.tryParse(data[1]),
        "no_register_akhir"      : int.tryParse(data[2]),
        "no_register_status"     : int.tryParse(data[3]),
        "kategori_id_awal"       : int.tryParse(data[4]),
        "kategori_id_akhir"      : int.tryParse(data[5]),
        "kategori_id_status"     : int.tryParse(data[6]),
        "nama_spesifikasi_awal"  : _getValue(data[7]),
        "nama_spesifikasi_akhir" : _getValue(data[8]),
        "nama_spesifikasi_status": int.tryParse(data[9]),
        "jumlah_awal"            : int.tryParse(data[10]),
        "satuan"                 : _getValue(data[16]),
        "cara_perolehan_awal"    : _getValue(data[17]),
        "cara_perolehan_akhir"   : int.tryParse(data[18]),
        "cara_perolehan_status"  : int.tryParse(data[19]),
        "tgl_perolehan"          : _getValue(data[20]),
        "tahun_perolehan"        : int.tryParse(data[21]),
        "perolehan_awal"         : removeDot(_getValue(data[22])),
        "perolehan_akhir"        : removeDot(_getValue(data[23])),
        "perolehan_status"       : int.tryParse(data[24]),
      }
    };

    print(body);

    try {
      final response = await _connect.put(
        '${ApiEndPoints.baseurl}${ApiEndPoints.authEndPoints.putInventaris}C/edit/$kib_id',
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
