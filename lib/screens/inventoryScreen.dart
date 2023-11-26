import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:kib_application/controllers/addressController.dart';
import 'package:kib_application/controllers/appointmentController.dart';
import 'package:kib_application/controllers/departementController.dart';
import 'package:kib_application/controllers/unitController.dart';
import 'package:kib_application/utils/sharedPrefs.dart';
import 'package:number_paginator/number_paginator.dart';

class InventoryScreen extends StatefulWidget {
  final String title;
  InventoryScreen({super.key, required this.title});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final SharedPrefs user     = Get.put(SharedPrefs());
  final departemenController = Get.put(DepartemenController());
  final penetapanController  = Get.put(AppointmentController());
  final addressController    = Get.put(AddressController());
  final satuan               = Get.put(UnitController());

  final searchDepartement    = TextEditingController();
  final departemenSelected   = TextEditingController();

  DateTime now = DateTime.now();

  String selectedSKPD  = '0.00.000';
  String selectedId    = '';
  String modifiedTitle = '';

  int page      = 1;
  int totalPage = 1;

  List<DataColumn> columns = [];
  List<DataColumn> rows    = [];

  void modifyTitle(String originalTitle) {
    if (originalTitle == "Tanah (A)") {
      modifiedTitle = "A";
    } else if (originalTitle == "Peralatan/Mesin (B)") {
      modifiedTitle = "B";
    } else if (originalTitle == "Gedung/Bangunan (C)") {
      modifiedTitle = "C";
    } else if (originalTitle == "Jalan/Jaringan/Irigasi (D)") {
      modifiedTitle = "D";
    } else if (originalTitle == "Aset Tetap Lainnya (E)") {
      modifiedTitle = "E";
    } else if (originalTitle == "KDP (F)") {
      modifiedTitle = "F";
    } else if (originalTitle == "Aset Lain-lain (TGR/RB/AK)") {
      modifiedTitle = "tgr";
    } else if (originalTitle == "Aset Lain-lain (ATB)") {
      modifiedTitle = "atb";
    } else {
      modifiedTitle = "belumTerdaftar";
    }
  }

  @override
  void initState() {
    super.initState();
    ever(penetapanController.totalPage, (value) {
      setState(() {
        totalPage = value;
      });
    });

    departemenController.getDepartemen();
    departemenSelected.text = user.departemen_nm.value;
    selectedSKPD            = user.departemen_kd.value;

    modifyTitle(widget.title);
    
    String yearNow = DateFormat.y().format(now);
    penetapanController.tahun.text = yearNow;

    if (user.departemen_id.value.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        loadPenetapanData();
      });
    }
  }

  Future<List<String>> getDepartementData(String query) async {
    RxList<Map<String, dynamic>> data = departemenController.departemenList;
    await Future.delayed(const Duration(seconds: 1));

    List<String> matchingDepartments = data
        .where((department) {
          final departmentName = department['nama'] as String;
          return departmentName.toLowerCase().contains(query.toLowerCase());
        })
        .map((department) => department['nama'] as String)
        .toList();

    return matchingDepartments;
  }

  Future<void> loadPenetapanData() async {
    page = page;
    await penetapanController.getPenetapan(selectedId, modifiedTitle, page);
  }

  // Future<void> loadPenetapanData() async {
  //   page = page;
  //   String departemenID = user.departemen_id.value;
  //   await penetapanController.getPenetapan(departemenID, modifiedTitle, page);
  // }

  void selectDepartemen(String selectedItem) {
    final department = departemenController.departemenList.firstWhere(
      (dept) => dept['nama'] == selectedItem,
      orElse: () => {'nama': '', 'kode': '', 'id': ''},
    );
    
    setState(() {
      departemenSelected.text = department['nama'].toString();
      selectedSKPD = department['kode'].toString();
      selectedId = department['id'].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (modifiedTitle == "A") {
      columns = [
        DataColumn(label: Text('No.')),
        DataColumn(label: Text('Aksi')),
        DataColumn(label: Text('Kategori Kode')),
        DataColumn(label: Text('Reg.')),
        DataColumn(label: Text('Uraian')),
        DataColumn(label: Text('Tgl. Perolehan')),
        DataColumn(label: Text('Th. Beli')),
        DataColumn(label: Text('Luas (m2)')),
        DataColumn(label: Text('Alamat')),
        DataColumn(label: Text('Penggunaan')),
        DataColumn(label: Text('Hak Tanah')),
        DataColumn(label: Text('Sertifikat Tanggal')),
        DataColumn(label: Text('Sertifikat Nomor')),
        DataColumn(label: Text('Harga')),
        DataColumn(label: Text('Kondisi')),
        DataColumn(label: Text('Asal Usul')),
        DataColumn(label: Text('Keterangan')),
        DataColumn(label: Text('Tgl Inventaris')),
        DataColumn(label: Text('Keberadaan Fisik')),
        DataColumn(label: Text('Kondisi Fisik')),
        DataColumn(label: Text('Penguasaan')),
        DataColumn(label: Text('Doc')),
      ];
    } else if (modifiedTitle == "B") {
      columns = [
        DataColumn(label: Text('No.')),
        DataColumn(label: Text('Aksi')),
        DataColumn(label: Text('Kategori Kode')),
        DataColumn(label: Text('Reg.')),
        DataColumn(label: Text('Uraian')),
        DataColumn(label: Text('Tgl. Perolehan')),
        DataColumn(label: Text('Th. Beli')),
        DataColumn(label: Text('Ukuran/CC')),
        DataColumn(label: Text('Bahan')),
        DataColumn(label: Text('Nomor Pabrik')),
        DataColumn(label: Text('Nomor Rangka')),
        DataColumn(label: Text('Nomor Mesin')),
        DataColumn(label: Text('Nomor Polisi')),
        DataColumn(label: Text('Nomor BPKB')),
        DataColumn(label: Text('Merk')),
        DataColumn(label: Text('Type')),
        DataColumn(label: Text('Harga')),
        DataColumn(label: Text('Kondisi')),
        DataColumn(label: Text('Asal Usul')),
        DataColumn(label: Text('Keterangan')),
        DataColumn(label: Text('Tgl Inventaris')),
        DataColumn(label: Text('Keberadaan Fisik')),
        DataColumn(label: Text('Kondisi Fisik')),
        DataColumn(label: Text('Penguasaan')),
        DataColumn(label: Text('Doc')),
      ];
    } else if (modifiedTitle == "C") {
      columns = [
        DataColumn(label: Text('No.')),
        DataColumn(label: Text('Aksi')),
        DataColumn(label: Text('Kategori Kode')),
        DataColumn(label: Text('Reg.')),
        DataColumn(label: Text('Uraian')),
        DataColumn(label: Text('Tgl. Perolehan')),
        DataColumn(label: Text('Th. Beli')),
        DataColumn(label: Text('Bertingkat/Tidak')),
        DataColumn(label: Text('Beton/Tidak')),
        DataColumn(label: Text('Luas Lantai (m2)')),
        DataColumn(label: Text('Lokasi')),
        DataColumn(label: Text('Dokumen Tgl')),
        DataColumn(label: Text('Dokumen Nomor')),
        DataColumn(label: Text('Luas (m2)')),
        DataColumn(label: Text('Status Tanah')),
        DataColumn(label: Text('Kode Tanah')),
        DataColumn(label: Text('Harga')),
        DataColumn(label: Text('Kondisi')),
        DataColumn(label: Text('Asal Usul')),
        DataColumn(label: Text('Keterangan')),
        DataColumn(label: Text('Tgl Inventaris')),
        DataColumn(label: Text('Keberadaan Fisik')),
        DataColumn(label: Text('Kondisi Fisik')),
        DataColumn(label: Text('Penguasaan')),
        DataColumn(label: Text('Doc')),
      ];
    } else if (modifiedTitle == "D") {
      columns = [
        DataColumn(label: Text('No.')),
        DataColumn(label: Text('Aksi')),
        DataColumn(label: Text('Kategori Kode')),
        DataColumn(label: Text('Reg.')),
        DataColumn(label: Text('Uraian')),
        DataColumn(label: Text('Tgl. Perolehan')),
        DataColumn(label: Text('Th. Beli')),
        DataColumn(label: Text('Konstruksi')),
        DataColumn(label: Text('Panjang (Km)')),
        DataColumn(label: Text('Lebar (m)')),
        DataColumn(label: Text('Luas (m2)')),
        DataColumn(label: Text('Lokasi')),
        DataColumn(label: Text('Dokumen Tgl')),
        DataColumn(label: Text('Dokumen Nomor')),
        DataColumn(label: Text('Kode Tanah')),
        DataColumn(label: Text('Harga')),
        DataColumn(label: Text('Kondisi')),
        DataColumn(label: Text('Asal Usul')),
        DataColumn(label: Text('Keterangan')),
        DataColumn(label: Text('Tgl Inventaris')),
        DataColumn(label: Text('Keberadaan Fisik')),
        DataColumn(label: Text('Kondisi Fisik')),
        DataColumn(label: Text('Penguasaan')),
        DataColumn(label: Text('Doc')),
      ];
    } else if (modifiedTitle == "E") {
      columns = [
        DataColumn(label: Text('No.')),
        DataColumn(label: Text('Aksi')),
        DataColumn(label: Text('Kategori Kode')),
        DataColumn(label: Text('Reg.')),
        DataColumn(label: Text('Uraian')),
        DataColumn(label: Text('Tgl. Perolehan')),
        DataColumn(label: Text('Th. Beli')),
        DataColumn(label: Text('Judul/Pencipta')),
        DataColumn(label: Text('Spesifikasi')),
        DataColumn(label: Text('Asal Daerah')),
        DataColumn(label: Text('Pencipta')),
        DataColumn(label: Text('Jenis')),
        DataColumn(label: Text('Ukuran')),
        DataColumn(label: Text('Harga')),
        DataColumn(label: Text('Kondisi')),
        DataColumn(label: Text('Asal Usul')),
        DataColumn(label: Text('Keterangan')),
        DataColumn(label: Text('Tgl Inventaris')),
        DataColumn(label: Text('Keberadaan Fisik')),
        DataColumn(label: Text('Kondisi Fisik')),
        DataColumn(label: Text('Penguasaan')),
        DataColumn(label: Text('Doc')),
      ];
    } else if (modifiedTitle == "F") {
      columns = [
        DataColumn(label: Text('No.')),
        DataColumn(label: Text('Aksi')),
        DataColumn(label: Text('Kategori Kode')),
        DataColumn(label: Text('Reg.')),
        DataColumn(label: Text('Uraian')),
        DataColumn(label: Text('Tgl. Perolehan')),
        DataColumn(label: Text('Th. Beli')),
        DataColumn(label: Text('Bertingkat/Tidak')),
        DataColumn(label: Text('Beton/Tidak')),
        DataColumn(label: Text('Luas (m2)')),
        DataColumn(label: Text('Lokasi')),
        DataColumn(label: Text('Dokumen Tgl')),
        DataColumn(label: Text('Dokumen Nomor')),
        DataColumn(label: Text('Status Tanah')),
        DataColumn(label: Text('Harga')),
        DataColumn(label: Text('Kondisi')),
        DataColumn(label: Text('Asal Usul')),
        DataColumn(label: Text('Keterangan')),
        DataColumn(label: Text('Tgl Inventaris')),
        DataColumn(label: Text('Keberadaan Fisik')),
        DataColumn(label: Text('Kondisi Fisik')),
        DataColumn(label: Text('Penguasaan')),
        DataColumn(label: Text('Doc')),
      ];
    } else if (modifiedTitle == "tgr") {
      columns = [
        DataColumn(label: Text('No.')),
        DataColumn(label: Text('Aksi')),
        DataColumn(label: Text('Kategori Kode')),
        DataColumn(label: Text('Reg.')),
        DataColumn(label: Text('Uraian')),
        DataColumn(label: Text('Tgl. Perolehan')),
        DataColumn(label: Text('Th. Beli')),
        DataColumn(label: Text('Bertingkat/Tidak')),
        DataColumn(label: Text('Beton/Tidak')),
        DataColumn(label: Text('Luas (m2)')),
        DataColumn(label: Text('Lokasi')),
        DataColumn(label: Text('Dokumen Tgl')),
        DataColumn(label: Text('Dokumen Nomor')),
        DataColumn(label: Text('Status Tanah')),
        DataColumn(label: Text('Kode Tanah')),
        DataColumn(label: Text('Harga')),
        DataColumn(label: Text('Kondisi')),
        DataColumn(label: Text('Asal Usul')),
        DataColumn(label: Text('Keterangan')),
        // DataColumn(label: Text('Tgl Inventaris')),
        // DataColumn(label: Text('Keberadaan Fisik')),
        // DataColumn(label: Text('Kondisi Fisik')),
        // DataColumn(label: Text('Penguasaan')),
        // DataColumn(label: Text('Doc')),
      ];
    } else if (modifiedTitle == "atb") {
      columns = [
        DataColumn(label: Text('No.')),
        DataColumn(label: Text('Aksi')),
        DataColumn(label: Text('Kategori Kode')),
        DataColumn(label: Text('Reg.')),
        DataColumn(label: Text('Uraian')),
        DataColumn(label: Text('Tgl. Perolehan')),
        DataColumn(label: Text('Th. Beli')),
        DataColumn(label: Text('Bertingkat/Tidak')),
        DataColumn(label: Text('Beton/Tidak')),
        DataColumn(label: Text('Luas (m2)')),
        DataColumn(label: Text('Lokasi')),
        DataColumn(label: Text('Dokumen Tgl')),
        DataColumn(label: Text('Dokumen Nomor')),
        DataColumn(label: Text('Status Tanah')),
        DataColumn(label: Text('Harga')),
        DataColumn(label: Text('Kondisi')),
        DataColumn(label: Text('Asal Usul')),
        DataColumn(label: Text('Keterangan')),
        // DataColumn(label: Text('Tgl Inventaris')),
        // DataColumn(label: Text('Keberadaan Fisik')),
        // DataColumn(label: Text('Kondisi Fisik')),
        // DataColumn(label: Text('Penguasaan')),
        // DataColumn(label: Text('Doc')),
      ];
    } else if (modifiedTitle == "belumTerdaftar") {
      columns = [
        DataColumn(label: Text('No.')),
        DataColumn(label: Text('Aksi')),
        DataColumn(label: Text('Kategori Kode')),
        DataColumn(label: Text('Reg.')),
        DataColumn(label: Text('Tgl. Perolehan')),
        DataColumn(label: Text('Th. Perolehan')),
        DataColumn(label: Text('Cara Perolehan')),
        DataColumn(label: Text('Merk/Type')),
        DataColumn(label: Text('Nomor Polisi')),
        DataColumn(label: Text('Nomor Rangkai')),
        DataColumn(label: Text('Nomor Mesin')),
        DataColumn(label: Text('Nomor BPKB')),
        DataColumn(label: Text('Nomor STNK')),
        DataColumn(label: Text('Bahan')),
        DataColumn(label: Text('Warna')),
        DataColumn(label: Text('CC')),
        DataColumn(label: Text('Ruangan')),
        DataColumn(label: Text('Jumlah')),
        DataColumn(label: Text('Satuan')),
        DataColumn(label: Text('Harga Satuan')),
        DataColumn(label: Text('Nilai Perolehan')),
        DataColumn(label: Text('Alamat')),
        DataColumn(label: Text('Dasar Pencatatan')),
        DataColumn(label: Text('Kondisi Barang')),
        DataColumn(label: Text('Status')),
        DataColumn(label: Text('Doc')),
      ];
    }

    List<DataRow> generateDataRows() {
      if (modifiedTitle == "A") {
        return List<DataRow>.generate(
          penetapanController.penetapanList.length,
          (index) {
            final penetapan = penetapanController.penetapanList[index];
            bool isSelected = penetapan['status_inventaris'] == 1;
            return DataRow(
              selected: isSelected,
              color: isSelected
                  ? MaterialStateProperty.all(
                      Color.fromARGB(255, 206, 255, 207))
                  : null,
              cells: [
                DataCell(Text(penetapan['nomor'].toString())),
                DataCell(Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.edit_document, color: Colors.orange),
                      onTap: () {
                        final id = penetapan['penetapan_id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.file_open, color: Colors.red),
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code, color: Colors.blue),
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code_scanner_rounded,
                          color: Colors.green),
                      onTap: () {},
                    ),
                  ],
                )),
                DataCell(
                  Text(penetapan['kategori_kd'] != null &&
                          penetapan['kategori_kd'] != ''
                      ? penetapan['kategori_kd'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['no_register'] != null &&
                          penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['kategori_nm'] != null &&
                          penetapan['kategori_nm'] != ''
                      ? penetapan['kategori_nm'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_perolehan_formatted'] != null &&
                          penetapan['tgl_perolehan_formatted'] != ''
                      ? penetapan['tgl_perolehan_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                          ? penetapan['th_beli'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['a_luas_m2'] != null &&
                          penetapan['a_luas_m2'] != ''
                      ? penetapan['a_luas_m2'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['a_alamat'] != null &&
                          penetapan['a_alamat'] != ''
                      ? penetapan['a_alamat'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['a_penggunaan'] != null &&
                          penetapan['a_penggunaan'] != ''
                      ? penetapan['a_penggunaan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['a_hak_tanah'] != null &&
                          penetapan['a_hak_tanah'] != ''
                      ? penetapan['a_hak_tanah'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['a_sertifikat_tanggal_formatted'] != null &&
                          penetapan['a_sertifikat_tanggal_formatted'] != ''
                      ? penetapan['a_sertifikat_tanggal_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['a_sertifikat_nomor'] != null &&
                          penetapan['a_sertifikat_nomor'] != ''
                      ? penetapan['a_sertifikat_nomor'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['perolehan_formatted'] != null &&
                          penetapan['perolehan_formatted'] != ''
                      ? penetapan['perolehan_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['asal_usul'] != null &&
                          penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keterangan'] != null &&
                          penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_inventaris_formatted'] != null &&
                          penetapan['tgl_inventaris_formatted'] != ''
                      ? penetapan['tgl_inventaris_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keberadaan_barang_status'] != null &&
                          penetapan['keberadaan_barang_status'] != ''
                      ? (penetapan['keberadaan_barang_status'] == 1
                          ? 'Ada'
                          : 'Tidak Ada/Tidak Ditemukan')
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['penguasaan'] != null &&
                          penetapan['penguasaan'] != ''
                      ? penetapan['penguasaan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['file_nm'] != null && penetapan['file_nm'] != ''
                          ? penetapan['file_nm'].toString()
                          : '-'),
                ),
              ],
            );
          },
        );
      } else if (modifiedTitle == "B") {
        return List<DataRow>.generate(
          penetapanController.penetapanList.length,
          (index) {
            final penetapan = penetapanController.penetapanList[index];
            bool isSelected = penetapan['status_inventaris'] == 1;
            return DataRow(
              selected: isSelected,
              color: isSelected
                  ? MaterialStateProperty.all(
                      Color.fromARGB(255, 206, 255, 207))
                  : null,
              cells: [
                DataCell(Text(penetapan['nomor'].toString())),
                DataCell(Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.edit_document, color: Colors.orange),
                      onTap: () {
                        final id = penetapan['penetapan_id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.file_open, color: Colors.red),
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code, color: Colors.blue),
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code_scanner_rounded,
                          color: Colors.green),
                      onTap: () {},
                    ),
                  ],
                )),
                DataCell(
                  Text(penetapan['kategori_kd'] != null &&
                          penetapan['kategori_kd'] != ''
                      ? penetapan['kategori_kd'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['no_register'] != null &&
                          penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['kategori_nm'] != null &&
                          penetapan['kategori_nm'] != ''
                      ? penetapan['kategori_nm'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_perolehan_formatted'] != null &&
                          penetapan['tgl_perolehan_formatted'] != ''
                      ? penetapan['tgl_perolehan_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                          ? penetapan['th_beli'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['b_cc'] != null && penetapan['b_cc'] != ''
                      ? penetapan['b_cc'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['b_bahan'] != null && penetapan['b_bahan'] != ''
                          ? penetapan['b_bahan'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['b_nomor_pabrik'] != null &&
                          penetapan['b_nomor_pabrik'] != ''
                      ? penetapan['b_nomor_pabrik'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['b_nomor_rangka'] != null &&
                          penetapan['b_nomor_rangka'] != ''
                      ? penetapan['b_nomor_rangka'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['b_nomor_mesin'] != null &&
                          penetapan['b_nomor_mesin'] != ''
                      ? penetapan['b_nomor_mesin'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['b_nomor_polisi'] != null &&
                          penetapan['b_nomor_polisi'] != ''
                      ? penetapan['b_nomor_polisi'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['b_nomor_bpkb'] != null &&
                          penetapan['b_nomor_bpkb'] != ''
                      ? penetapan['b_nomor_bpkb'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['b_merk'] != null && penetapan['b_merk'] != ''
                      ? penetapan['b_merk'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['b_type'] != null && penetapan['b_type'] != ''
                      ? penetapan['b_type'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['perolehan_formatted'] != null &&
                          penetapan['perolehan_formatted'] != ''
                      ? penetapan['perolehan_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['asal_usul'] != null &&
                          penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keterangan'] != null &&
                          penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_inventaris_formatted'] != null &&
                          penetapan['tgl_inventaris_formatted'] != ''
                      ? penetapan['tgl_inventaris_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keberadaan_barang_status'] != null &&
                          penetapan['keberadaan_barang_status'] != ''
                      ? (penetapan['keberadaan_barang_status'] == 1
                          ? 'Ada'
                          : 'Tidak Ada/Tidak Ditemukan')
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['penguasaan'] != null &&
                          penetapan['penguasaan'] != ''
                      ? penetapan['penguasaan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['file_nm'] != null && penetapan['file_nm'] != ''
                          ? penetapan['file_nm'].toString()
                          : '-'),
                ),
              ],
            );
          },
        );
      } else if (modifiedTitle == "C") {
        return List<DataRow>.generate(
          penetapanController.penetapanList.length,
          (index) {
            final penetapan = penetapanController.penetapanList[index];
            bool isSelected = penetapan['status_inventaris'] == 1;
            return DataRow(
              selected: isSelected,
              color: isSelected
                  ? MaterialStateProperty.all(
                      Color.fromARGB(255, 206, 255, 207))
                  : null,
              cells: [
                DataCell(Text(penetapan['nomor'].toString())),
                DataCell(Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.edit_document, color: Colors.orange),
                      onTap: () {
                        final id = penetapan['penetapan_id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.file_open, color: Colors.red),
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code, color: Colors.blue),
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code_scanner_rounded,
                          color: Colors.green),
                      onTap: () {},
                    ),
                  ],
                )),
                DataCell(
                  Text(penetapan['kategori_kd'] != null &&
                          penetapan['kategori_kd'] != ''
                      ? penetapan['kategori_kd'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['no_register'] != null &&
                          penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['kategori_nm'] != null &&
                          penetapan['kategori_nm'] != ''
                      ? penetapan['kategori_nm'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_perolehan_formatted'] != null &&
                          penetapan['tgl_perolehan_formatted'] != ''
                      ? penetapan['tgl_perolehan_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                          ? penetapan['th_beli'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['c_bertingkat_tidak'] != null &&
                          penetapan['c_bertingkat_tidak'] != ''
                      ? penetapan['c_bertingkat_tidak'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['c_beton_tidak'] != null &&
                          penetapan['c_beton_tidak'] != ''
                      ? penetapan['c_beton_tidak'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['c_luas_lantai'] != null &&
                          penetapan['c_luas_lantai'] != ''
                      ? penetapan['c_luas_lantai'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['c_lokasi'] != null &&
                          penetapan['c_lokasi'] != ''
                      ? penetapan['c_lokasi'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['c_dokumen_tanggal_formatted'] != null &&
                          penetapan['c_dokumen_tanggal_formatted'] != ''
                      ? penetapan['c_dokumen_tanggal_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['c_dokumen_nomor'] != null &&
                          penetapan['c_dokumen_nomor'] != ''
                      ? penetapan['c_dokumen_nomor'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['c_luas_bangunan'] != null &&
                          penetapan['c_luas_bangunan'] != ''
                      ? penetapan['c_luas_bangunan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['c_status_tanah'] != null &&
                          penetapan['c_status_tanah'] != ''
                      ? penetapan['c_status_tanah'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['c_kode_tanah'] != null &&
                          penetapan['c_kode_tanah'] != ''
                      ? penetapan['c_kode_tanah'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['perolehan_formatted'] != null &&
                          penetapan['perolehan_formatted'] != ''
                      ? penetapan['perolehan_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['asal_usul'] != null &&
                          penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keterangan'] != null &&
                          penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_inventaris_formatted'] != null &&
                          penetapan['tgl_inventaris_formatted'] != ''
                      ? penetapan['tgl_inventaris_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keberadaan_barang_status'] != null &&
                          penetapan['keberadaan_barang_status'] != ''
                      ? (penetapan['keberadaan_barang_status'] == 1
                          ? 'Ada'
                          : 'Tidak Ada/Tidak Ditemukan')
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['penguasaan'] != null &&
                          penetapan['penguasaan'] != ''
                      ? penetapan['penguasaan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['file_nm'] != null && penetapan['file_nm'] != ''
                          ? penetapan['file_nm'].toString()
                          : '-'),
                ),
              ],
            );
          },
        );
      } else if (modifiedTitle == "D") {
        return List<DataRow>.generate(
          penetapanController.penetapanList.length,
          (index) {
            final penetapan = penetapanController.penetapanList[index];
            bool isSelected = penetapan['status_inventaris'] == 1;
            return DataRow(
              selected: isSelected,
              color: isSelected
                  ? MaterialStateProperty.all(
                      Color.fromARGB(255, 206, 255, 207))
                  : null,
              cells: [
                DataCell(Text(penetapan['nomor'].toString())),
                DataCell(Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.edit_document, color: Colors.orange),
                      onTap: () {
                        final id = penetapan['penetapan_id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.file_open, color: Colors.red),
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code, color: Colors.blue),
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code_scanner_rounded,
                          color: Colors.green),
                      onTap: () {},
                    ),
                  ],
                )),
                DataCell(
                  Text(penetapan['kategori_kd'] != null &&
                          penetapan['kategori_kd'] != ''
                      ? penetapan['kategori_kd'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['no_register'] != null &&
                          penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['kategori_nm'] != null &&
                          penetapan['kategori_nm'] != ''
                      ? penetapan['kategori_nm'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_perolehan_formatted'] != null &&
                          penetapan['tgl_perolehan_formatted'] != ''
                      ? penetapan['tgl_perolehan_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                          ? penetapan['th_beli'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['d_konstruksi'] != null &&
                          penetapan['d_konstruksi'] != ''
                      ? penetapan['d_konstruksi'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['d_panjang'] != null &&
                          penetapan['d_panjang'] != ''
                      ? penetapan['d_panjang'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['d_lebar'] != null && penetapan['d_lebar'] != ''
                          ? penetapan['d_lebar'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['d_luas'] != null && penetapan['d_luas'] != ''
                      ? penetapan['d_luas'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['d_lokasi'] != null &&
                          penetapan['d_lokasi'] != ''
                      ? penetapan['d_lokasi'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['d_dokumen_tanggal_formatted'] != null &&
                          penetapan['d_dokumen_tanggal_formatted'] != ''
                      ? penetapan['d_dokumen_tanggal_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['d_dokumen_nomor'] != null &&
                          penetapan['d_dokumen_nomor'] != ''
                      ? penetapan['d_dokumen_nomor'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['d_kode_tanah'] != null &&
                          penetapan['d_kode_tanah'] != ''
                      ? penetapan['d_kode_tanah'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['perolehan_formatted'] != null &&
                          penetapan['perolehan_formatted'] != ''
                      ? penetapan['perolehan_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['asal_usul'] != null &&
                          penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keterangan'] != null &&
                          penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_inventaris_formatted'] != null &&
                          penetapan['tgl_inventaris_formatted'] != ''
                      ? penetapan['tgl_inventaris_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keberadaan_barang_status'] != null &&
                          penetapan['keberadaan_barang_status'] != ''
                      ? (penetapan['keberadaan_barang_status'] == 1
                          ? 'Ada'
                          : 'Tidak Ada/Tidak Ditemukan')
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['penguasaan'] != null &&
                          penetapan['penguasaan'] != ''
                      ? penetapan['penguasaan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['file_nm'] != null && penetapan['file_nm'] != ''
                          ? penetapan['file_nm'].toString()
                          : '-'),
                ),
              ],
            );
          },
        );
      } else if (modifiedTitle == "E") {
        return List<DataRow>.generate(
          penetapanController.penetapanList.length,
          (index) {
            final penetapan = penetapanController.penetapanList[index];
            bool isSelected = penetapan['status_inventaris'] == 1;
            return DataRow(
              selected: isSelected,
              color: isSelected
                  ? MaterialStateProperty.all(
                      Color.fromARGB(255, 206, 255, 207))
                  : null,
              cells: [
                DataCell(Text(penetapan['nomor'].toString())),
                DataCell(Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.edit_document, color: Colors.orange),
                      onTap: () {
                        final id = penetapan['penetapan_id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.file_open, color: Colors.red),
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code, color: Colors.blue),
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code_scanner_rounded,
                          color: Colors.green),
                      onTap: () {},
                    ),
                  ],
                )),
                DataCell(
                  Text(penetapan['kategori_kd'] != null &&
                          penetapan['kategori_kd'] != ''
                      ? penetapan['kategori_kd'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['no_register'] != null &&
                          penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['kategori_nm'] != null &&
                          penetapan['kategori_nm'] != ''
                      ? penetapan['kategori_nm'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_perolehan_formatted'] != null &&
                          penetapan['tgl_perolehan_formatted'] != ''
                      ? penetapan['tgl_perolehan_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                          ? penetapan['th_beli'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['e_judul'] != null && penetapan['e_judul'] != ''
                          ? penetapan['e_judul'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['e_spek'] != null && penetapan['e_spek'] != ''
                      ? penetapan['e_spek'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['e_asal'] != null && penetapan['e_asal'] != ''
                      ? penetapan['e_asal'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['e_pencipta'] != null &&
                          penetapan['e_pencipta'] != ''
                      ? penetapan['e_pencipta'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['e_jenis'] != null && penetapan['e_jenis'] != ''
                          ? penetapan['e_jenis'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['e_ukuran'] != null &&
                          penetapan['e_ukuran'] != ''
                      ? penetapan['e_ukuran'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['perolehan_formatted'] != null &&
                          penetapan['perolehan_formatted'] != ''
                      ? penetapan['perolehan_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['asal_usul'] != null &&
                          penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keterangan'] != null &&
                          penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_inventaris_formatted'] != null &&
                          penetapan['tgl_inventaris_formatted'] != ''
                      ? penetapan['tgl_inventaris_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keberadaan_barang_status'] != null &&
                          penetapan['keberadaan_barang_status'] != ''
                      ? (penetapan['keberadaan_barang_status'] == 1
                          ? 'Ada'
                          : 'Tidak Ada/Tidak Ditemukan')
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['penguasaan'] != null &&
                          penetapan['penguasaan'] != ''
                      ? penetapan['penguasaan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['file_nm'] != null && penetapan['file_nm'] != ''
                          ? penetapan['file_nm'].toString()
                          : '-'),
                ),
              ],
            );
          },
        );
      } else if (modifiedTitle == "F") {
        return List<DataRow>.generate(
          penetapanController.penetapanList.length,
          (index) {
            final penetapan = penetapanController.penetapanList[index];
            bool isSelected = penetapan['status_inventaris'] == 1;
            return DataRow(
              selected: isSelected,
              color: isSelected
                  ? MaterialStateProperty.all(
                      Color.fromARGB(255, 206, 255, 207))
                  : null,
              cells: [
                DataCell(Text(penetapan['nomor'].toString())),
                DataCell(Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.edit_document, color: Colors.orange),
                      onTap: () {
                        final id = penetapan['penetapan_id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.file_open, color: Colors.red),
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code, color: Colors.blue),
                      onTap: () {},
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code_scanner_rounded,
                          color: Colors.green),
                      onTap: () {},
                    ),
                  ],
                )),
                DataCell(
                  Text(penetapan['kategori_kd'] != null &&
                          penetapan['kategori_kd'] != ''
                      ? penetapan['kategori_kd'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['no_register'] != null &&
                          penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['kategori_nm'] != null &&
                          penetapan['kategori_nm'] != ''
                      ? penetapan['kategori_nm'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_perolehan_formatted'] != null &&
                          penetapan['tgl_perolehan_formatted'] != ''
                      ? penetapan['tgl_perolehan_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                          ? penetapan['th_beli'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['f_bertingkat_tidak'] != null &&
                          penetapan['f_bertingkat_tidak'] != ''
                      ? penetapan['f_bertingkat_tidak'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['f_beton_tidak'] != null &&
                          penetapan['f_beton_tidak'] != ''
                      ? penetapan['f_beton_tidak'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['f_luas_bangunan'] != null &&
                          penetapan['f_luas_bangunan'] != ''
                      ? penetapan['f_luas_bangunan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['f_lokasi'] != null &&
                          penetapan['f_lokasi'] != ''
                      ? penetapan['f_lokasi'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['f_dokumen_tanggal_formatted'] != null &&
                          penetapan['f_dokumen_tanggal_formatted'] != ''
                      ? penetapan['f_dokumen_tanggal_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['f_dokumen_nomor'] != null &&
                          penetapan['f_dokumen_nomor'] != ''
                      ? penetapan['f_dokumen_nomor'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['f_status_tanah'] != null &&
                          penetapan['f_status_tanah'] != ''
                      ? penetapan['f_status_tanah'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['perolehan_formatted'] != null &&
                          penetapan['perolehan_formatted'] != ''
                      ? penetapan['perolehan_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['asal_usul'] != null &&
                          penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keterangan'] != null &&
                          penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_inventaris_formatted'] != null &&
                          penetapan['tgl_inventaris_formatted'] != ''
                      ? penetapan['tgl_inventaris_formatted'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keberadaan_barang_status'] != null &&
                          penetapan['keberadaan_barang_status'] != ''
                      ? (penetapan['keberadaan_barang_status'] == 1
                          ? 'Ada'
                          : 'Tidak Ada/Tidak Ditemukan')
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['penguasaan'] != null &&
                          penetapan['penguasaan'] != ''
                      ? penetapan['penguasaan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['file_nm'] != null && penetapan['file_nm'] != ''
                          ? penetapan['file_nm'].toString()
                          : '-'),
                ),
              ],
            );
          },
        );
      } else if (modifiedTitle == "tgr") {
        return List<DataRow>.generate(
          penetapanController.penetapanList.length,
          (index) {
            final penetapan = penetapanController.penetapanList[index];
            return DataRow(
              cells: [
                DataCell(Text(penetapan['nomor'].toString())),
                DataCell(Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.edit_document, color: Colors.orange),
                      onTap: () {
                        final id = penetapan['id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.file_open, color: Colors.red),
                      onTap: () {
                        final id = penetapan['id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code, color: Colors.blue),
                      onTap: () {
                        final id = penetapan['id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code_scanner_rounded,
                          color: Colors.green),
                      onTap: () {
                        final id = penetapan['id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                  ],
                )),
                DataCell(
                  Text(penetapan['kategori_kode'] != null &&
                          penetapan['kategori_kode'] != ''
                      ? penetapan['kategori_kode'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['no_register'] != null &&
                          penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['uraian'] != null && penetapan['uraian'] != ''
                      ? penetapan['uraian'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_perolehan'] != null &&
                          penetapan['tgl_perolehan'] != ''
                      ? penetapan['tgl_perolehan'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                          ? penetapan['th_beli'].toString()
                          : '-'),
                ),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(
                  Text(penetapan['harga'] != null && penetapan['harga'] != ''
                      ? penetapan['harga'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['asal_usul'] != null &&
                          penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keterangan'] != null &&
                          penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'),
                ),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
              ],
            );
          },
        );
      } else if (modifiedTitle == "atb") {
        return List<DataRow>.generate(
          penetapanController.penetapanList.length,
          (index) {
            final penetapan = penetapanController.penetapanList[index];
            return DataRow(
              cells: [
                DataCell(Text(penetapan['nomor'].toString())),
                DataCell(Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.edit_document, color: Colors.orange),
                      onTap: () {
                        final id = penetapan['id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.file_open, color: Colors.red),
                      onTap: () {
                        final id = penetapan['id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code, color: Colors.blue),
                      onTap: () {
                        final id = penetapan['id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code_scanner_rounded,
                          color: Colors.green),
                      onTap: () {
                        final id = penetapan['id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                  ],
                )),
                DataCell(
                  Text(penetapan['kategori_kode'] != null &&
                          penetapan['kategori_kode'] != ''
                      ? penetapan['kategori_kode'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['no_register'] != null &&
                          penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['uraian'] != null && penetapan['uraian'] != ''
                      ? penetapan['uraian'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_perolehan_formated'] != null &&
                          penetapan['tgl_perolehan_formated'] != ''
                      ? penetapan['tgl_perolehan_formated'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                          ? penetapan['th_beli'].toString()
                          : '-'),
                ),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(
                  Text(penetapan['harga'] != null && penetapan['harga'] != ''
                      ? penetapan['harga'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(
                      penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                          ? penetapan['kondisi'].toString()
                          : '-'),
                ),
                DataCell(
                  Text(penetapan['asal_usul'] != null &&
                          penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['keterangan'] != null &&
                          penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'),
                ),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
              ],
            );
          },
        );
      } else if (modifiedTitle == "belumTerdaftar") {
        return List<DataRow>.generate(
          penetapanController.penetapanList.length,
          (index) {
            final penetapan = penetapanController.penetapanList[index];
            return DataRow(
              cells: [
                DataCell(Text(penetapan['nomor'].toString())),
                DataCell(Row(
                  children: [
                    InkWell(
                      child: Icon(Icons.edit_document, color: Colors.orange),
                      onTap: () {
                        final id = penetapan['id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.file_open, color: Colors.red),
                      onTap: () {
                        final id = penetapan['id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code, color: Colors.blue),
                      onTap: () {
                        final id = penetapan['id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      child: Icon(Icons.qr_code_scanner_rounded,
                          color: Colors.green),
                      onTap: () {
                        final id = penetapan['id'].toString();
                        penetapanController.getPenetapanById(id, modifiedTitle);
                      },
                    ),
                  ],
                )),
                DataCell(Text(penetapan['kategori_kode'] != null &&
                        penetapan['kategori_kode'] != ''
                    ? penetapan['kategori_kode'].toString()
                    : '-')),
                DataCell(
                  Text(penetapan['no_register'] != null &&
                          penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'),
                ),
                DataCell(
                  Text(penetapan['tgl_perolehan_formated'] != null &&
                          penetapan['tgl_perolehan_formated'] != ''
                      ? penetapan['tgl_perolehan_formated'].toString()
                      : '-'),
                ),
                DataCell(Text('')),
                DataCell(
                  Text(penetapan['cara_perolehan'] != null &&
                          penetapan['cara_perolehan'] != ''
                      ? penetapan['cara_perolehan'].toString()
                      : '-'),
                ),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
                DataCell(Text('')),
              ],
            );
          },
        );
      }
      return [];
    }

    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(widget.title),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            color: appbarColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomDropdown.searchRequest(
                    controller: searchDepartement,
                    futureRequest: getDepartementData,
                    futureRequestDelay: const Duration(seconds: 3),
                    hintText: 'Pilih Departemen',
                    onChanged: selectDepartemen,
                  ),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(12),
                  //     color: Colors.grey.shade400,
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 15),
                  //     child: TextFormField(
                  //       controller: departemenSelected,
                  //       readOnly: true,
                  //       decoration: const InputDecoration(
                  //         border: InputBorder.none,
                  //       ),
                  //       style: TextStyle(fontWeight: FontWeight.bold),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      text: 'SKPD: ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: selectedSKPD,
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: penetapanController.tahun,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            labelText: 'Tahun',
                            labelStyle: TextStyle(color: secondaryTextColor),
                            contentPadding: EdgeInsets.all(14),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: buttonColor,
                          padding: EdgeInsets.all(16),
                        ),
                        onPressed: loadPenetapanData,
                        child: Text('Generate'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 30),
            Container(
              height: 395,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                color: Colors.white,
              ),
              child: Obx(
                () => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      headingRowColor: MaterialStateProperty.all(Colors.white),
                      columnSpacing: 30,
                      columns: columns,
                      rows: generateDataRows(),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white),
              child: NumberPaginator(
                numberPages: totalPage,
                onPageChange: (int index) {
                  setState(() {
                    page = index + 1;
                  });
                  loadPenetapanData();
                },
                config: NumberPaginatorUIConfig(
                  buttonUnselectedForegroundColor:Color.fromARGB(255, 18, 58, 146),
                  buttonSelectedBackgroundColor:Color.fromARGB(255, 18, 58, 146),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
