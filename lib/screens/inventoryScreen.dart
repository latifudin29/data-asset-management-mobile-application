import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:kib_application/controllers/addressController.dart';
import 'package:kib_application/controllers/appointmentController.dart';
import 'package:kib_application/controllers/departementController.dart';
import 'package:kib_application/controllers/roomController.dart';
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
  final ruangController      = Get.put(RoomController());

  final TextEditingController searchDepartement  = TextEditingController();
  final TextEditingController departemenSelected = TextEditingController();
  final TextEditingController selectedSKPD       = TextEditingController();

  late TextEditingController searchController;

  DateTime now = DateTime.now();

  String selectedId    = '';
  String modifiedTitle = '';
  String filter        = 'Semua';

  int page      = 1;
  int totalPage = 1;

  List<DataColumn> columns = [];
  List<DataColumn> rows    = [];

  void modifyTitle(String originalTitle) {
    switch (originalTitle) {
      case "Tanah (A)":
        modifiedTitle = "A";
        break;
      case "Peralatan/Mesin (B)":
        modifiedTitle = "B";
        break;
      case "Gedung/Bangunan (C)":
        modifiedTitle = "C";
        break;
      case "Jalan/Jaringan/Irigasi (D)":
        modifiedTitle = "D";
        break;
      case "Aset Tetap Lainnya (E)":
        modifiedTitle = "E";
        break;
      case "Aset Lain-lain (TGR/RB/AK)":
        modifiedTitle = "G";
        break;
      case "Aset Lain-lain (ATB)":
        modifiedTitle = "ATB";
        break;
      default:
        modifiedTitle = "UNREG";
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

    selectedSKPD.text = '0.00.000';
    searchController = TextEditingController();
    
    departemenController.getDepartemen();

    if(user.departemen_nm.value != "" && user.departemen_kd.value != ""){
      departemenSelected.text = user.departemen_nm.value;
      selectedSKPD.text       = user.departemen_kd.value;
    }

    modifyTitle(widget.title);
    user.setKategori(modifiedTitle);
    
    String yearNow = DateFormat.y().format(now);
    penetapanController.tahun.text = yearNow;

    if (user.departemen_id.value.isNotEmpty && user.departemen_id.value != "0") {
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
    if (user.login_status.value == "1" && user.group.value == "Aset_Operator_Views") {
      String departemenID = user.departemen_id.value;
      await penetapanController.getPenetapan(departemenID, modifiedTitle, page);
      user.setPage(page.toString());
    } else {
      if (user.departemen_id.value.isNotEmpty && user.departemen_id.value != "0") {
        String departemenID = user.departemen_id.value;
        await penetapanController.getPenetapan(departemenID, modifiedTitle, page);
      } else {
        await penetapanController.getPenetapan(selectedId, modifiedTitle, page);
      }
      user.setPage(page.toString());
    }
  }

  void selectDepartemen(String selectedItem) {
    final department = departemenController.departemenList.firstWhere(
      (dept) => dept['nama'] == selectedItem,
      orElse: () => {'nama': '', 'kode': '', 'id': ''},
    );
    
    setState(() {
      selectedId = department['id'].toString();
      selectedSKPD.text = department['kode'].toString();
      departemenSelected.text = department['nama'].toString();

      user.setDepartemenID(selectedId);
      user.setDepartemenKode(selectedSKPD.text);
      user.setDepartemenNama(departemenSelected.text);
      page = 1;
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
    } else if (modifiedTitle == "G") {
      columns = [
        DataColumn(label: Text('No.')),
        DataColumn(label: Text('Aksi')),
        DataColumn(label: Text('Kategori Kode')),
        DataColumn(label: Text('Reg.')),
        DataColumn(label: Text('Uraian')),
        DataColumn(label: Text('Tgl. Perolehan')),
        DataColumn(label: Text('Th. Beli')),
        DataColumn(label: Text('No. Sertifikat/Pabrik/Mesin')),
        DataColumn(label: Text('No. Polisi')),
        DataColumn(label: Text('Bahan')),
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
    } else if (modifiedTitle == "ATB") {
      columns = [
        DataColumn(label: Text('No.')),
        DataColumn(label: Text('Aksi')),
        DataColumn(label: Text('Kategori Kode')),
        DataColumn(label: Text('Reg.')),
        DataColumn(label: Text('Uraian')),
        DataColumn(label: Text('Tgl. Perolehan')),
        DataColumn(label: Text('Th. Beli')),
        DataColumn(label: Text('Merk/Tipe/Spek')),
        DataColumn(label: Text('Bertingkat/Tidak')),
        DataColumn(label: Text('Beton/Tidak')),
        DataColumn(label: Text('Luas (M2)')),
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
    } else if (modifiedTitle == "UNREG") {
      columns = [];
    }

    List<DataRow> generateDataRows() {
      final filteredList = penetapanController.penetapanList
          .where((penetapan) {
              final resultSearch = penetapan.values.map((value) => value.toString().toLowerCase()).toList();

              return resultSearch.any((value) => value.contains(searchController.text.toLowerCase()));
            })
          .toList();
      
      final filteredAndSelectedList = filteredList.where((penetapan) {
        if (filter == 'Sudah') {
          return penetapan['status_inventaris'] == 1;
        } else if (filter == 'Belum') {
          return penetapan['status_inventaris'] == 0;
        }
        return true;
      }).toList();

      if (modifiedTitle == "A") {
        return List<DataRow>.generate(
          filteredAndSelectedList.length,
          (index) {
            final penetapan = filteredAndSelectedList[index];
            bool isSelected = penetapan['status_inventaris'] == 1;
            return DataRow(
              selected: isSelected,
              color: isSelected
                  ? MaterialStateProperty.all(
                      Color.fromARGB(255, 206, 255, 207))
                  : null,
              cells: [
                DataCell(
                  Text(
                    penetapan['nomor'].toString()
                  )
                ),
                DataCell(
                  Row(
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
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kategori_kd'] != null && penetapan['kategori_kd'] != ''
                      ? penetapan['kategori_kd'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['no_register'] != null && penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kategori_nm'] != null && penetapan['kategori_nm'] != ''
                      ? penetapan['kategori_nm'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_perolehan_formatted'] != null && penetapan['tgl_perolehan_formatted'] != ''
                      ? penetapan['tgl_perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                      ? penetapan['th_beli'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['a_luas_m2'] != null && penetapan['a_luas_m2'] != ''
                      ? penetapan['a_luas_m2'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['a_alamat'] != null && penetapan['a_alamat'] != ''
                      ? penetapan['a_alamat'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['a_penggunaan'] != null && penetapan['a_penggunaan'] != ''
                      ? penetapan['a_penggunaan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['a_hak_tanah'] != null && penetapan['a_hak_tanah'] != ''
                      ? penetapan['a_hak_tanah'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['a_sertifikat_tanggal_formatted'] != null && penetapan['a_sertifikat_tanggal_formatted'] != ''
                      ? penetapan['a_sertifikat_tanggal_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['a_sertifikat_nomor'] != null && penetapan['a_sertifikat_nomor'] != ''
                      ? penetapan['a_sertifikat_nomor'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['perolehan_formatted'] != null && penetapan['perolehan_formatted'] != ''
                      ? penetapan['perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['asal_usul'] != null && penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keterangan'] != null && penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_inventaris_formatted'] != null && penetapan['tgl_inventaris_formatted'] != ''
                      ? penetapan['tgl_inventaris_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keberadaan_barang_status'] != null && penetapan['keberadaan_barang_status'] != ''
                      ? (penetapan['keberadaan_barang_status'] == 1 ? 'Ada' : 'Tidak Ada/Tidak Ditemukan')
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['penguasaan'] != null && penetapan['penguasaan'] != ''
                      ? penetapan['penguasaan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['file_nm'] != null && penetapan['file_nm'] != ''
                      ? penetapan['file_nm'].toString()
                      : '-'
                  ),
                ),
              ],
            );
          },
        );
      } else if (modifiedTitle == "B") {
        return List<DataRow>.generate(
          filteredAndSelectedList.length,
          (index) {
            final penetapan = filteredAndSelectedList[index];
            bool isSelected = penetapan['status_inventaris'] == 1;
            return DataRow(
              selected: isSelected,
              color: isSelected
                  ? MaterialStateProperty.all(
                      Color.fromARGB(255, 206, 255, 207))
                  : null,
              cells: [
                DataCell(
                  Text(
                    penetapan['nomor'].toString()
                  )
                ),
                DataCell(
                  Row(
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
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kategori_kd'] != null && penetapan['kategori_kd'] != ''
                      ? penetapan['kategori_kd'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['no_register'] != null && penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kategori_nm'] != null && penetapan['kategori_nm'] != ''
                      ? penetapan['kategori_nm'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_perolehan_formatted'] != null && penetapan['tgl_perolehan_formatted'] != ''
                      ? penetapan['tgl_perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                      ? penetapan['th_beli'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['b_cc'] != null && penetapan['b_cc'] != ''
                      ? penetapan['b_cc'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['b_bahan'] != null && penetapan['b_bahan'] != ''
                      ? penetapan['b_bahan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['b_nomor_pabrik'] != null && penetapan['b_nomor_pabrik'] != ''
                      ? penetapan['b_nomor_pabrik'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['b_nomor_rangka'] != null && penetapan['b_nomor_rangka'] != ''
                      ? penetapan['b_nomor_rangka'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['b_nomor_mesin'] != null && penetapan['b_nomor_mesin'] != ''
                      ? penetapan['b_nomor_mesin'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['b_nomor_polisi'] != null && penetapan['b_nomor_polisi'] != ''
                      ? penetapan['b_nomor_polisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['b_nomor_bpkb'] != null && penetapan['b_nomor_bpkb'] != ''
                      ? penetapan['b_nomor_bpkb'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['b_merk'] != null && penetapan['b_merk'] != ''
                      ? penetapan['b_merk'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['b_type'] != null && penetapan['b_type'] != ''
                      ? penetapan['b_type'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['perolehan_formatted'] != null && penetapan['perolehan_formatted'] != ''
                      ? penetapan['perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['asal_usul'] != null && penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keterangan'] != null && penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_inventaris_formatted'] != null && penetapan['tgl_inventaris_formatted'] != ''
                      ? penetapan['tgl_inventaris_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keberadaan_barang_status'] != null && penetapan['keberadaan_barang_status'] != ''
                      ? (penetapan['keberadaan_barang_status'] == 1 ? 'Ada' : 'Tidak Ada/Tidak Ditemukan')
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['penguasaan'] != null && penetapan['penguasaan'] != ''
                      ? penetapan['penguasaan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['file_nm'] != null && penetapan['file_nm'] != ''
                      ? penetapan['file_nm'].toString()
                      : '-'
                  ),
                ),
              ],
            );
          },
        );
      } else if (modifiedTitle == "C") {
        return List<DataRow>.generate(
          filteredAndSelectedList.length,
          (index) {
            final penetapan = filteredAndSelectedList[index];
            bool isSelected = penetapan['status_inventaris'] == 1;
            return DataRow(
              selected: isSelected,
              color: isSelected
                  ? MaterialStateProperty.all(
                      Color.fromARGB(255, 206, 255, 207))
                  : null,
              cells: [
                DataCell(
                  Text(
                    penetapan['nomor'].toString()
                  ),
                ),
                DataCell(
                  Row(
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
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kategori_kd'] != null && penetapan['kategori_kd'] != ''
                      ? penetapan['kategori_kd'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['no_register'] != null && penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kategori_nm'] != null && penetapan['kategori_nm'] != ''
                      ? penetapan['kategori_nm'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_perolehan_formatted'] != null && penetapan['tgl_perolehan_formatted'] != ''
                      ? penetapan['tgl_perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                      ? penetapan['th_beli'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_bertingkat_tidak'] != null && penetapan['c_bertingkat_tidak'] != ''
                      ? penetapan['c_bertingkat_tidak'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_beton_tidak'] != null && penetapan['c_beton_tidak'] != ''
                      ? penetapan['c_beton_tidak'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_luas_lantai'] != null && penetapan['c_luas_lantai'] != ''
                      ? penetapan['c_luas_lantai'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_lokasi'] != null && penetapan['c_lokasi'] != ''
                      ? penetapan['c_lokasi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_dokumen_tanggal_formatted'] != null && penetapan['c_dokumen_tanggal_formatted'] != ''
                      ? penetapan['c_dokumen_tanggal_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_dokumen_nomor'] != null && penetapan['c_dokumen_nomor'] != ''
                      ? penetapan['c_dokumen_nomor'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_luas_bangunan'] != null && penetapan['c_luas_bangunan'] != ''
                      ? penetapan['c_luas_bangunan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_status_tanah'] != null && penetapan['c_status_tanah'] != ''
                      ? penetapan['c_status_tanah'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_kode_tanah'] != null && penetapan['c_kode_tanah'] != ''
                      ? penetapan['c_kode_tanah'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['perolehan_formatted'] != null && penetapan['perolehan_formatted'] != ''
                      ? penetapan['perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['asal_usul'] != null && penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keterangan'] != null && penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_inventaris_formatted'] != null && penetapan['tgl_inventaris_formatted'] != ''
                      ? penetapan['tgl_inventaris_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keberadaan_barang_status'] != null && penetapan['keberadaan_barang_status'] != ''
                      ? (penetapan['keberadaan_barang_status'] == 1 ? 'Ada' : 'Tidak Ada/Tidak Ditemukan')
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['penguasaan'] != null && penetapan['penguasaan'] != ''
                      ? penetapan['penguasaan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['file_nm'] != null && penetapan['file_nm'] != ''
                      ? penetapan['file_nm'].toString()
                      : '-'
                  ),
                ),
              ],
            );
          },
        );
      } else if (modifiedTitle == "D") {
        return List<DataRow>.generate(
          filteredAndSelectedList.length,
          (index) {
            final penetapan = filteredAndSelectedList[index];
            bool isSelected = penetapan['status_inventaris'] == 1;
            return DataRow(
              selected: isSelected,
              color: isSelected
                  ? MaterialStateProperty.all(
                      Color.fromARGB(255, 206, 255, 207))
                  : null,
              cells: [
                DataCell(
                  Text(
                    penetapan['nomor'].toString()
                  ),
                ),
                DataCell(
                  Row(
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
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kategori_kd'] != null && penetapan['kategori_kd'] != ''
                      ? penetapan['kategori_kd'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['no_register'] != null && penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kategori_nm'] != null && penetapan['kategori_nm'] != ''
                      ? penetapan['kategori_nm'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_perolehan_formatted'] != null && penetapan['tgl_perolehan_formatted'] != ''
                      ? penetapan['tgl_perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                      ? penetapan['th_beli'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['d_konstruksi'] != null && penetapan['d_konstruksi'] != ''
                      ? penetapan['d_konstruksi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['d_panjang'] != null && penetapan['d_panjang'] != ''
                      ? penetapan['d_panjang'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['d_lebar'] != null && penetapan['d_lebar'] != ''
                      ? penetapan['d_lebar'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['d_luas'] != null && penetapan['d_luas'] != ''
                      ? penetapan['d_luas'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['d_lokasi'] != null && penetapan['d_lokasi'] != ''
                      ? penetapan['d_lokasi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['d_dokumen_tanggal_formatted'] != null && penetapan['d_dokumen_tanggal_formatted'] != ''
                      ? penetapan['d_dokumen_tanggal_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['d_dokumen_nomor'] != null && penetapan['d_dokumen_nomor'] != ''
                      ? penetapan['d_dokumen_nomor'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['d_kode_tanah'] != null && penetapan['d_kode_tanah'] != ''
                      ? penetapan['d_kode_tanah'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['perolehan_formatted'] != null && penetapan['perolehan_formatted'] != ''
                      ? penetapan['perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['asal_usul'] != null && penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keterangan'] != null && penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_inventaris_formatted'] != null && penetapan['tgl_inventaris_formatted'] != ''
                      ? penetapan['tgl_inventaris_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keberadaan_barang_status'] != null && penetapan['keberadaan_barang_status'] != ''
                      ? (penetapan['keberadaan_barang_status'] == 1 ? 'Ada' : 'Tidak Ada/Tidak Ditemukan')
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['penguasaan'] != null && penetapan['penguasaan'] != ''
                      ? penetapan['penguasaan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['file_nm'] != null && penetapan['file_nm'] != ''
                      ? penetapan['file_nm'].toString()
                      : '-'
                  ),
                ),
              ],
            );
          },
        );
      } else if (modifiedTitle == "E") {
        return List<DataRow>.generate(
          filteredAndSelectedList.length,
          (index) {
            final penetapan = filteredAndSelectedList[index];
            bool isSelected = penetapan['status_inventaris'] == 1;
            return DataRow(
              selected: isSelected,
              color: isSelected
                  ? MaterialStateProperty.all(
                      Color.fromARGB(255, 206, 255, 207))
                  : null,
              cells: [
                DataCell(
                  Text(
                    penetapan['nomor'].toString()
                  ),
                ),
                DataCell(
                  Row(
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
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kategori_kd'] != null && penetapan['kategori_kd'] != ''
                      ? penetapan['kategori_kd'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['no_register'] != null && penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kategori_nm'] != null && penetapan['kategori_nm'] != ''
                      ? penetapan['kategori_nm'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_perolehan_formatted'] != null && penetapan['tgl_perolehan_formatted'] != ''
                      ? penetapan['tgl_perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                      ? penetapan['th_beli'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['e_judul'] != null && penetapan['e_judul'] != ''
                      ? penetapan['e_judul'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['e_spek'] != null && penetapan['e_spek'] != ''
                      ? penetapan['e_spek'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['e_asal'] != null && penetapan['e_asal'] != ''
                      ? penetapan['e_asal'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['e_pencipta'] != null && penetapan['e_pencipta'] != ''
                      ? penetapan['e_pencipta'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['e_jenis'] != null && penetapan['e_jenis'] != ''
                      ? penetapan['e_jenis'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['e_ukuran'] != null && penetapan['e_ukuran'] != ''
                      ? penetapan['e_ukuran'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['perolehan_formatted'] != null && penetapan['perolehan_formatted'] != ''
                      ? penetapan['perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['asal_usul'] != null && penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keterangan'] != null && penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_inventaris_formatted'] != null && penetapan['tgl_inventaris_formatted'] != ''
                      ? penetapan['tgl_inventaris_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keberadaan_barang_status'] != null && penetapan['keberadaan_barang_status'] != ''
                      ? (penetapan['keberadaan_barang_status'] == 1 ? 'Ada' : 'Tidak Ada/Tidak Ditemukan')
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['penguasaan'] != null && penetapan['penguasaan'] != ''
                      ? penetapan['penguasaan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['file_nm'] != null && penetapan['file_nm'] != ''
                      ? penetapan['file_nm'].toString()
                      : '-'
                  ),
                ),
              ],
            );
          },
        );
      } else if (modifiedTitle == "G") {
        return List<DataRow>.generate(
          filteredAndSelectedList.length,
          (index) {
            final penetapan = filteredAndSelectedList[index];
            bool isSelected = penetapan['status_inventaris'] == 1;
            return DataRow(
              selected: isSelected,
              color: isSelected
                  ? MaterialStateProperty.all(
                      Color.fromARGB(255, 206, 255, 207))
                  : null,
              cells: [
                DataCell(Text(penetapan['nomor'].toString())),
                DataCell(
                  Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.red),
                      SizedBox(width: 3),
                      Text('No Action'),
                    ],
                  )
                ),
                // DataCell(Row(
                //   children: [
                //     InkWell(
                //       child: Icon(Icons.edit_document, color: Colors.orange),
                //       onTap: () {},
                //     ),
                //     SizedBox(width: 8),
                //     InkWell(
                //       child: Icon(Icons.file_open, color: Colors.red),
                //       onTap: () {},
                //     ),
                //     SizedBox(width: 8),
                //     InkWell(
                //       child: Icon(Icons.qr_code, color: Colors.blue),
                //       onTap: () {},
                //     ),
                //     SizedBox(width: 8),
                //     InkWell(
                //       child: Icon(Icons.qr_code_scanner_rounded,
                //           color: Colors.green),
                //       onTap: () {},
                //     ),
                //   ],
                // )),
                DataCell(
                  Text(
                    penetapan['kategori_kd'] != null && penetapan['kategori_kd'] != ''
                      ? penetapan['kategori_kd'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['no_register'] != null && penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kategori_nm'] != null && penetapan['kategori_nm'] != ''
                      ? penetapan['kategori_nm'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_perolehan_formatted'] != null && penetapan['tgl_perolehan_formatted'] != ''
                      ? penetapan['tgl_perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                      ? penetapan['th_beli'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    (penetapan['a_sertifikat_nomor'] != null ? penetapan['a_sertifikat_nomor'].toString() : "-") +
                    '/' +
                    (penetapan['b_nomor_pabrik'] != null ? penetapan['b_nomor_pabrik'].toString() : "-") +
                    '/' +
                    (penetapan['b_nomor_mesin'] != null ? penetapan['b_nomor_mesin'].toString() : "-"),
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['b_nomor_polisi'] != null && penetapan['b_nomor_polisi'] != ''
                      ? penetapan['b_nomor_polisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['b_bahan'] != null && penetapan['b_bahan'] != ''
                      ? penetapan['b_bahan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['perolehan_formatted'] != null && penetapan['perolehan_formatted'] != ''
                      ? penetapan['perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['asal_usul'] != null && penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keterangan'] != null && penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_inventaris_formatted'] != null && penetapan['tgl_inventaris_formatted'] != ''
                      ? penetapan['tgl_inventaris_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keberadaan_barang_status'] != null && penetapan['keberadaan_barang_status'] != ''
                      ? (penetapan['keberadaan_barang_status'] == 1 ? 'Ada' : 'Tidak Ada/Tidak Ditemukan')
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['penguasaan'] != null && penetapan['penguasaan'] != ''
                      ? penetapan['penguasaan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['file_nm'] != null && penetapan['file_nm'] != ''
                      ? penetapan['file_nm'].toString()
                      : '-'
                  ),
                ),
              ],
            );
          },
        );
      } else if (modifiedTitle == "ATB") {
        return List<DataRow>.generate(
          filteredAndSelectedList.length,
          (index) {
            final penetapan = filteredAndSelectedList[index];
            bool isSelected = penetapan['status_inventaris'] == 1;
            return DataRow(
              selected: isSelected,
              color: isSelected
                  ? MaterialStateProperty.all(
                      Color.fromARGB(255, 206, 255, 207))
                  : null,
              cells: [
                DataCell(Text(penetapan['nomor'].toString())),
                DataCell(
                  Row(
                    children: [
                      Icon(Icons.cancel, color: Colors.red),
                      SizedBox(width: 3),
                      Text('No Action'),
                    ],
                  )
                ),
                // DataCell(Row(
                //   children: [
                //     InkWell(
                //       child: Icon(Icons.edit_document, color: Colors.orange),
                //       onTap: () {},
                //     ),
                //     SizedBox(width: 8),
                //     InkWell(
                //       child: Icon(Icons.file_open, color: Colors.red),
                //       onTap: () {},
                //     ),
                //     SizedBox(width: 8),
                //     InkWell(
                //       child: Icon(Icons.qr_code, color: Colors.blue),
                //       onTap: () {},
                //     ),
                //     SizedBox(width: 8),
                //     InkWell(
                //       child: Icon(Icons.qr_code_scanner_rounded,
                //           color: Colors.green),
                //       onTap: () {},
                //     ),
                //   ],
                // )),
                DataCell(
                  Text(
                    penetapan['kategori_kd'] != null && penetapan['kategori_kd'] != ''
                      ? penetapan['kategori_kd'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['no_register'] != null && penetapan['no_register'] != ''
                      ? penetapan['no_register'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kategori_nm'] != null && penetapan['kategori_nm'] != ''
                      ? penetapan['kategori_nm'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_perolehan_formatted'] != null && penetapan['tgl_perolehan_formatted'] != ''
                      ? penetapan['tgl_perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['th_beli'] != null && penetapan['th_beli'] != ''
                      ? penetapan['th_beli'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    (penetapan['b_merk'] != null ? penetapan['b_merk'].toString() : "-") +
                    '/' +
                    (penetapan['b_type'] != null ? penetapan['b_type'].toString() : "-") +
                    '/' +
                    (penetapan['e_spek'] != null ? penetapan['e_spek'].toString() : "-"),
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_bertingkat_tidak'] != null && penetapan['c_bertingkat_tidak'] != ''
                      ? penetapan['c_bertingkat_tidak'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_beton_tidak'] != null && penetapan['c_beton_tidak'] != ''
                      ? penetapan['c_beton_tidak'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['a_luas_m2'] != null && penetapan['a_luas_m2'] != ''
                      ? penetapan['a_luas_m2'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_lokasi'] != null && penetapan['c_lokasi'] != ''
                      ? penetapan['c_lokasi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_dokumen)tanggal'] != null && penetapan['c_dokumen)tanggal'] != ''
                      ? penetapan['c_dokumen)tanggal'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_dokumen_nomor'] != null && penetapan['c_dokumen_nomor'] != ''
                      ? penetapan['c_dokumen_nomor'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['c_atatus_tanah'] != null && penetapan['c_atatus_tanah'] != ''
                      ? penetapan['c_atatus_tanah'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['perolehan_formatted'] != null && penetapan['perolehan_formatted'] != ''
                      ? penetapan['perolehan_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['asal_usul'] != null && penetapan['asal_usul'] != ''
                      ? penetapan['asal_usul'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keterangan'] != null && penetapan['keterangan'] != ''
                      ? penetapan['keterangan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['tgl_inventaris_formatted'] != null && penetapan['tgl_inventaris_formatted'] != ''
                      ? penetapan['tgl_inventaris_formatted'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['keberadaan_barang_status'] != null && penetapan['keberadaan_barang_status'] != ''
                      ? (penetapan['keberadaan_barang_status'] == 1 ? 'Ada' : 'Tidak Ada/Tidak Ditemukan')
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['kondisi'] != null && penetapan['kondisi'] != ''
                      ? penetapan['kondisi'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['penguasaan'] != null && penetapan['penguasaan'] != ''
                      ? penetapan['penguasaan'].toString()
                      : '-'
                  ),
                ),
                DataCell(
                  Text(
                    penetapan['file_nm'] != null && penetapan['file_nm'] != ''
                      ? penetapan['file_nm'].toString()
                      : '-'
                  ),
                ),
              ],
            );
          },
        );
      } else if (modifiedTitle == "UNREG") {
        return [];
      }
      return [];
    }

    return WillPopScope(
      onWillPop: () async {
        user.setPage('1');
        return true;
      },
      child: Scaffold(
        backgroundColor: primaryBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              user.setPage('1');
            },
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
              SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dropdown Departemen
                    user.login_status.value == "1" && user.group.value == "Aset_Operator_Views"
                      ? _buildContainerForInfoLogin()
                      : _buildDropdownForNonInfoLogin(),
                    SizedBox(height: 13),
                    Row(
                      children: [
                        // SKPD
                        Flexible(
                          child: TextField(
                            controller: selectedSKPD,
                            readOnly: true,
                            enabled: false,
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              disabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              labelText: 'SKPD',
                              labelStyle: TextStyle(color: Colors.grey),
                              contentPadding: EdgeInsets.all(14),
                              filled: true,
                              fillColor: Colors.grey.shade300,
                            ),
                          ),
                        ),
                        SizedBox(width: 7),
                        // Tahun
                        Flexible(
                          child: TextField(
                            controller: penetapanController.tahun,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(12)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              labelText: 'Tahun',
                              labelStyle: TextStyle(color: Colors.grey),
                              contentPadding: EdgeInsets.all(14),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(width: 7),
                        // Button Generate
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonColor,
                            padding: EdgeInsets.all(12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          onPressed: loadPenetapanData,
                          child: Icon(Icons.rocket_launch_rounded),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),
              Container(
                height: 70,
                decoration: BoxDecoration(color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      // Fitur Filter
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 48,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          iconStyleData: const IconStyleData(
                            icon: Icon(
                              Icons.arrow_drop_down_outlined,
                              color: Colors.grey,
                              size: 25,
                            ),
                            iconEnabledColor: primaryTextColor,
                          ),
                          value: filter,
                          onChanged: (String? newValue) {
                            setState(() {
                              filter = newValue ?? filter;
                            });
                          },
                          items: ['Semua', 'Sudah', 'Belum']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                      SizedBox(width: 7),
                      // Fitur Pencarian
                      Flexible(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(color: Colors.blue),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12)),
                              borderSide: BorderSide(color: Colors.grey),
                            ),
                            labelText: 'Cari berdasarkan kategori',
                            labelStyle: TextStyle(color: secondaryTextColor),
                            contentPadding: EdgeInsets.all(13),
                            prefixIcon: Icon(
                              Icons.search_rounded,
                              size: 20,
                              color: secondaryTextColor,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Table
              Container(
                height: 394,
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
              // Pagination
              Container(
                decoration: BoxDecoration(color: Colors.white),
                child: totalPage > 0
                    ? NumberPaginator(
                        numberPages: totalPage,
                        onPageChange: (int index) {
                          setState(() {
                            page = index + 1;
                          });
                          loadPenetapanData();
                        },
                        config: NumberPaginatorUIConfig(
                          buttonUnselectedForegroundColor: Color.fromARGB(255, 18, 58, 146),
                          buttonSelectedBackgroundColor: Color.fromARGB(255, 18, 58, 146),
                        ),
                      )
                    : Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text("Tidak ada data!", style: TextStyle(color: Colors.red),),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainerForInfoLogin() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade300,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15),
        child: TextFormField(
          controller: departemenSelected,
          readOnly: true,
          enabled: false,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }

  Widget _buildDropdownForNonInfoLogin() {
    final SharedPrefs user = Get.put(SharedPrefs());
    return CustomDropdown.searchRequest(
      controller: user.departemen_nm.value.isNotEmpty ? departemenSelected : searchDepartement,
      futureRequest: getDepartementData,
      futureRequestDelay: const Duration(seconds: 3),
      hintText: 'Pilih Departemen',
      borderSide: BorderSide(color: Colors.grey),
      onChanged: selectDepartemen,
    );
  }
}