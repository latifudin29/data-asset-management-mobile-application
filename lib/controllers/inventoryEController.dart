import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:kib_application/utils/apiEndpoints.dart';
import 'package:kib_application/utils/snackbar.dart';

class InventoryEController extends GetxController {
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
      satuan,
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
      alamat_kecamatan,
      alamat_kelurahan,
      alamat_jalan,
      alamat_no,
      alamat_rt,
      alamat_rw,
      alamat_kodepos,
      e_spek_awal,
      e_spek_akhir,
      e_judul_awal,
      e_judul_akhir,
      e_jenis_awal,
      e_jenis_akhir,
      e_bahan_awal,
      e_bahan_akhir,
      e_pencipta_awal,
      e_pencipta_akhir,
      e_ukuran_awal,
      e_ukuran_akhir,
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
    satuan                            = TextEditingController();
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
    alamat_kecamatan                  = TextEditingController();
    alamat_kelurahan                  = TextEditingController();
    alamat_jalan                      = TextEditingController();
    alamat_no                         = TextEditingController();
    alamat_rt                         = TextEditingController();
    alamat_rw                         = TextEditingController();
    alamat_kodepos                    = TextEditingController();
    e_spek_awal                       = TextEditingController();
    e_spek_akhir                      = TextEditingController();
    e_judul_awal                      = TextEditingController();
    e_judul_akhir                     = TextEditingController();
    e_jenis_awal                      = TextEditingController();
    e_jenis_akhir                     = TextEditingController();
    e_bahan_awal                      = TextEditingController();
    e_bahan_akhir                     = TextEditingController();
    e_pencipta_awal                   = TextEditingController();
    e_pencipta_akhir                  = TextEditingController();
    e_ukuran_awal                     = TextEditingController();
    e_ukuran_akhir                    = TextEditingController();
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
    lainnya                           = TextEditingController();
    keterangan                        = TextEditingController();
    file_nm                           = TextEditingController();
    petugas                           = TextEditingController();
    tahun                             = TextEditingController();
  }

  // Method Insert Inventarisasi
  Future<void> insertInventarisE( List<String> id, List<dynamic> data) async {}

  // Method Update Inventarisasi
  Future<void> updateInventarisE(String kib_id, List<dynamic> data) async {}
}