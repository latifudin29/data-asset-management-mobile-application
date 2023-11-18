import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:kib_application/controllers/appointmentController.dart';
import 'package:kib_application/controllers/categoryController.dart';
import 'package:kib_application/controllers/inventoryAController.dart';
import 'package:kib_application/utils/snackbar.dart';

class EditInventoryAScreen extends StatefulWidget {
  const EditInventoryAScreen({super.key});

  @override
  State<EditInventoryAScreen> createState() => _EditInventoryAScreenState();
}

class _EditInventoryAScreenState extends State<EditInventoryAScreen> {
  final penetapanController = Get.put(AppointmentController());
  final editController = Get.put(InventoryAController());
  final kategoriController = Get.put(CategoryController());
  DateTime now = DateTime.now();

  String selectedKategori = '';

  @override
  void initState() {
    super.initState();
    kategoriController.getKategori("A");
    String dateNow = DateFormat('dd-MM-yyyy').format(now);
    final data = penetapanController.penetapanListById[0];
    selectedKategori = data['id_kategori'].toString();

    editController.a_tgl_inventaris.text = dateNow;
    editController.a_skpd.text = data['kode'].toString();
    editController.a_skpd_uraian.text = data['nama'].toString();
    editController.a_no_register_awal.text = data['no_register'].toString();
    editController.a_no_register_akhir.text = data['no_register'].toString();
    editController.a_kategori_id_awal.text = data['kategori_id'].toString();
    editController.a_barang.text =
        data['kode_kategori'].toString() + ' - ' + data['nama_kategori'];
    editController.a_jumlah_awal.text = data['jumlah'].toString();
    editController.a_jumlah_akhir.text = data['jumlah'].toString();
    editController.a_luas_m2_awal.text = data['a_luas_m2'].toString();
    editController.a_luas_m2_akhir.text = data['a_luas_m2'].toString();
    editController.a_satuan.text = data['satuan'].toString();
    editController.a_cara_perolehan_awal.text =
        data['cara_perolehan'].toString();
    editController.a_tgl_perolehan.text =
        data['tgl_perolehan_formated'].toString();
    editController.a_tahun_perolehan.text = data['tahun'].toString();
    editController.a_perolehan_awal.text =
        data['perolehan_formated'].toString();
    editController.a_perolehan_akhir.text =
        data['perolehan_formated'].toString();
    editController.a_alamat_awal.text = data['a_alamat'].toString();
    editController.a_hak_tanah_awal.text = data['a_hak_tanah'].toString();
    editController.a_hak_tanah_akhir.text = data['a_hak_tanah'].toString();
    editController.a_sertifikat_nomor_awal.text =
        data['a_sertifikat_nomor'].toString();
    editController.a_sertifikat_nomor_akhir.text =
        data['a_sertifikat_nomor'].toString();
    editController.a_sertifikat_tanggal_awal.text =
        data['sertifikat_tgl'].toString();
    editController.a_sertifikat_tanggal_akhir.text =
        data['sertifikat_tgl'].toString();
    editController.a_keberadaan_barang_awal.text =
        data['keberadaan_barang'].toString();
    editController.a_kondisi_awal.text = data['kondisi'].toString();
    editController.a_asal_usul_awal.text = data['asal_usul'].toString();
    editController.a_asal_usul_akhir.text = data['asal_usul'].toString();
    editController.a_penggunaan_awal.text = data['a_penggunaan'].toString();
    editController.a_pemilik_id.text = data['pemilik_id'].toString();
    editController.a_lat.text = data['lat'].toString();
    editController.a_long.text = data['long'].toString();
    editController.a_lainnya.text = data['lainnya'].toString();
    editController.a_keterangan.text = data['keterangan'].toString();
    // File
    // Petugas
  }

  // No Register
  List<String> keteranganNoRegister = ["Sesuai", "Tidak Sesuai"];
  String statusNoRegister = "1";

  // Barang
  List<String> keteranganBarang = ["Sesuai", "Tidak Sesuai"];
  String statusBarang = "1";

  // Nama Barang
  List<String> keteranganNamaBarang = ["Sesuai", "Tidak Sesuai"];
  String statusNamaBarang = "1";

  // Jumlah
  List<String> keteranganJumlah = ["Sesuai", "Tidak Sesuai"];
  String statusJumlah = "1";

  // Luas
  List<String> keteranganLuas = ["Sesuai", "Tidak Sesuai"];
  String statusLuas = "1";

  // Perolehan
  List<String> keteranganPerolehan = ["Sesuai", "Tidak Sesuai"];
  String statusPerolehan = "1";

  // Nilai Perolehan
  List<String> keteranganNilaiPerolehan = ["Sesuai", "Tidak Sesuai"];
  String statusNilaiPerolehan = "1";

  // Alamat
  List<String> keteranganAlamat = ["Sesuai", "Tidak Sesuai"];
  String statusAlamat = "1";

  // Hak Tanah
  List<String> keteranganHakTanah = ["Sesuai", "Tidak Sesuai"];
  String statusHakTanah = "1";

  // No Sertifikat
  List<String> keteranganNoSertifikat = ["Sesuai", "Tidak Sesuai"];
  String statusNoSertifikat = "1";

  // Tanggal Sertifikat
  List<String> keteranganTglSertifikat = ["Sesuai", "Tidak Sesuai"];
  String statusTglSertifikat = "1";

  // Kondisi
  List<String> keteranganKondisi = ["Sesuai", "Tidak Sesuai"];
  String statusKondisi = "1";

  // Asal Usul
  List<String> keteranganAsalUsul = ["Sesuai", "Tidak Sesuai"];
  String statusAsalUsul = "1";

  List<String> dropdownSatuan = [
    "PAKET",
    "KALI",
    "LEMBAR",
    "RIM",
    "MILIMETER",
    "CENTIMETER",
    "METER",
    "KILOMETER",
    "BOTOL",
  ];
  String selectedSatuan = "PAKET";

  List<String> dropdownPerolehan = [
    "Pembelian",
    "Hibah",
    "Barang & Jasa",
    "Hasil Inventarisasi",
  ];
  String selectedPerolehan = "Pembelian";

  List<String> dropdownKondisi = [
    "B",
    "RR",
    "RB",
  ];
  String selectedKondisi = "B";

  List<String> keteranganQuestion = ["Ya", "Bukan"];
  String statusQuestion = "Bukan";

  List<String> keteranganKeberadaanBarang = [
    "Ada",
    "Tidak ada/Tidak ditemukan"
  ];
  String statusKeberadaanBarang = "Ada";

  List<String> keteranganStatus = ["Sedang digunakan", "Tidak digunakan"];
  String statusStatus = "Sedang digunakan";

  List<String> keteranganPenggunaanDaerahPusat = ["Ada", "Tidak"];
  String statusPenggunaanDaerahPusat = "Tidak";

  List<String> keteranganPenggunaanDaerahLain = ["Ada", "Tidak"];
  String statusPenggunaanDaerahLain = "Tidak";

  List<String> keteranganPenggunaanPihakLain = ["Ada", "Tidak"];
  String statusPenggunaanPihakLain = "Tidak";

  List<String> keteranganGanda = ["Ya", "Tidak"];
  String statusGanda = "Tidak";

  List<String> keteranganAtasNama = [
    "Pemerintah Daerah",
    "Pemerintah Daerah Lainnya",
    "Pemerintah Pusat",
    "Pihak Lain"
  ];
  String statusAtasNama = "Pemerintah Daerah";

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
                        controller: editController.a_tgl_inventaris,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2030),
                          );
                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);
                            print(formattedDate);

                            setState(() {
                              editController.a_tgl_inventaris.text =
                                  formattedDate;
                            });
                          } else {
                            print("Tanggal tidak dipilih");
                          }
                        },
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
                        controller: editController.a_skpd,
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
                        controller: editController.a_skpd_uraian,
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
                              controller: editController.a_no_register_awal,
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
                          value: statusNoRegister,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusNoRegister = newValue ?? "1";
                            });
                          },
                          items: keteranganNoRegister.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganNoRegister.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  statusNoRegister == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.a_no_register_akhir,
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
                              controller: editController.a_barang,
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
                          value: statusBarang,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusBarang = newValue ?? "1";
                            });
                          },
                          items: keteranganBarang.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganBarang.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                    visible: false,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade400,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: TextFormField(
                          controller: editController.a_kategori_id_awal,
                          readOnly: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  statusBarang == "2"
                      ? DropdownButtonHideUnderline(
                          child: DropdownButton2(
                            isExpanded: true,
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
                            value: selectedKategori,
                            onChanged: (String? newValue) {
                              print('Selected Value: $newValue');
                              setState(() {
                                selectedKategori = newValue ?? '';
                              });
                            },
                            items: kategoriController.kategoriList
                                .map<DropdownMenuItem<String>>(
                              (Map<String, dynamic> item) {
                                return DropdownMenuItem<String>(
                                  value: item['id'].toString(),
                                  child: Text(
                                    item['kode'] + ' - ' + item['nama'],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                );
                              },
                            ).toList(),
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
                          value: statusNamaBarang,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusNamaBarang = newValue ?? "1";
                            });
                          },
                          items: keteranganNamaBarang.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganNamaBarang.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  statusNamaBarang == "2"
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
                              controller: editController.a_jumlah_awal,
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
                          value: statusJumlah,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusJumlah = newValue ?? "1";
                            });
                          },
                          items: keteranganJumlah.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganJumlah.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  statusJumlah == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.a_jumlah_akhir,
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
              // Luas
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              controller: editController.a_luas_m2_awal,
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
                          value: statusLuas,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusLuas = newValue ?? "1";
                            });
                          },
                          items: keteranganLuas.map((String item) {
                            return DropdownMenuItem<String>(
                              value:
                                  keteranganLuas.indexOf(item) == 0 ? "1" : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  statusLuas == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.a_luas_m2_akhir,
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
                      value: selectedSatuan,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedSatuan = newValue ?? "PAKET";
                        });
                      },
                      items: dropdownSatuan.map((String item) {
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
                              controller: editController.a_cara_perolehan_awal,
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
                          value: statusPerolehan,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusPerolehan = newValue ?? "1";
                            });
                          },
                          items: keteranganPerolehan.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganPerolehan.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  statusPerolehan == "2"
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
                        controller: editController.a_tgl_perolehan,
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
                        controller: editController.a_tahun_perolehan,
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
                              controller: editController.a_perolehan_awal,
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
                          value: statusNilaiPerolehan,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusNilaiPerolehan = newValue ?? "1";
                            });
                          },
                          items: keteranganNilaiPerolehan.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganNilaiPerolehan.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  statusNilaiPerolehan == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.a_perolehan_akhir,
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
                      value: statusQuestion,
                      onChanged: (String? newValue) {
                        setState(() {
                          statusQuestion = newValue ?? "Bukan";
                        });
                      },
                      items: keteranganQuestion.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  statusQuestion == "Ya"
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
                              controller: editController.a_alamat_awal,
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
                          value: statusAlamat,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusAlamat = newValue ?? "1";
                            });
                          },
                          items: keteranganAlamat.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganAlamat.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  statusAlamat == "2"
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Kabupaten/Kota',
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
                              'Kecamatan',
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
                              'Kelurahan',
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
                              'Jalan',
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
                              'No.',
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
                              'RT',
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
                              'RW',
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
                              'Kode Pos',
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
                        )
                      : SizedBox(),
                ],
              ),
              SizedBox(height: 15),
              // Hak Tanah
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              controller: editController.a_hak_tanah_awal,
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
                          value: statusHakTanah,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusHakTanah = newValue ?? "1";
                            });
                          },
                          items: keteranganHakTanah.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganHakTanah.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  statusHakTanah == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.a_hak_tanah_akhir,
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
              // No Sertifikat
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              controller:
                                  editController.a_sertifikat_nomor_awal,
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
                          value: statusNoSertifikat,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusNoSertifikat = newValue ?? "1";
                            });
                          },
                          items: keteranganNoSertifikat.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganNoSertifikat.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  statusNoSertifikat == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller:
                                  editController.a_sertifikat_nomor_akhir,
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
              // Tanggal Sertifikat
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              controller:
                                  editController.a_sertifikat_tanggal_awal,
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
                          value: statusTglSertifikat,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusTglSertifikat = newValue ?? "1";
                            });
                          },
                          items: keteranganTglSertifikat.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganTglSertifikat.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  statusTglSertifikat == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller:
                                  editController.a_sertifikat_tanggal_akhir,
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
                      value: statusKeberadaanBarang,
                      onChanged: (String? newValue) {
                        setState(() {
                          statusKeberadaanBarang = newValue ?? "Ada";
                        });
                      },
                      items: keteranganKeberadaanBarang.map((String item) {
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
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.a_kondisi_awal,
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
                          value: statusKondisi,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusKondisi = newValue ?? "1";
                            });
                          },
                          items: keteranganKondisi.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganKondisi.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  statusKondisi == "2"
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
                            value: selectedKondisi,
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedKondisi = newValue ?? "B";
                              });
                            },
                            items: dropdownKondisi.map((String item) {
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
                            color: Colors.grey.shade400,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.a_asal_usul_awal,
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
                          value: statusAsalUsul,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusAsalUsul = newValue ?? "1";
                            });
                          },
                          items: keteranganAsalUsul.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganAsalUsul.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  statusAsalUsul == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.a_asal_usul_akhir,
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
                      value: statusStatus,
                      onChanged: (String? newValue) {
                        setState(() {
                          statusStatus = newValue ?? "Sedang digunakan";
                        });
                      },
                      items: keteranganStatus.map((String item) {
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
                        color: Colors.grey.shade400),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: editController.a_penggunaan_awal,
                        readOnly: true,
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
                      value: statusPenggunaanDaerahPusat,
                      onChanged: (String? newValue) {
                        setState(() {
                          statusPenggunaanDaerahPusat = newValue ?? "Tidak";
                        });
                      },
                      items: keteranganPenggunaanDaerahPusat.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  statusPenggunaanDaerahPusat == "Ada"
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
                      value: statusPenggunaanDaerahLain,
                      onChanged: (String? newValue) {
                        setState(() {
                          statusPenggunaanDaerahLain = newValue ?? "Ya";
                        });
                      },
                      items: keteranganPenggunaanDaerahLain.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  statusPenggunaanDaerahLain == "Ada"
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
                      value: statusPenggunaanPihakLain,
                      onChanged: (String? newValue) {
                        setState(() {
                          statusPenggunaanPihakLain = newValue ?? "Ya";
                        });
                      },
                      items: keteranganPenggunaanPihakLain.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  statusPenggunaanPihakLain == "Ada"
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
              SizedBox(height: 20),
              // Tercatat Ganda
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
                      value: statusGanda,
                      onChanged: (String? newValue) {
                        setState(() {
                          statusGanda = newValue ?? "Tidak";
                        });
                      },
                      items: keteranganGanda.map((String item) {
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
                      value: statusAtasNama,
                      onChanged: (String? newValue) {
                        setState(() {
                          statusAtasNama = newValue ?? "Pemerintah Daerah";
                        });
                      },
                      items: keteranganAtasNama.map((String item) {
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
              // Titik Koordinat
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                          controller: editController.a_lat,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
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
                          controller: editController.a_long,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            labelText: 'Longitude',
                            labelStyle: TextStyle(color: secondaryTextColor),
                            contentPadding: EdgeInsets.all(18),
                          ),
                        ),
                      ),
                    ],
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
              // Button Simpan
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
                  onTap: () {
                    Navigator.of(context).pop();
                    customSnackBar(
                        "Success", "Inventarisasi Berhasil", 'success');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
