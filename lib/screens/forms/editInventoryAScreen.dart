import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:kib_application/controllers/appointmentController.dart';
import 'package:kib_application/controllers/editInventoryController.dart';

class EditInventoryAScreen extends StatefulWidget {
  const EditInventoryAScreen({super.key});

  @override
  State<EditInventoryAScreen> createState() => _EditInventoryAScreenState();
}

class _EditInventoryAScreenState extends State<EditInventoryAScreen> {
  final penetapanController = Get.put(AppointmentController());
  final editController = Get.put(EditInventoryController());
  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    String dateNow = DateFormat('dd/MM/yyyy').format(now);
    String yearNow = DateFormat.y().format(now);
    final data = penetapanController.penetapanListById[0];

    editController.tahunSekarang.text = yearNow;
    editController.tglInventaris.text = dateNow;
    editController.skpd.text = data['kode'].toString();
    editController.skpdUraian.text = data['nama'].toString();
    editController.noRegister.text = data['no_register'].toString();
    editController.barang.text =
        data['barang'].toString() + (' - ') + data['nama_barang'].toString();
    editController.namaBarang.text = '';
    editController.jumlah.text = data['jumlah'].toString();
    editController.aLuasM2.text = data['a_luas_m2'].toString();
    editController.satuan.text = data['satuan'].toString();
    editController.caraPerolehan.text = data['cara_perolehan'].toString();
    editController.tglPerolehan.text = data['tgl_perolehan'].toString();
    editController.thBeli.text = data['th_beli'].toString();
    editController.perolehan.text = data['perolehan'].toString();
    editController.aAlamat.text = data['a_alamat'].toString();
    editController.aHakTanah.text = data['a_hak_tanah'].toString();
    editController.aSertifikatNo.text = data['a_sertifikat_nomor'].toString();
    editController.aSertifikatTgl.text =
        data['a_sertifikat_tanggal'].toString();
    editController.kondisi.text = data['kondisi'].toString();
    editController.asalUsul.text = data['asal_usul'].toString();
    editController.aPenggunaan.text = data['a_penggunaan'].toString();
    editController.lat.text = data['lat'].toString();
    editController.long.text = data['long'].toString();
  }

  List<String> dropdownNoRegister = ["Sesuai", "Tidak Sesuai"];
  String selectedNoRegister = "Sesuai";

  List<String> dropdownBarang = ["Sesuai", "Tidak Sesuai"];
  String selectedBarang = "Sesuai";

  List<String> dropdownNamaBarang = ["Sesuai", "Tidak Sesuai"];
  String selectedNamaBarang = "Sesuai";

  List<String> dropdownJumlah = ["Sesuai", "Tidak Sesuai"];
  String selectedJumlah = "Sesuai";

  List<String> dropdownLuas = ["Sesuai", "Tidak Sesuai"];
  String selectedLuas = "Sesuai";

  List<String> dropdownPerolehanChoose = ["Sesuai", "Tidak Sesuai"];
  String selectedPerolehanChoose = "Sesuai";

  List<String> dropdownHakTanah = ["Sesuai", "Tidak Sesuai"];
  String selectedHakTanah = "Sesuai";

  List<String> dropdownNoSertifikat = ["Sesuai", "Tidak Sesuai"];
  String selectedNoSertifikat = "Sesuai";

  List<String> dropdownTglSertifikat = ["Sesuai", "Tidak Sesuai"];
  String selectedTglSertifikat = "Sesuai";

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
  String choose_pemerintah = "daerah";

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
        title: Text('Edit Inventaris - A'),
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
                    controller: editController.tahunSekarang,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    )
                  : SizedBox(),
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
              SizedBox(height: 15),
              Text(
                'Luas',
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
                          controller: editController.aLuasM2,
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
                      value: selectedLuas,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedLuas = newValue ?? "Sesuai";
                        });
                      },
                      items: dropdownLuas.map((String item) {
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
              selectedLuas == "Tidak Sesuai"
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
              SizedBox(height: 15),
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
                    controller: editController.satuan,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
              SizedBox(height: 10),
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
              SizedBox(height: 15),
              Text(
                'Hak Tanah',
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
                          controller: editController.aHakTanah,
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
                      value: selectedHakTanah,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedHakTanah = newValue ?? "Sesuai";
                        });
                      },
                      items: dropdownHakTanah.map((String item) {
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
              selectedHakTanah == "Tidak Sesuai"
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
              SizedBox(height: 15),
              Text(
                'No. Sertifikat',
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
                          controller: editController.aSertifikatNo,
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
                      value: selectedNoSertifikat,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedNoSertifikat = newValue ?? "Sesuai";
                        });
                      },
                      items: dropdownNoSertifikat.map((String item) {
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
              selectedNoSertifikat == "Tidak Sesuai"
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
              SizedBox(height: 15),
              Text(
                'Tanggal Sertifikat',
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
                          controller: editController.aSertifikatTgl,
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
                      value: selectedTglSertifikat,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedTglSertifikat = newValue ?? "Sesuai";
                        });
                      },
                      items: dropdownTglSertifikat.map((String item) {
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
              selectedTglSertifikat == "Tidak Sesuai"
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
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
                        color: Colors.grey.shade400,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          controller: editController.kondisi,
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
              SizedBox(height: 15),
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
                        color: Colors.grey.shade400,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          controller: editController.asalUsul,
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
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
                    color: Colors.grey.shade400),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: TextFormField(
                    controller: editController.aPenggunaan,
                    readOnly: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
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
                                      padding: const EdgeInsets.only(left: 15),
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
                                      padding: const EdgeInsets.only(left: 15),
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
              SizedBox(height: 10),
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
                                      padding: const EdgeInsets.only(left: 15),
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
                                      padding: const EdgeInsets.only(left: 15),
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
              SizedBox(height: 10),
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
                                      padding: const EdgeInsets.only(left: 15),
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
                                      padding: const EdgeInsets.only(left: 15),
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
              SizedBox(height: 20),
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
              SizedBox(height: 15),
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
              SizedBox(height: 15),
              Text(
                'Titik Koordinat',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: editController.lat,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        labelText: 'Latitude',
                        labelStyle: TextStyle(color: secondaryTextColor),
                        contentPadding: EdgeInsets.all(18),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: editController.long,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                        ),
                        labelText: 'Longitude',
                        labelStyle: TextStyle(color: secondaryTextColor),
                        contentPadding: EdgeInsets.all(18),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 15),
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
              SizedBox(height: 15),
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
              SizedBox(height: 20),
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
              SizedBox(height: 20),
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
                  onTap: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
