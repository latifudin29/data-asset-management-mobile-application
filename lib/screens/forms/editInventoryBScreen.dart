import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:kib_application/controllers/appointmentController.dart';
import 'package:kib_application/controllers/categoryController.dart';
import 'package:kib_application/controllers/inventoryBController.dart';
import 'package:kib_application/controllers/unitController.dart';

class EditInventoryBScreen extends StatefulWidget {
  const EditInventoryBScreen({super.key});

  @override
  State<EditInventoryBScreen> createState() => _EditInventoryBScreenState();
}

class _EditInventoryBScreenState extends State<EditInventoryBScreen> {
  final penetapanController = Get.put(AppointmentController());
  final editController = Get.put(InventoryBController());
  final kategoriController = Get.put(CategoryController());
  final satuanController = Get.put(UnitController());
  DateTime now = DateTime.now();

  String statusNoRegister = "";
  String statusBarang = "";
  String statusNamaBarang = "";
  String statusPerolehan = "";
  String statusNilaiPerolehan = "";
  String statusAlamat = "";
  String statusKondisi = "";
  String statusAsalUsul = "";
  String statusMerk = "";
  String statusCC = "";
  String statusNoPolisi = "";
  String statusNoRangka = "";
  String statusNoMesin = "";
  String statusNoBPKB = "";
  String statusBahan = "";
  String statusNoPabrik = "";
  String statusKartuRuangan = "";

  String selectedKategori = "";
  String selectedSatuan = "";

  List<String> keteranganNoRegister = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganBarang = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNamaBarang = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganPerolehan = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNilaiPerolehan = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganAlamat = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganMerk = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganCC = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoPolisi = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoRangka = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoMesin = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoBPKB = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganBahan = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoPabrik = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganKartuRuangan = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganKondisi = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganAsalUsul = ["Sesuai", "Tidak Sesuai"];

  @override
  void initState() {
    super.initState();
    final data = penetapanController.penetapanListById[0];

    statusNoRegister = data['no_register_status'] != ""
        ? data['no_register_status'].toString()
        : "1";
    statusBarang = data['kategori_id_status'] != ""
        ? data['kategori_id_status'].toString()
        : "1";
    statusNamaBarang = data['nama_spesifikasi_status'] != ""
        ? data['nama_spesifikasi_status'].toString()
        : "1";
    statusPerolehan = data['cara_perolehan_status'] != ""
        ? data['cara_perolehan_status'].toString()
        : "1";
    statusNilaiPerolehan = data['perolehan_status'] != ""
        ? data['perolehan_status'].toString()
        : "1";
    statusAlamat = data['a_alamat_status'] != ""
        ? data['a_alamat_status'].toString()
        : "1";
    statusMerk =
        data['b_merk_status'] != "" ? data['b_merk_status'].toString() : "1";
    statusCC = data['b_cc_status'] != "" ? data['b_cc_status'].toString() : "1";
    statusNoPolisi = data['b_nomor_polisi_status'] != ""
        ? data['b_nomor_polisi_status'].toString()
        : "1";
    statusNoRangka = data['b_nomor_rangka_status'] != ""
        ? data['b_nomor_rangka_status'].toString()
        : "1";
    statusNoMesin = data['b_nomor_mesin_status'] != ""
        ? data['b_nomor_mesin_status'].toString()
        : "1";
    statusNoBPKB = data['b_nomor_bpkb_status'] != ""
        ? data['b_nomor_bpkb_status'].toString()
        : "1";
    statusBahan =
        data['b_bahan_status'] != "" ? data['b_bahan_status'].toString() : "1";
    statusNoPabrik = data['b_nomor_pabrik_status'] != ""
        ? data['b_nomor_pabrik_status'].toString()
        : "1";
    statusKartuRuangan = data['kartu_inv_status'] != ""
        ? data['kartu_inv_status'].toString()
        : "1";
    statusKondisi =
        data['kondisi_status'] != "" ? data['kondisi_status'].toString() : "1";
    statusAsalUsul = data['asal_usul_status'] != ""
        ? data['asal_usul_status'].toString()
        : "1";

    selectedKategori = data['kategori_id_awal'].toString();
    selectedSatuan = data['satuan'] != "" ? data['satuan'].toString() : "PAKET";

    editController.tgl_inventaris.text =
        data['tgl_inventaris_formatted'].toString();
    editController.skpd.text = data['departemen_kd'].toString();
    editController.skpd_uraian.text = data['departemen_nm'].toString();
    editController.no_register_awal.text = data['no_register_awal'].toString();
    editController.no_register_akhir.text =
        data['no_register_akhir'].toString();
    editController.barang.text =
        data['kategori_kd'].toString() + ' - ' + data['kategori_nm'].toString();
    editController.kategori_id_awal.text = data['kategori_id_awal'].toString();
    editController.kategori_id_akhir.text =
        data['kategori_id_akhir'].toString();
    editController.nama_spesifikasi_awal.text =
        data['nama_spesifikasi_awal'] != null
            ? data['nama_spesifikasi_awal'].toString()
            : '';
    editController.nama_spesifikasi_akhir.text =
        data['nama_spesifikasi_akhir'].toString();
    editController.jumlah_awal.text = data['jumlah_awal'].toString();
    editController.jumlah_akhir.text = data['jumlah_akhir'].toString();
    editController.satuan.text = data['satuan'].toString();
    editController.cara_perolehan_awal.text =
        data['cara_perolehan_awal'].toString();
    editController.cara_perolehan_akhir.text =
        data['cara_perolehan_akhir'].toString();
    editController.tgl_perolehan.text =
        data['tgl_perolehan_formatted'].toString();
    editController.tahun_perolehan.text = data['tahun_perolehan'].toString();
    editController.perolehan_awal.text =
        data['perolehan_awal_formatted'].toString();
    editController.perolehan_akhir.text =
        data['perolehan_akhir_formatted'].toString();
    editController.atribusi_status.text = data['atribusi_status'].toString();
    editController.atribusi_nibar.text = data['atribusi_nibar'].toString();
    editController.atribusi_kode_barang.text =
        data['atribusi_kode_barang'].toString();
    editController.atribusi_kode_lokasi.text =
        data['atribusi_kode_lokasi'].toString();
    editController.atribusi_no_register.text =
        data['atribusi_no_register'].toString();
    editController.atribusi_nama_barang.text =
        data['atribusi_nama_barang'].toString();
    editController.atribusi_spesifikasi_barang.text =
        data['atribusi_spesifikasi_barang'].toString();
    editController.a_alamat_awal.text = data['a_alamat_awal'].toString();
    editController.a_alamat_akhir.text = data['a_alamat_akhir'].toString();
    editController.alamat_kota.text = data['alamat_kota'].toString();
    editController.alamat_kecamatan.text = data['alamat_kecamatan'].toString();
    editController.alamat_kelurahan.text = data['alamat_kelurahan'].toString();
    editController.alamat_jalan.text = data['alamat_jalan'].toString();
    editController.alamat_no.text = data['alamat_no'].toString();
    editController.alamat_rt.text = data['alamat_rt'].toString();
    editController.alamat_rw.text = data['alamat_rw'].toString();
    editController.alamat_kodepos.text = data['alamat_kodepos'].toString();
    //
    editController.b_merk_awal.text = data['b_merk_awal'].toString();
    editController.b_merk_akhir.text = data['b_merk_akhir'].toString();
    editController.b_cc_awal.text = data['b_cc_awal'].toString();
    editController.b_cc_akhir.text = data['b_cc_akhir'].toString();
    editController.b_nomor_polisi_awal.text =
        data['b_nomor_polisi_awal'].toString();
    editController.b_nomor_polisi_akhir.text =
        data['b_nomor_polisi_akhir'].toString();
    editController.b_nomor_rangka_awal.text =
        data['b_nomor_rangka_awal'].toString();
    editController.b_nomor_rangka_akhir.text =
        data['b_nomor_rangka_akhir'].toString();
    editController.b_nomor_mesin_awal.text =
        data['b_nomor_mesin_awal'].toString();
    editController.b_nomor_mesin_akhir.text =
        data['b_nomor_mesin_akhir'].toString();
    editController.b_nomor_bpkb_awal.text =
        data['b_nomor_bpkb_awal'].toString();
    editController.b_nomor_bpkb_akhir.text =
        data['b_nomor_bpkb_akhir'].toString();
    editController.b_bahan_awal.text = data['b_bahan_awal'].toString();
    editController.b_bahan_akhir.text = data['b_bahan_akhir'].toString();
    editController.b_nomor_pabrik_awal.text =
        data['b_nomor_pabrik_awal'].toString();
    editController.b_nomor_pabrik_akhir.text =
        data['b_nomor_pabrik_akhir'].toString();
    editController.kartu_inv_awal.text = data['kartu_inv_awal'].toString();
    editController.kartu_inv_akhir.text = data['kartu_inv_akhir'].toString();
    //
    editController.keberadaan_barang_status.text =
        data['keberadaan_barang_status'].toString();
    editController.kondisi_awal.text = data['kondisi_awal'].toString();
    editController.kondisi_akhir.text = data['kondisi_akhir'].toString();
    editController.asal_usul_awal.text = data['asal_usul_awal'].toString();
    editController.asal_usul_akhir.text = data['asal_usul_akhir'].toString();
    editController.penggunaan_status.text =
        data['penggunaan_status'].toString();
    editController.penggunaan_awal.text = data['penggunaan_awal'].toString();
    editController.penggunaan_pemda_status.text =
        data['penggunaan_pemda_status'].toString();
    editController.penggunaan_pemda_akhir.text =
        data['penggunaan_pemda_akhir'].toString();
    editController.penggunaan_pempus_status.text =
        data['penggunaan_pempus_status'].toString();
    editController.penggunaan_pempus_yt.text =
        data['penggunaan_pempus_yt'].toString();
    editController.penggunaan_pempus_y_nm.text =
        data['penggunaan_pempus_y_nm'].toString();
    editController.penggunaan_pempus_y_doc.text =
        data['penggunaan_pempus_y_doc'].toString();
    editController.penggunaan_pempus_t_nm.text =
        data['penggunaan_pempus_t_nm'].toString();
    editController.penggunaan_pdl_status.text =
        data['penggunaan_pdl_status'].toString();
    editController.penggunaan_pdl_yt.text =
        data['penggunaan_pdl_yt'].toString();
    editController.penggunaan_pdl_y_nm.text =
        data['penggunaan_pdl_y_nm'].toString();
    editController.penggunaan_pdl_y_doc.text =
        data['penggunaan_pdl_y_doc'].toString();
    editController.penggunaan_pdl_t_nm.text =
        data['penggunaan_pdl_t_nm'].toString();
    editController.penggunaan_pl_status.text =
        data['penggunaan_pl_status'].toString();
    editController.penggunaan_pl_yt.text = data['penggunaan_pl_yt'].toString();
    editController.penggunaan_pl_y_nm.text =
        data['penggunaan_pl_y_nm'].toString();
    editController.penggunaan_pl_y_doc.text =
        data['penggunaan_pl_y_doc'].toString();
    editController.penggunaan_pl_t_nm.text =
        data['penggunaan_pl_t_nm'].toString();
    editController.tercatat_ganda.text = data['tercatat_ganda'].toString();
    editController.tercatat_ganda_nibar.text =
        data['tercatat_ganda_nibar'].toString();
    editController.tercatat_ganda_no_register.text =
        data['tercatat_ganda_no_register'].toString();
    editController.tercatat_ganda_kode_barang.text =
        data['tercatat_ganda_kode_barang'].toString();
    editController.tercatat_ganda_nama_barang.text =
        data['tercatat_ganda_nama_barang'].toString();
    editController.tercatat_ganda_spesifikasi_barang.text =
        data['tercatat_ganda_spesifikasi_barang'].toString();
    editController.tercatat_ganda_luas.text =
        data['tercatat_ganda_luas'].toString();
    editController.tercatat_ganda_satuan.text =
        data['tercatat_ganda_satuan'].toString();
    editController.tercatat_ganda_perolehan.text =
        data['tercatat_ganda_perolehan'].toString();
    editController.tercatat_ganda_tanggal_perolehan.text =
        data['tercatat_ganda_tanggal_perolehan'].toString();
    editController.tercatat_ganda_kuasa_pengguna.text =
        data['tercatat_ganda_kuasa_pengguna'].toString();
    editController.pemilik_id.text = data['pemilik_id'].toString();
    editController.lainnya.text = data['lainnya'].toString();
    editController.keterangan.text = data['keterangan'].toString();
    editController.file_nm.text = data['file_nm'].toString();
    editController.petugas.text = data['petugas'].toString();
  }

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

  List<String> keteranganQRBarang = ["Ada", "Tidak"];
  String statusQRBarang = "Tidak";

  List<String> keteranganQRRuangan = ["Ada", "Tidak"];
  String statusQRRuangan = "Tidak";

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
                        controller: editController.tgl_inventaris,
                        keyboardType: TextInputType.none,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        onTap: () async {
                          DateTime initialDateTime = DateFormat('dd-MM-yyyy')
                              .parse(editController.tgl_inventaris.text);
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: initialDateTime,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2030),
                          );
                          if (pickedDate != null) {
                            String formattedDate =
                                DateFormat('dd-MM-yyyy').format(pickedDate);

                            setState(() {
                              editController.tgl_inventaris.text =
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
                        controller: editController.skpd_uraian,
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
                              controller: editController.no_register_awal,
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
                              statusNoRegister = newValue ?? statusNoRegister;
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
                              controller: editController.no_register_akhir,
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
                          value: statusBarang,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusBarang = newValue ?? statusBarang;
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
                          controller: editController.kategori_id_awal,
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
                              setState(() {
                                selectedKategori = newValue ?? selectedKategori;
                              });
                            },
                            dropdownStyleData:
                                DropdownStyleData(maxHeight: 300),
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
                              controller: editController.nama_spesifikasi_awal,
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
                              statusNamaBarang = newValue ?? statusNamaBarang;
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
                              controller: editController.nama_spesifikasi_akhir,
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade400,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: TextFormField(
                        controller: editController.jumlah_awal,
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
                          selectedSatuan = newValue ?? selectedSatuan;
                        });
                      },
                      dropdownStyleData: DropdownStyleData(maxHeight: 300),
                      items: satuanController.satuanList
                          .map<DropdownMenuItem<String>>(
                        (Map<String, dynamic> item) {
                          return DropdownMenuItem<String>(
                            value: item['satuan_kd'].toString(),
                            child: Text(item['satuan_nm'].toString()),
                          );
                        },
                      ).toList(),
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
                              controller: editController.cara_perolehan_awal,
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
                              statusPerolehan = newValue ?? statusPerolehan;
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
                        controller: editController.tgl_perolehan,
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
                        controller: editController.tahun_perolehan,
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
                              controller: editController.perolehan_awal,
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
                              statusNilaiPerolehan =
                                  newValue ?? statusNilaiPerolehan;
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
                              controller: editController.perolehan_akhir,
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
                              statusAlamat = newValue ?? statusAlamat;
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
                              controller: editController.b_merk_awal,
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
                          value: statusMerk,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusMerk = newValue ?? statusMerk;
                            });
                          },
                          items: keteranganMerk.map((String item) {
                            return DropdownMenuItem<String>(
                              value:
                                  keteranganMerk.indexOf(item) == 0 ? "1" : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  statusMerk == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.b_merk_akhir,
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
                              controller: editController.b_cc_awal,
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
                          value: statusCC,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusCC = newValue ?? statusCC;
                            });
                          },
                          items: keteranganCC.map((String item) {
                            return DropdownMenuItem<String>(
                              value:
                                  keteranganCC.indexOf(item) == 0 ? "1" : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  statusCC == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.b_cc_akhir,
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
                              controller: editController.b_nomor_polisi_awal,
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
                          value: statusNoPolisi,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusNoPolisi = newValue ?? statusNoPolisi;
                            });
                          },
                          items: keteranganNoPolisi.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganNoPolisi.indexOf(item) == 0
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
                  statusNoPolisi == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.b_nomor_polisi_akhir,
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
                              controller: editController.b_nomor_rangka_awal,
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
                          value: statusNoRangka,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusNoRangka = newValue ?? statusNoRangka;
                            });
                          },
                          items: keteranganNoRangka.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganNoRangka.indexOf(item) == 0
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
                  statusNoRangka == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.b_nomor_rangka_akhir,
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
                              controller: editController.b_nomor_mesin_awal,
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
                          value: statusNoMesin,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusNoMesin = newValue ?? statusNoMesin;
                            });
                          },
                          items: keteranganNoMesin.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganNoMesin.indexOf(item) == 0
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
                  statusNoMesin == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.b_nomor_mesin_akhir,
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
                              controller: editController.b_nomor_bpkb_awal,
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
                          value: statusNoBPKB,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusNoBPKB = newValue ?? statusNoBPKB;
                            });
                          },
                          items: keteranganNoBPKB.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganNoBPKB.indexOf(item) == 0
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
                  statusNoBPKB == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.b_nomor_bpkb_akhir,
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
              // Bahan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bahan',
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
                              controller: editController.b_bahan_awal,
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
                          value: statusBahan,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusBahan = newValue ?? statusBahan;
                            });
                          },
                          items: keteranganBahan.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganBahan.indexOf(item) == 0
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
                  statusBahan == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.b_bahan_akhir,
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
              //Nomor Pabrik
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nomor Pabrik',
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
                              controller: editController.b_nomor_pabrik_awal,
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
                          value: statusNoPabrik,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusNoPabrik = newValue ?? statusNoPabrik;
                            });
                          },
                          items: keteranganNoPabrik.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganNoPabrik.indexOf(item) == 0
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
                  statusNoPabrik == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.b_nomor_pabrik_akhir,
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
                    'Kartu Invetarisasi Ruangan',
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
                              controller: editController.kartu_inv_awal,
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
                          value: statusKartuRuangan,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusKartuRuangan =
                                  newValue ?? statusKartuRuangan;
                            });
                          },
                          items: keteranganKartuRuangan.map((String item) {
                            return DropdownMenuItem<String>(
                              value: keteranganKartuRuangan.indexOf(item) == 0
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
                  statusKartuRuangan == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.kartu_inv_akhir,
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
                        value: statusQRBarang,
                        onChanged: (String? newValue) {
                          setState(() {
                            statusQRBarang = newValue ?? statusQRBarang;
                          });
                        },
                        items: keteranganQRBarang.map((String item) {
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
                        value: statusQRRuangan,
                        onChanged: (String? newValue) {
                          setState(() {
                            statusQRRuangan = newValue ?? statusQRRuangan;
                          });
                        },
                        items: keteranganQRRuangan.map((String item) {
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
                              controller: editController.kondisi_awal,
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
                              statusKondisi = newValue ?? statusKondisi;
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
                              controller: editController.asal_usul_awal,
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
                              statusAsalUsul = newValue ?? statusAsalUsul;
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
                              controller: editController.asal_usul_akhir,
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
                        controller: editController.penggunaan_awal,
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
