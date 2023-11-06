import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:kib_application/controllers/appointmentController.dart';
import 'package:kib_application/controllers/editInventoryController.dart';

class EditInventoryBScreen extends StatefulWidget {
  const EditInventoryBScreen({super.key});

  @override
  State<EditInventoryBScreen> createState() => _EditInventoryBScreenState();
}

class _EditInventoryBScreenState extends State<EditInventoryBScreen> {
  final penetapanController = Get.put(AppointmentController());
  final editController = Get.put(EditInventoryController());
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    String dateNow = DateFormat('dd/MM/yyyy').format(now);
    final data = penetapanController.penetapanListById[0];
    // FIELDS FORM
    editController.tahunNilai.text = penetapanController.tahun.text;
    editController.tglInventaris.text = dateNow;
    editController.skpd.text = data['kode'].toString();
    editController.skpdUraian.text = data['nama'].toString();
    editController.noRegister.text = data['no_register'].toString();
    editController.noRegisterBaru.text = data['no_register'].toString();
    editController.barang.text =
        data['barang'].toString() + (' - ') + data['nama_barang'].toString();
    editController.namaBarang.text = '';
    editController.jumlah.text = data['jumlah'].toString();
    editController.jumlahBaru.text = data['jumlah'].toString();
    //
    editController.satuan.text = data['satuan'].toString();
    //
    editController.caraPerolehan.text = data['cara_perolehan'].toString();
    editController.tglPerolehan.text =
        data['tgl_perolehan_formated'].toString();
    editController.thBeli.text = data['th_beli'].toString();
    editController.perolehan.text = data['perolehan'].toString();
    editController.bMerk.text = data['b_merk'].toString();
    editController.bCc.text = data['b_cc'].toString();
    editController.bNomorPolisi.text = data['b_nomor_polisi'].toString();
    editController.bNomorRangka.text = data['b_nomor_rangka'].toString();
    editController.bNomorMesin.text = data['b_nomor_mesin'].toString();
    editController.bNomorBpkb.text = data['b_nomor_bpkb'].toString();
    //
    editController.kondisi.text = data['kondisi'].toString();
    editController.asalUsul.text = data['asal_usul'].toString();
  }

  List<String> dropdownNoRegister = ["Sesuai", "Tidak Sesuai"];
  String selectedNoRegister = "Sesuai";

  List<String> dropdownBarang = ["Sesuai", "Tidak Sesuai"];
  String selectedBarang = "Sesuai";

  List<String> dropdownNamaBarang = ["Sesuai", "Tidak Sesuai"];
  String selectedNamaBarang = "Sesuai";

  List<String> dropdownJumlah = ["Sesuai", "Tidak Sesuai"];
  String selectedJumlah = "Sesuai";

  List<String> dropdownPerolehanChoose = ["Sesuai", "Tidak Sesuai"];
  String selectedPerolehanChoose = "Sesuai";

  List<String> dropdownMerk = ["Sesuai", "Tidak Sesuai"];
  String selectedMerk = "Sesuai";

  List<String> dropdownCC = ["Sesuai", "Tidak Sesuai"];
  String selectedCC = "Sesuai";

  List<String> dropdownNoPolisi = ["Sesuai", "Tidak Sesuai"];
  String selectedNoPolisi = "Sesuai";

  List<String> dropdownNoRangka = ["Sesuai", "Tidak Sesuai"];
  String selectedNoRangka = "Sesuai";

  List<String> dropdownNoMesin = ["Sesuai", "Tidak Sesuai"];
  String selectedNoMesin = "Sesuai";

  List<String> dropdownNoBPKB = ["Sesuai", "Tidak Sesuai"];
  String selectedNoBPKB = "Sesuai";

  List<String> dropdownKartuRuangan = ["Sesuai", "Tidak Sesuai"];
  String selectedKartuRuangan = "Sesuai";

  List<String> dropdownKondisi = ["Sesuai", "Tidak Sesuai"];
  String selectedKondisi = "Sesuai";

  List<String> dropdownAsalUsul = ["Sesuai", "Tidak Sesuai"];
  String selectedAsalUsul = "Sesuai";

  List<String> dropdownPerolehan = [
    "Pembelian",
    "Hibah",
    "Barang & Jasa",
    "Hasil Inventarisasi",
  ];
  String selectedPerolehan = "Pembelian";

  List<String> dropdownNilaiPerolehan = ["Sesuai", "Tidak Sesuai"];
  String selectedNilaiPerolehan = "Sesuai";

  List<String> dropdownQuestion = ["Ya", "Bukan"];
  String selectedQuestion = "Bukan";

  List<String> dropdownKeberadaanBarang = ["Ada", "Tidak ada/Tidak ditemukan"];
  String selectedKeberadaanBarang = "Ada";

  List<String> dropdownQRBarang = ["Ada", "Tidak"];
  String selectedQRBarang = "Tidak";

  List<String> dropdownQRRuangan = ["Ada", "Tidak"];
  String selectedQRRuangan = "Tidak";

  List<String> dropdownStatus = ["Sedang digunakan", "Tidak digunakan"];
  String selectedStatus = "Sedang digunakan";

  List<String> dropdownPenggunaanDaerahPusat = ["Ada", "Tidak"];
  String selectedPenggunaanDaerahPusat = "Tidak";

  List<String> dropdownPenggunaanDaerahLain = ["Ada", "Tidak"];
  String selectedPenggunaanDaerahLain = "Tidak";

  List<String> dropdownPenggunaanPihakLain = ["Ada", "Tidak"];
  String selectedPenggunaanPihakLain = "Tidak";

  List<String> dropdownGanda = ["Ya", "Tidak"];
  String selectedGanda = "Tidak";

  List<String> dropdownAtasNama = [
    "Pemerintah Daerah",
    "Pemerintah Daerah Lainnya",
    "Pemerintah Pusat",
    "Pihak Lain"
  ];
  String selectedAtasNama = "Pemerintah Daerah";

  String choose = "tidak";
  String choose_pemerintah = "";

  final ImagePicker _picker = ImagePicker();
  File? image;
  List<File> multipleImages = [];

  void _showImagePickerBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text('Galeri'),
              onTap: () async {
                final picked =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (picked != null) {
                  setState(() {
                    multipleImages.add(File(picked.path));
                  });
                }
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text('Kamera'),
              onTap: () async {
                final picked =
                    await _picker.pickImage(source: ImageSource.camera);
                if (picked != null) {
                  setState(() {
                    multipleImages.add(File(picked.path));
                  });
                }
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
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
        title: Text('Edit Inventaris - B'),
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 30),
              // Tahun
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tahun',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade400,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: editController.tahunNilai,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Tanggal Inventaris
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal Inventaris',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: editController.tglInventaris,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // SKPD
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SKPD',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade400,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: editController.skpd,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // SKPD Uraian
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SKPD Uraian',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade400,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: editController.skpdUraian,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // No Register
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'No. Register',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.noRegister,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedNoRegister,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedNoRegister = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownNoRegister.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedNoRegister == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.noRegisterBaru,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Barang
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Barang',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.barang,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedBarang,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedBarang = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownBarang.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedBarang == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Nama Spesifikasi Barang
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nama Spesifikasi Barang',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.namaBarang,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedNamaBarang,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedNamaBarang = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownNamaBarang.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedNamaBarang == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Jumlah
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jumlah',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.jumlah,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedJumlah,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedJumlah = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownJumlah.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedJumlah == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.jumlah,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Satuan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Satuan',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Perolehan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Perolehan',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.caraPerolehan,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedPerolehanChoose,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedPerolehanChoose = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownPerolehanChoose.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedPerolehanChoose == "Tidak Sesuai"
                      ? DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            buttonStyleData: ButtonStyleData(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            isExpanded: true,
                            iconStyleData: const IconStyleData(
                              icon: Icon(
                                Icons.arrow_drop_down_outlined,
                                color: Colors.grey,
                                size: 25,
                              ),
                              iconEnabledColor: primaryTextColor,
                            ),
                            value: selectedPerolehan,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedPerolehan = newValue ?? "Pembelian";
                              });
                            },
                            items: dropdownPerolehan.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Tanggal Perolehan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tanggal Perolehan',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade400,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: editController.tglPerolehan,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Tahun Perolehan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tahun Perolehan',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade400,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: editController.thBeli,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Nilai Perolehan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nilai Perolehan',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.perolehan,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedNilaiPerolehan,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedNilaiPerolehan = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownNilaiPerolehan.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedNilaiPerolehan == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Apakah nilai perolehan merupakan biaya atribusi/biasa yang menambah kapasitas manfaat?
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Apakah nilai perolehan merupakan biaya atribusi/biasa yang menambah kapasitas manfaat?',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      isExpanded: true,
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.grey,
                          size: 25,
                        ),
                        iconEnabledColor: primaryTextColor,
                      ),
                      value: selectedQuestion,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedQuestion = newValue ?? "Bukan";
                        });
                      },
                      items: dropdownQuestion.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  selectedQuestion == "Ya" // Memeriksa pilihan dropdown
                      ? Column(
                          children: [
                            RadioListTile(
                              title: Text("Tidak diketahui data awal/induknya"),
                              value: "tidak",
                              groupValue: choose,
                              onChanged: (value) {
                                setState(() {
                                  choose = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text(
                                  "Ya, Diketahui data awal/Induknya dan sebutkan data barang awal/induknya"),
                              value: "ya",
                              groupValue: choose,
                              onChanged: (value) {
                                setState(() {
                                  choose = value.toString();
                                });
                              },
                            ),
                          ],
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Alamat
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alamat',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade400,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: editController.aAlamat,
                        readOnly: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  // SizedBox(height: 15),
                  // Text(
                  //   'Kabupaten/Kota',
                  //   style: TextStyle(fontSize: 16),
                  //   textAlign: TextAlign.left,
                  // ),
                  // SizedBox(height: 10),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 15),
                  //     child: TextFormField(
                  //       decoration: const InputDecoration(
                  //         border: InputBorder.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15),
                  // Text(
                  //   'Kecamatan',
                  //   style: TextStyle(fontSize: 16),
                  //   textAlign: TextAlign.left,
                  // ),
                  // SizedBox(height: 10),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 15),
                  //     child: TextFormField(
                  //       decoration: const InputDecoration(
                  //         border: InputBorder.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15),
                  // Text(
                  //   'Kelurahan',
                  //   style: TextStyle(fontSize: 16),
                  //   textAlign: TextAlign.left,
                  // ),
                  // SizedBox(height: 10),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 15),
                  //     child: TextFormField(
                  //       decoration: const InputDecoration(
                  //         border: InputBorder.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15),
                  // Text(
                  //   'Jalan',
                  //   style: TextStyle(fontSize: 16),
                  //   textAlign: TextAlign.left,
                  // ),
                  // SizedBox(height: 10),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 15),
                  //     child: TextFormField(
                  //       decoration: const InputDecoration(
                  //         border: InputBorder.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15),
                  // Text(
                  //   'No.',
                  //   style: TextStyle(fontSize: 16),
                  //   textAlign: TextAlign.left,
                  // ),
                  // SizedBox(height: 10),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 15),
                  //     child: TextFormField(
                  //       decoration: const InputDecoration(
                  //         border: InputBorder.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15),
                  // Text(
                  //   'RT',
                  //   style: TextStyle(fontSize: 16),
                  //   textAlign: TextAlign.left,
                  // ),
                  // SizedBox(height: 10),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 15),
                  //     child: TextFormField(
                  //       decoration: const InputDecoration(
                  //         border: InputBorder.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15),
                  // Text(
                  //   'RW',
                  //   style: TextStyle(fontSize: 16),
                  //   textAlign: TextAlign.left,
                  // ),
                  // SizedBox(height: 10),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 15),
                  //     child: TextFormField(
                  //       decoration: const InputDecoration(
                  //         border: InputBorder.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(height: 15),
                  // Text(
                  //   'Kode Pos',
                  //   style: TextStyle(fontSize: 16),
                  //   textAlign: TextAlign.left,
                  // ),
                  // SizedBox(height: 10),
                  // Container(
                  //   decoration: BoxDecoration(
                  //     border: Border.all(color: Colors.grey),
                  //     borderRadius: BorderRadius.circular(12),
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(left: 15),
                  //     child: TextFormField(
                  //       decoration: const InputDecoration(
                  //         border: InputBorder.none,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 15),
              // Merk/Tipe
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Merk/Tipe',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.bMerk,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedMerk,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedMerk = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownMerk.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedMerk == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Ukuran CC
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ukuran CC',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.bCc,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedCC,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCC = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownCC.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedCC == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Nomor Polisi
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nomor Polisi',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.bNomorPolisi,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedNoPolisi,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedNoPolisi = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownNoPolisi.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedNoPolisi == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Nomor Rangka
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nomor Rangka',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.bNomorRangka,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedNoRangka,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedNoRangka = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownNoRangka.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedNoRangka == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Nomor Mesin
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nomor Mesin',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.bNomorMesin,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedNoMesin,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedNoMesin = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownNoMesin.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedNoMesin == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Nomor BPKB
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nomor BPKB',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.bNomorBpkb,
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedNoBPKB,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedNoBPKB = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownNoBPKB.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedNoBPKB == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Kartu Inventaris Ruangan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kartu Inventaris Ruangan',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedKartuRuangan,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedKartuRuangan = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownKartuRuangan.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedKartuRuangan == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Barcode Barang
              Row(
                children: [
                  Text(
                    'Barcode Barang',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(width: 25),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        isExpanded: true,
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Colors.grey,
                            size: 25,
                          ),
                          iconEnabledColor: primaryTextColor,
                        ),
                        value: selectedQRBarang,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedQRBarang = newValue ?? "Tidak";
                          });
                        },
                        items: dropdownQRBarang.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Barcode Ruangan
              Row(
                children: [
                  Text(
                    'Barcode Ruangan',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2(
                        buttonStyleData: ButtonStyleData(
                          height: 50,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        isExpanded: true,
                        iconStyleData: const IconStyleData(
                          icon: Icon(
                            Icons.arrow_drop_down_outlined,
                            color: Colors.grey,
                            size: 25,
                          ),
                          iconEnabledColor: primaryTextColor,
                        ),
                        value: selectedQRRuangan,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedQRRuangan = newValue ?? "Tidak";
                          });
                        },
                        items: dropdownQRRuangan.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Keberadaan Barang
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Keberadaan Barang',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      isExpanded: true,
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.grey,
                          size: 25,
                        ),
                        iconEnabledColor: primaryTextColor,
                      ),
                      value: selectedKeberadaanBarang,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedKeberadaanBarang = newValue ?? "Ada";
                        });
                      },
                      items: dropdownKeberadaanBarang.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Kondisi
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kondisi',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedKondisi,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedKondisi = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownKondisi.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedKondisi == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Asal Usul
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Asal Usul',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          buttonStyleData: ButtonStyleData(
                            height: 50,
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
                          value: selectedAsalUsul,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedAsalUsul = newValue ?? "Sesuai";
                            });
                          },
                          items: dropdownAsalUsul.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  selectedAsalUsul == "Tidak Sesuai"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Penggunaan Status
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Penggunaan Status',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      isExpanded: true,
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.grey,
                          size: 25,
                        ),
                        iconEnabledColor: primaryTextColor,
                      ),
                      value: selectedStatus,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedStatus = newValue ?? "Sedang digunakan";
                        });
                      },
                      items: dropdownStatus.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Penggunaan Barang
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Penggunaan barang',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Pemerintah Daerah
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile(
                    title: Text("Pemerintah Daerah"),
                    value: "daerah",
                    groupValue: choose_pemerintah,
                    onChanged: (value) {
                      setState(() {
                        choose_pemerintah = value.toString();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nama Kuasa Pengguna Barang lainnya/Pengguna Barang lainnya',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              // Pemerintah Pusat
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile(
                    title: Text("Pemerintah Pusat"),
                    value: "pusat",
                    groupValue: choose_pemerintah,
                    onChanged: (value) {
                      setState(() {
                        choose_pemerintah = value.toString();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Dasar Penggunaan',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      isExpanded: true,
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.grey,
                          size: 25,
                        ),
                        iconEnabledColor: primaryTextColor,
                      ),
                      value: selectedPenggunaanDaerahPusat,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPenggunaanDaerahPusat = newValue ?? "Tidak";
                        });
                      },
                      items: dropdownPenggunaanDaerahPusat.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  selectedPenggunaanDaerahPusat == "Ada"
                      ? Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Nama',
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(width: 72),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: IntrinsicWidth(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Text(
                                    'Nama Dokumen',
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: IntrinsicWidth(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 10),
              // Pemerintah Daerah Lain
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile(
                    title: Text("Pemerintah Daerah Lain"),
                    value: "daerah_lain",
                    groupValue: choose_pemerintah,
                    onChanged: (value) {
                      setState(() {
                        choose_pemerintah = value.toString();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Dasar Penggunaan',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      isExpanded: true,
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.grey,
                          size: 25,
                        ),
                        iconEnabledColor: primaryTextColor,
                      ),
                      value: selectedPenggunaanDaerahLain,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPenggunaanDaerahLain = newValue ?? "Ya";
                        });
                      },
                      items: dropdownPenggunaanDaerahLain.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  selectedPenggunaanDaerahLain == "Ada"
                      ? Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Nama',
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(width: 72),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: IntrinsicWidth(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Text(
                                    'Nama Dokumen',
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: IntrinsicWidth(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 10),
              // Pihak Lain
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RadioListTile(
                    title: Text("Pihak Lain"),
                    value: "pihak_lain",
                    groupValue: choose_pemerintah,
                    onChanged: (value) {
                      setState(() {
                        choose_pemerintah = value.toString();
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Dasar Penggunaan',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      isExpanded: true,
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.grey,
                          size: 25,
                        ),
                        iconEnabledColor: primaryTextColor,
                      ),
                      value: selectedPenggunaanPihakLain,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedPenggunaanPihakLain = newValue ?? "Ya";
                        });
                      },
                      items: dropdownPenggunaanPihakLain.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  selectedPenggunaanPihakLain == "Ada"
                      ? Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Nama',
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(width: 72),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: IntrinsicWidth(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Row(
                                children: [
                                  Text(
                                    'Nama Dokumen',
                                    style: TextStyle(fontSize: 16),
                                    textAlign: TextAlign.left,
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: IntrinsicWidth(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: TextFormField(
                                            decoration: const InputDecoration(
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 25),
              // Tercatan Ganda
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tercatat Ganda',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      isExpanded: true,
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.grey,
                          size: 25,
                        ),
                        iconEnabledColor: primaryTextColor,
                      ),
                      value: selectedGanda,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedGanda = newValue ?? "Ya";
                        });
                      },
                      items: dropdownGanda.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Atas Nama
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Atas Nama',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  DropdownButtonHideUnderline(
                    child: DropdownButton2(
                      buttonStyleData: ButtonStyleData(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      isExpanded: true,
                      iconStyleData: const IconStyleData(
                        icon: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: Colors.grey,
                          size: 25,
                        ),
                        iconEnabledColor: primaryTextColor,
                      ),
                      value: selectedAtasNama,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedAtasNama = newValue ?? "Pemerintah Daerah";
                        });
                      },
                      items: dropdownAtasNama.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Lainnya
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lainnya',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
              // Keterangan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Keterangan',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Tambah File
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Tambah File",
                        style: TextStyle(fontSize: 16),
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.add_photo_alternate_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onTap: () {
                          _showImagePickerBottomSheet();
                        },
                      ),
                    ],
                  ),
                  multipleImages.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 18),
                          child: Container(
                            height: 110,
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 35,
                              ),
                              itemCount: multipleImages.length,
                              itemBuilder: (context, index) {
                                return GridTile(
                                    child: Image.file(multipleImages[index]));
                              },
                            ),
                          ),
                        )
                      : SizedBox(height: 0),
                ],
              ),
              SizedBox(height: 20),
              // Petugas
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Petugas',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 35),
                child: GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                        child: Text(
                      'Simpan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    )),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
