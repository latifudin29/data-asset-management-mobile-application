import 'package:get/get.dart';
import 'package:flutter/material.dart';

class InventoryAController extends GetxController {
  late TextEditingController a_tgl_inventaris,
      a_skpd,
      a_skpd_uraian,
      a_no_register_awal,
      a_no_register_akhir,
      a_no_register_status,
      a_kategori_id_awal,
      a_kategori_id_akhir,
      a_kategori_id_status,
      a_barang,
      // Nama spesifikasi barang (BELUM)
      a_jumlah_awal,
      a_jumlah_akhir,
      a_jumlah_status,
      a_luas_m2_awal,
      a_luas_m2_akhir,
      a_luas_m2_status,
      a_satuan,
      a_cara_perolehan_awal,
      a_cara_perolehan_akhir,
      a_cara_perolehan_status,
      a_tgl_perolehan,
      a_tahun_perolehan,
      a_perolehan_awal,
      a_perolehan_akhir,
      a_perolehan_status,
      // Apakah nilai perolehan merupakan biaya atribusi/biasa yang menambah kepasitas manfaat (BELUM)
      //
      a_alamat_awal,
      a_alamat_akhir,
      a_alamat_status,
      a_alamat_kota,
      a_alamat_kecamatan,
      a_alamat_kelurahan,
      a_alamat_jalan,
      a_alamat_no,
      a_alamat_rt,
      a_alamat_rw,
      a_alamat_kodepos,
      //
      a_hak_tanah_awal,
      a_hak_tanah_akhir,
      a_hak_tanah_status,
      a_sertifikat_nomor_awal,
      a_sertifikat_nomor_akhir,
      a_sertifikat_nomor_status,
      a_sertifikat_tanggal_awal,
      a_sertifikat_tanggal_akhir,
      a_sertifikat_tanggal_status,
      a_keberadaan_barang_awal,
      a_keberadaan_barang_akhir,
      a_kondisi_awal,
      a_kondisi_akhir,
      a_kondisi_status,
      a_asal_usul_awal,
      a_asal_usul_akhir,
      a_asal_usul_status,
      a_penggunaan_awal,
      a_penggunaan_akhir,
      a_penggunaan_status,
      a_pemilik_id,
      a_lat,
      a_long,
      a_lainnya,
      a_keterangan,
      a_file_nm,
      a_petugas;

  @override
  void onInit() {
    super.onInit();
    // INVENTARIS A
    a_tgl_inventaris = TextEditingController();
    a_skpd = TextEditingController();
    a_skpd_uraian = TextEditingController();
    a_no_register_awal = TextEditingController();
    a_no_register_akhir = TextEditingController();
    a_no_register_status = TextEditingController();
    a_kategori_id_awal = TextEditingController();
    a_kategori_id_akhir = TextEditingController();
    a_kategori_id_status = TextEditingController();
    a_barang = TextEditingController();
    // Nama spesifikasi barang (BELUM)
    a_jumlah_awal = TextEditingController();
    a_jumlah_akhir = TextEditingController();
    a_jumlah_status = TextEditingController();
    a_luas_m2_awal = TextEditingController();
    a_luas_m2_akhir = TextEditingController();
    a_luas_m2_status = TextEditingController();
    a_satuan = TextEditingController();
    a_cara_perolehan_awal = TextEditingController();
    a_cara_perolehan_akhir = TextEditingController();
    a_cara_perolehan_status = TextEditingController();
    a_tgl_perolehan = TextEditingController();
    a_tahun_perolehan = TextEditingController();
    a_perolehan_awal = TextEditingController();
    a_perolehan_akhir = TextEditingController();
    a_perolehan_status = TextEditingController();
    // Apakah nilai perolehan merupakan biaya atribusi/biasa yang menambah kepasitas manfaat (BELUM)
    a_alamat_awal = TextEditingController();
    a_alamat_akhir = TextEditingController();
    a_alamat_status = TextEditingController();
    a_alamat_kota = TextEditingController();
    a_alamat_kecamatan = TextEditingController();
    a_alamat_kelurahan = TextEditingController();
    a_alamat_jalan = TextEditingController();
    a_alamat_no = TextEditingController();
    a_alamat_rt = TextEditingController();
    a_alamat_rw = TextEditingController();
    a_alamat_kodepos = TextEditingController();
    a_hak_tanah_awal = TextEditingController();
    a_hak_tanah_akhir = TextEditingController();
    a_hak_tanah_status = TextEditingController();
    a_sertifikat_nomor_awal = TextEditingController();
    a_sertifikat_nomor_akhir = TextEditingController();
    a_sertifikat_nomor_status = TextEditingController();
    a_sertifikat_tanggal_awal = TextEditingController();
    a_sertifikat_tanggal_akhir = TextEditingController();
    a_sertifikat_tanggal_status = TextEditingController();
    a_keberadaan_barang_awal = TextEditingController();
    a_keberadaan_barang_akhir = TextEditingController();
    a_kondisi_awal = TextEditingController();
    a_kondisi_akhir = TextEditingController();
    a_kondisi_status = TextEditingController();
    a_asal_usul_awal = TextEditingController();
    a_asal_usul_akhir = TextEditingController();
    a_asal_usul_status = TextEditingController();
    a_penggunaan_awal = TextEditingController();
    a_penggunaan_akhir = TextEditingController();
    a_penggunaan_status = TextEditingController();
    a_pemilik_id = TextEditingController();
    a_lat = TextEditingController();
    a_long = TextEditingController();
    a_lainnya = TextEditingController();
    a_keterangan = TextEditingController();
    a_file_nm = TextEditingController();
    a_petugas = TextEditingController();
  }
}

Future<void> getInventarisA() async {}
