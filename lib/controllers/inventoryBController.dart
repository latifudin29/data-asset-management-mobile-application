import 'package:get/get.dart';
import 'package:flutter/material.dart';

class InventoryBController extends GetxController {
  late TextEditingController b_tgl_inventaris,
      b_skpd,
      b_skpd_uraian,
      b_no_register_awal,
      b_no_register_akhir,
      b_no_register_status,
      b_kategori_id_awal,
      b_kategori_id_akhir,
      b_kategori_id_status,
      b_barang,
      // Nama spesifikasi barang (BELUM)
      b_jumlah_awal,
      b_jumlah_akhir,
      b_jumlah_status,
      b_satuan,
      b_cara_perolehan_awal,
      b_cara_perolehan_akhir,
      b_cara_perolehan_status,
      b_tgl_perolehan,
      b_tahun_perolehan,
      b_perolehan_awal,
      b_perolehan_akhir,
      b_perolehan_status,
      // Apakah nilai perolehan merupakan biaya atribusi/biasa yang menambah kepasitas manfaat (BELUM)
      //
      b_alamat_awal,
      b_alamat_akhir,
      b_alamat_status,
      b_alamat_kota,
      b_alamat_kecamatan,
      b_alamat_kelurahan,
      b_alamat_jalan,
      b_alamat_no,
      b_alamat_rt,
      b_alamat_rw,
      b_alamat_kodepos,
      //
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
      b_keberadaan_barang_awal,
      b_keberadaan_barang_akhir,
      b_kondisi_awal,
      b_kondisi_akhir,
      b_kondisi_status,
      b_asal_usul_awal,
      b_asal_usul_akhir,
      b_asal_usul_status,
      b_penggunaan_awal,
      b_penggunaan_akhir,
      b_penggunaan_status,
      b_pemilik_id,
      b_lainnya,
      b_keterangan,
      b_file_nm,
      b_petugas;

  @override
  void onInit() {
    super.onInit();
    // INVENTARIS A
    b_tgl_inventaris = TextEditingController();
    b_skpd = TextEditingController();
    b_skpd_uraian = TextEditingController();
    b_no_register_awal = TextEditingController();
    b_no_register_akhir = TextEditingController();
    b_no_register_status = TextEditingController();
    b_kategori_id_awal = TextEditingController();
    b_kategori_id_akhir = TextEditingController();
    b_kategori_id_status = TextEditingController();
    b_barang = TextEditingController();
    // Nama spesifikasi barang (BELUM)
    b_jumlah_awal = TextEditingController();
    b_jumlah_akhir = TextEditingController();
    b_jumlah_status = TextEditingController();
    b_satuan = TextEditingController();
    b_cara_perolehan_awal = TextEditingController();
    b_cara_perolehan_akhir = TextEditingController();
    b_cara_perolehan_status = TextEditingController();
    b_tgl_perolehan = TextEditingController();
    b_tahun_perolehan = TextEditingController();
    b_perolehan_awal = TextEditingController();
    b_perolehan_akhir = TextEditingController();
    b_perolehan_status = TextEditingController();
    // Apakah nilai perolehan merupakan biaya atribusi/biasa yang menambah kepasitas manfaat (BELUM)
    b_alamat_awal = TextEditingController();
    b_alamat_akhir = TextEditingController();
    b_alamat_status = TextEditingController();
    b_alamat_kota = TextEditingController();
    b_alamat_kecamatan = TextEditingController();
    b_alamat_kelurahan = TextEditingController();
    b_alamat_jalan = TextEditingController();
    b_alamat_no = TextEditingController();
    b_alamat_rt = TextEditingController();
    b_alamat_rw = TextEditingController();
    b_alamat_kodepos = TextEditingController();
    //
    b_merk_awal = TextEditingController();
    b_merk_akhir = TextEditingController();
    b_merk_status = TextEditingController();
    b_cc_awal = TextEditingController();
    b_cc_akhir = TextEditingController();
    b_cc_status = TextEditingController();
    b_nomor_polisi_awal = TextEditingController();
    b_nomor_polisi_akhir = TextEditingController();
    b_nomor_polisi_status = TextEditingController();
    b_nomor_rangka_awal = TextEditingController();
    b_nomor_rangka_akhir = TextEditingController();
    b_nomor_rangka_status = TextEditingController();
    b_nomor_mesin_awal = TextEditingController();
    b_nomor_mesin_akhir = TextEditingController();
    b_nomor_mesin_status = TextEditingController();
    b_nomor_bpkb_awal = TextEditingController();
    b_nomor_bpkb_akhir = TextEditingController();
    b_nomor_bpkb_status = TextEditingController();
    b_keberadaan_barang_awal = TextEditingController();
    b_keberadaan_barang_akhir = TextEditingController();
    b_kondisi_awal = TextEditingController();
    b_kondisi_akhir = TextEditingController();
    b_kondisi_status = TextEditingController();
    b_asal_usul_awal = TextEditingController();
    b_asal_usul_akhir = TextEditingController();
    b_asal_usul_status = TextEditingController();
    b_penggunaan_awal = TextEditingController();
    b_penggunaan_akhir = TextEditingController();
    b_penggunaan_status = TextEditingController();
    b_pemilik_id = TextEditingController();
    b_lainnya = TextEditingController();
    b_keterangan = TextEditingController();
    b_file_nm = TextEditingController();
    b_petugas = TextEditingController();
  }
}

Future<void> getInventarisB() async {}
