import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:kib_application/controllers/appointmentController.dart';
import 'package:kib_application/controllers/departementController.dart';

class InventoryScreen extends StatefulWidget {
  final String title;
  InventoryScreen({super.key, required this.title});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  final departemenController = Get.put(DepartemenController());
  final penetapanController = Get.put(AppointmentController());

  final searchDepartement = TextEditingController();
  final departemenSelected = TextEditingController();

  String selectedSKPD = '0.00.000';
  String selectedId = '';
  String modifiedTitle = "";

  List<DataColumn> columns = [];
  List<DataColumn> rows = [];

  void modifyTitle(String originalTitle) {
    if (originalTitle == "Tanah (A)") {
      modifiedTitle = "tanah";
    } else if (originalTitle == "Peralatan dan Mesin (B)") {
      modifiedTitle = "perkakas";
    } else if (originalTitle == "Gedung dan Bangunan (C)") {
      modifiedTitle = "bangunan";
    } else if (originalTitle == "Jalan, Jaringan, dan Irigasi (D)") {
      modifiedTitle = "infrastruktur";
    } else if (originalTitle == "Aset Tetap Lainnya (E)") {
      modifiedTitle = "asetTetap";
    } else if (originalTitle == "KDP (F)") {
      modifiedTitle = "kdp";
    } else if (originalTitle == "Aset Lain-lain (TGR/RB/AK)") {
      modifiedTitle = "tgr";
    } else if (originalTitle == "Aset Lain-lain (ATB)") {
      modifiedTitle = "atb";
    } else {
      modifiedTitle = "lainnya";
    }
  }

  @override
  void initState() {
    super.initState();
    departemenController.getDepartemen();
    modifyTitle(widget.title);
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
    await penetapanController.getPenetapan(selectedId, modifiedTitle);
  }

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
    loadPenetapanData();
  }

  @override
  Widget build(BuildContext context) {
    if (modifiedTitle == "tanah") {
      columns = [
        DataColumn(label: Text('Edit')),
        DataColumn(label: Text('No.')),
        DataColumn(label: Text('Kategori Kode')),
        DataColumn(label: Text('Reg.')),
        DataColumn(label: Text('Uraian')),
        DataColumn(label: Text('Tgl. Perolehan')),
        DataColumn(label: Text('Th. Beli')),
        // Column Khusus Perkategori
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
        // DataColumn(label: Text('Tgl Inventaris')),
        // DataColumn(label: Text('Keberadaan Fisik')),
        // DataColumn(label: Text('Kondisi Fisik')),
        // DataColumn(label: Text('Penguasaan')),
        // DataColumn(label: Text('Doc')),
      ];
    } else if (modifiedTitle == "perkakas") {
      columns = [
        DataColumn(label: Text('Edit')),
        DataColumn(label: Text('No.')),
        DataColumn(label: Text('Kategori Kode')),
        DataColumn(label: Text('Reg.')),
        DataColumn(label: Text('Uraian')),
        DataColumn(label: Text('Tgl. Perolehan')),
        DataColumn(label: Text('Th. Beli')),
        // Column Khusus Perkategori
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
        // DataColumn(label: Text('Tgl Inventaris')),
        // DataColumn(label: Text('Keberadaan Fisik')),
        // DataColumn(label: Text('Kondisi Fisik')),
        // DataColumn(label: Text('Penguasaan')),
        // DataColumn(label: Text('Doc')),
      ];
    } else if (modifiedTitle == "bangunan") {
    } else if (modifiedTitle == "insfrastruktur") {
    } else if (modifiedTitle == "asetTetap") {
    } else if (modifiedTitle == "kdp") {
    } else if (modifiedTitle == "tgr") {
    } else if (modifiedTitle == "atb") {
    } else if (modifiedTitle == "lainnya") {}

    List<DataRow> generateDataRows() {
      if (modifiedTitle == "tanah") {
        return List<DataRow>.generate(
          penetapanController.penetapanList.length,
          (index) {
            final penetapan = penetapanController.penetapanList[index];
            return DataRow(
              cells: [
                DataCell(InkWell(
                  child: Icon(Icons.edit_document),
                  onTap: () {
                    final id = penetapan['id'].toString();
                    penetapanController.getPenetapanById(id, modifiedTitle);
                  },
                )),
                DataCell(Text('${index + 1}')),
                DataCell(Text(penetapan['kategori_kode'].toString())),
                DataCell(Text(penetapan['no_register'].toString())),
                DataCell(Text(penetapan['uraian'].toString())),
                DataCell(Text(penetapan['tgl_perolehan'].toString())),
                DataCell(Text(penetapan['th_beli'].toString())),
                DataCell(Text(penetapan['a_luas_m2'].toString())),
                DataCell(Text(penetapan['a_alamat'].toString())),
                DataCell(Text(penetapan['a_penggunaan'].toString())),
                DataCell(Text(penetapan['a_hak_tanah'].toString())),
                DataCell(Text(penetapan['a_sertifikat_tanggal'].toString())),
                DataCell(Text(penetapan['a_sertifikat_nomor'].toString())),
                DataCell(Text(penetapan['harga'].toString())),
                DataCell(Text(penetapan['kondisi'].toString())),
                DataCell(Text(penetapan['asal_usul'].toString())),
                DataCell(Text(penetapan['keterangan'].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
              ],
            );
          },
        );
      } else if (modifiedTitle == "perkakas") {
        return List<DataRow>.generate(
          penetapanController.penetapanList.length,
          (index) {
            final penetapan = penetapanController.penetapanList[index];
            return DataRow(
              cells: [
                DataCell(InkWell(
                  child: Icon(Icons.edit_document),
                  onTap: () {
                    final id = penetapan['id'].toString();
                    penetapanController.getPenetapanById(id, modifiedTitle);
                  },
                )),
                DataCell(Text('${index + 1}')),
                DataCell(Text(penetapan['kategori_kode'].toString())),
                DataCell(Text(penetapan['no_register'].toString())),
                DataCell(Text(penetapan['uraian'].toString())),
                DataCell(Text(penetapan['tgl_perolehan'].toString())),
                DataCell(Text(penetapan['th_beli'].toString())),
                DataCell(Text(penetapan['b_cc'].toString())),
                DataCell(Text(penetapan['b_bahan'].toString())),
                DataCell(Text(penetapan['b_nomor_pabrik'].toString())),
                DataCell(Text(penetapan['b_nomor_rangka'].toString())),
                DataCell(Text(penetapan['b_nomor_mesin'].toString())),
                DataCell(Text(penetapan['b_nomor_polisi'].toString())),
                DataCell(Text(penetapan['b_nomor_bpkb'].toString())),
                DataCell(Text(penetapan['b_merk'].toString())),
                DataCell(Text(penetapan['b_type'].toString())),
                DataCell(Text(penetapan['harga'].toString())),
                DataCell(Text(penetapan['kondisi'].toString())),
                DataCell(Text(penetapan['asal_usul'].toString())),
                DataCell(Text(penetapan['keterangan'].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
                // DataCell(Text(penetapan[''].toString())),
              ],
            );
          },
        );
      } else if (modifiedTitle == "bangunan") {
      } else if (modifiedTitle == "insfrastruktur") {
      } else if (modifiedTitle == "asetTetap") {
      } else if (modifiedTitle == "kdp") {
      } else if (modifiedTitle == "tgr") {
      } else if (modifiedTitle == "atb") {
      } else if (modifiedTitle == "lainnya") {}
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            CustomDropdown.searchRequest(
              controller: searchDepartement,
              futureRequest: getDepartementData,
              futureRequestDelay: const Duration(seconds: 3),
              hintText: 'Pilih Departemen',
              onChanged: selectDepartemen,
            ),
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
            SizedBox(height: 30),
            Obx(
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 202, 202, 202)),
                  columnSpacing: 40,
                  decoration: BoxDecoration(
                    border: Border(
                      right: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                    ),
                  ),
                  columns: columns,
                  rows: generateDataRows(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
