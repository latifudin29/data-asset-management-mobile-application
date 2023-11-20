import 'package:get/get.dart';
import 'package:flutter/material.dart';

class InventoryAController extends GetxController {
  late TextEditingController tgl_inventaris,
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
      a_luas_m2_awal,
      a_luas_m2_akhir,
      a_luas_m2_status,
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
      a_hak_tanah_awal,
      a_hak_tanah_akhir,
      a_hak_tanah_status,
      a_sertifikat_nomor_awal,
      a_sertifikat_nomor_akhir,
      a_sertifikat_nomor_status,
      a_sertifikat_tanggal_awal,
      a_sertifikat_tanggal_akhir,
      a_sertifikat_tanggal_status,
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
    tgl_inventaris = TextEditingController();
    skpd = TextEditingController();
    skpd_uraian = TextEditingController();
    no_register_awal = TextEditingController();
    no_register_akhir = TextEditingController();
    barang = TextEditingController();
    kategori_id_awal = TextEditingController();
    kategori_id_akhir = TextEditingController();
    kategori_id_status = TextEditingController();
    nama_spesifikasi_awal = TextEditingController();
    nama_spesifikasi_akhir = TextEditingController();
    nama_spesifikasi_status = TextEditingController();
    jumlah_awal = TextEditingController();
    jumlah_akhir = TextEditingController();
    jumlah_status = TextEditingController();
    a_luas_m2_awal = TextEditingController();
    a_luas_m2_akhir = TextEditingController();
    a_luas_m2_status = TextEditingController();
    satuan = TextEditingController();
    cara_perolehan_awal = TextEditingController();
    cara_perolehan_akhir = TextEditingController();
    cara_perolehan_status = TextEditingController();
    tgl_perolehan = TextEditingController();
    tahun_perolehan = TextEditingController();
    perolehan_awal = TextEditingController();
    perolehan_akhir = TextEditingController();
    perolehan_status = TextEditingController();
    atribusi_status = TextEditingController();
    atribusi_nibar = TextEditingController();
    atribusi_kode_barang = TextEditingController();
    atribusi_kode_lokasi = TextEditingController();
    atribusi_no_register = TextEditingController();
    atribusi_nama_barang = TextEditingController();
    atribusi_spesifikasi_barang = TextEditingController();
    a_alamat_awal = TextEditingController();
    a_alamat_akhir = TextEditingController();
    a_alamat_status = TextEditingController();
    alamat_kota = TextEditingController();
    alamat_kecamatan = TextEditingController();
    alamat_kelurahan = TextEditingController();
    alamat_jalan = TextEditingController();
    alamat_no = TextEditingController();
    alamat_rt = TextEditingController();
    alamat_rw = TextEditingController();
    alamat_kodepos = TextEditingController();
    a_hak_tanah_awal = TextEditingController();
    a_hak_tanah_akhir = TextEditingController();
    a_hak_tanah_status = TextEditingController();
    a_sertifikat_nomor_awal = TextEditingController();
    a_sertifikat_nomor_akhir = TextEditingController();
    a_sertifikat_nomor_status = TextEditingController();
    a_sertifikat_tanggal_awal = TextEditingController();
    a_sertifikat_tanggal_akhir = TextEditingController();
    a_sertifikat_tanggal_status = TextEditingController();
    keberadaan_barang_status = TextEditingController();
    kondisi_awal = TextEditingController();
    kondisi_akhir = TextEditingController();
    kondisi_status = TextEditingController();
    asal_usul_awal = TextEditingController();
    asal_usul_akhir = TextEditingController();
    asal_usul_status = TextEditingController();
    penggunaan_status = TextEditingController();
    penggunaan_awal = TextEditingController();
    penggunaan_pemda_status = TextEditingController();
    penggunaan_pemda_akhir = TextEditingController();
    penggunaan_pempus_status = TextEditingController();
    penggunaan_pempus_yt = TextEditingController();
    penggunaan_pempus_y_nm = TextEditingController();
    penggunaan_pempus_y_doc = TextEditingController();
    penggunaan_pempus_t_nm = TextEditingController();
    penggunaan_pdl_status = TextEditingController();
    penggunaan_pdl_yt = TextEditingController();
    penggunaan_pdl_y_nm = TextEditingController();
    penggunaan_pdl_y_doc = TextEditingController();
    penggunaan_pdl_t_nm = TextEditingController();
    penggunaan_pl_status = TextEditingController();
    penggunaan_pl_yt = TextEditingController();
    penggunaan_pl_y_nm = TextEditingController();
    penggunaan_pl_y_doc = TextEditingController();
    penggunaan_pl_t_nm = TextEditingController();
    tercatat_ganda = TextEditingController();
    tercatat_ganda_nibar = TextEditingController();
    tercatat_ganda_no_register = TextEditingController();
    tercatat_ganda_kode_barang = TextEditingController();
    tercatat_ganda_nama_barang = TextEditingController();
    tercatat_ganda_spesifikasi_barang = TextEditingController();
    tercatat_ganda_luas = TextEditingController();
    tercatat_ganda_satuan = TextEditingController();
    tercatat_ganda_perolehan = TextEditingController();
    tercatat_ganda_tanggal_perolehan = TextEditingController();
    tercatat_ganda_kuasa_pengguna = TextEditingController();
    pemilik_id = TextEditingController();
    lat = TextEditingController();
    long = TextEditingController();
    lainnya = TextEditingController();
    keterangan = TextEditingController();
    file_nm = TextEditingController();
    petugas = TextEditingController();
  }
}

Future<void> editInsertInventarisA() async {}
