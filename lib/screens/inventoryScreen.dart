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
      modifiedTitle = "aset";
    } else if (originalTitle == "KDP (F)") {
      modifiedTitle = "kdp";
    } else if (originalTitle == "Aset Lain-lain (TGR)") {
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
            SizedBox(height: 10),
            RichText(
              text: TextSpan(
                text: 'ID: ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: selectedId,
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
                  columns: [
                    DataColumn(label: Text('Edit')),
                    DataColumn(label: Text('No.')),
                    DataColumn(label: Text('Kategori Kode')),
                    DataColumn(label: Text('Reg.')),
                    DataColumn(label: Text('Uraian')),
                    DataColumn(label: Text('Tgl. Perolehan')),
                    DataColumn(label: Text('Th. Beli')),
                    DataColumn(label: Text('Luas (m2)')),
                    DataColumn(label: Text('Alamat')),
                    DataColumn(label: Text('Penggunaan')),
                    DataColumn(label: Text('Hak Tanah')),
                    DataColumn(label: Text('Th. Nilai')),
                  ],
                  rows: List<DataRow>.generate(
                    penetapanController.penetapanList.length,
                    (index) {
                      final penetapan =
                          penetapanController.penetapanList[index];
                      return DataRow(
                        cells: [
                          DataCell(InkWell(
                            child: Icon(Icons.edit_document),
                            onTap: () {
                              final id = penetapan['id'].toString();
                              penetapanController.getPenetapanById(
                                  id, modifiedTitle);
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
                          DataCell(Text(penetapan['thn_nilai'].toString())),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
