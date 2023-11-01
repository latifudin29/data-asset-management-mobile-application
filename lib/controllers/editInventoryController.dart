import 'package:get/get.dart';
import 'package:flutter/material.dart';

class EditInventoryController extends GetxController {
  // final _connect = GetConnect();

  late TextEditingController tahun,
      tglInventaris,
      skpd,
      skpdUraian,
      noRegister,
      barang,
      namaBarang,
      jumlah,
      satuan,
      perolehan,
      tglPerolehan,
      thPerolehan,
      nilaiPerolehan,
      alamat,
      kota,
      kecamatan,
      kelurahan,
      jalan,
      no,
      rt,
      rw,
      kodePos,
      hakTanah,
      noSertifikat,
      tglSertifikat,
      kondisi,
      asalUsul,
      penggunaan;

  @override
  void onInit() {
    super.onInit();
    tahun = TextEditingController();
    tglInventaris = TextEditingController();
    skpd = TextEditingController();
    skpdUraian = TextEditingController();
    noRegister = TextEditingController();
    barang = TextEditingController();
    namaBarang = TextEditingController();
    jumlah = TextEditingController();
    satuan = TextEditingController();
    perolehan = TextEditingController();
    tglPerolehan = TextEditingController();
    thPerolehan = TextEditingController();
    nilaiPerolehan = TextEditingController();
    alamat = TextEditingController();
    kota = TextEditingController();
    kecamatan = TextEditingController();
    kelurahan = TextEditingController();
    jalan = TextEditingController();
    no = TextEditingController();
    rt = TextEditingController();
    rw = TextEditingController();
    kodePos = TextEditingController();
    hakTanah = TextEditingController();
    noSertifikat = TextEditingController();
    tglSertifikat = TextEditingController();
    kondisi = TextEditingController();
    asalUsul = TextEditingController();
    penggunaan = TextEditingController();
  }
}
