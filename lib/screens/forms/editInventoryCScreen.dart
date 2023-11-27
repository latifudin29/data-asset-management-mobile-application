import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:kib_application/constans/inventoryVariablesC.dart';
import 'package:kib_application/controllers/addressController.dart';
import 'package:kib_application/controllers/appointmentController.dart';
import 'package:kib_application/controllers/categoryController.dart';
import 'package:kib_application/controllers/inventoryCController.dart';
import 'package:kib_application/controllers/unitController.dart';

class EditInventoryCScreen extends StatefulWidget {
  const EditInventoryCScreen({super.key});

  @override
  State<EditInventoryCScreen> createState() => _EditInventoryCScreenState();
}

class _EditInventoryCScreenState extends State<EditInventoryCScreen> {
  final penetapanController = Get.put(AppointmentController());
  final kategoriController  = Get.put(CategoryController());
  final satuanController    = Get.put(UnitController());
  final addressController   = Get.put(AddressController());
  final invC                = Get.put(InventoryVariablesC());
  final editController      = Get.put(InventoryCController());

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    final data         = penetapanController.penetapanListById[0];

    String statusInventaris = data['status_inventaris'].toString();
    editController.kib_id.text = data['kib_id'].toString();

    invC.statusNoRegister     = data['no_register_status']      != "" ? data['no_register_status'].toString() : "1";
    invC.statusBarang         = data['kategori_id_status']      != "" ? data['kategori_id_status'].toString() : "1";
    invC.statusNamaBarang     = data['nama_spesifikasi_status'] != "" ? data['nama_spesifikasi_status'].toString() : "1";
    invC.statusLuasLantai     = "";
    invC.statusPerolehan      = data['cara_perolehan_status']   != "" ? data['cara_perolehan_status'].toString() : "1";
    invC.statusNilaiPerolehan = data['perolehan_status']        != "" ? data['perolehan_status'].toString() : "1";
    invC.statusAlamat         = data['a_alamat_status']         != "" ? data['a_alamat_status'].toString() : "1";
    invC.statusLuasTanah      = "";
    invC.statusKondisi        = data['kondisi_status']          != "" ? data['kondisi_status'].toString() : "1";
    invC.statusAsalUsul       = data['asal_usul_status']        != "" ? data['asal_usul_status'].toString() : "1";


    String caraPerolehan = (statusInventaris == "0") ? data['cara_perolehan'].toString() : data['cara_perolehan_akhir'].toString();
    if (caraPerolehan == "Pembelian") {
      invC.selectedPerolehan = "1";
    } else if (caraPerolehan == "Hibah") {
      invC.selectedPerolehan = "2";
    } else if (caraPerolehan == "Barang & Jasa") {
      invC.selectedPerolehan = "3";
    } else if (caraPerolehan == "Hasil Inventarisasi") {
      invC.selectedPerolehan = "4";
    } else {
      invC.selectedPerolehan = "";
    }    

    editController.tgl_inventaris.text                    = (statusInventaris == "0") ? DateFormat('dd-MM-yyyy').format(now) : data['tgl_inventaris_formatted'].toString();
    editController.skpd.text                              = data['departemen_kd'].toString();
    editController.skpd_uraian.text                       = data['departemen_nm'].toString();
    editController.barang.text                            = data['kategori_kd'].toString() + ' - ' + data['kategori_nm'].toString();
    editController.no_register_awal.text                  = (statusInventaris == "0") ? data['no_register'].toString() : data['no_register_awal'].toString();
    editController.no_register_akhir.text                 = (statusInventaris == "0") ? data['no_register'].toString() : data['no_register_akhir'].toString();
    editController.kategori_id_awal.text                  = (statusInventaris == "0") ? data['kategori_id'].toString() : data['kategori_id_awal'].toString();
    invC.selectedKategori                                 = (statusInventaris == "0") ? data['kategori_id'].toString() : data['kategori_id_akhir'].toString();
    editController.nama_spesifikasi_awal.text             = data['nama_spesifikasi_awal'].toString();
    editController.nama_spesifikasi_akhir.text            = data['nama_spesifikasi_akhir'].toString();
    editController.jumlah_awal.text                       = (statusInventaris == "0") ? data['jumlah_awal'].toString() : data['jumlah_akhir'].toString();
    // 
    editController.c_luas_lantai.text                     = (statusInventaris == "0") ? data['c_luas_lantai'].toString() : data['c_luas_lantai'].toString();
    // 
    invC.selectedSatuan                                   = (statusInventaris == "0") ? (data['satuan_awal'] != "") ? data['satuan_awal'].toString() : "" : (data['satuan_akhir'] != "") ? data['satuan_akhir'].toString() : "";
    editController.cara_perolehan_awal.text               = (statusInventaris == "0") ? data['cara_perolehan'].toString() : data['cara_perolehan_awal'].toString();
    editController.tgl_perolehan.text                     = (statusInventaris == "0") ? data['tgl_perolehan_penetapan'].toString() : data['tgl_perolehan_inventaris'].toString();
    editController.tahun_perolehan.text                   = (statusInventaris == "0") ? data['th_beli'].toString() : data['tahun_perolehan'].toString();
    editController.perolehan_awal.text                    = (statusInventaris == "0") ? data['perolehan_formatted'].toString() : data['perolehan_awal_formatted'].toString();
    editController.perolehan_akhir.text                   = (statusInventaris == "0") ? data['perolehan_formatted'].toString() : data['perolehan_akhir_formatted'].toString();
    editController.atribusi_status.text                   = data['atribusi_status'].toString();
    editController.atribusi_nibar.text                    = data['atribusi_nibar'].toString();
    editController.atribusi_kode_barang.text              = data['atribusi_kode_barang'].toString();
    editController.atribusi_kode_lokasi.text              = data['atribusi_kode_lokasi'].toString();
    editController.atribusi_no_register.text              = data['atribusi_no_register'].toString();
    editController.atribusi_nama_barang.text              = data['atribusi_nama_barang'].toString();
    editController.atribusi_spesifikasi_barang.text       = data['atribusi_spesifikasi_barang'].toString();
    editController.a_alamat_awal.text                     = (statusInventaris == "0") ? data['a_alamat'].toString() : data['a_alamat_awal'].toString();
    editController.alamat_kota.text                       = data['alamat_kota'] != "" ? data['alamat_kota'].toString() : "KOTA BOGOR";
    invC.selectedKecamatan                                = data['alamat_kecamatan'].toString();
    invC.selectedKelurahan                                = data['alamat_kelurahan'].toString();
    editController.alamat_jalan.text                      = data['alamat_jalan'].toString();
    editController.alamat_no.text                         = data['alamat_no'].toString();
    editController.alamat_rt.text                         = data['alamat_rt'].toString();
    editController.alamat_rw.text                         = data['alamat_rw'].toString();
    editController.alamat_kodepos.text                    = data['alamat_kodepos'].toString();
    // 
    // 
    editController.keberadaan_barang_status.text          = data['keberadaan_barang_status'].toString();
    editController.kondisi_awal.text                      = (statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_awal'].toString();
    invC.selectedKondisi                                  = (statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_akhir'].toString();
    editController.asal_usul_awal.text                    = (statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_awal'].toString();
    editController.asal_usul_akhir.text                   = (statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_akhir'].toString();
    editController.penggunaan_status.text                 = data['penggunaan_status'].toString();
    editController.penggunaan_awal.text                   = (statusInventaris == "0") ? data['a_penggunaan'].toString() : data['penggunaan_awal'].toString();
    editController.penggunaan_pemda_status.text           = data['penggunaan_pemda_status'].toString();
    editController.penggunaan_pemda_akhir.text            = data['penggunaan_pemda_akhir'].toString();
    editController.penggunaan_pempus_status.text          = data['penggunaan_pempus_status'].toString();
    editController.penggunaan_pempus_yt.text              = data['penggunaan_pempus_yt'].toString();
    editController.penggunaan_pempus_y_nm.text            = data['penggunaan_pempus_y_nm'].toString();
    editController.penggunaan_pempus_y_doc.text           = data['penggunaan_pempus_y_doc'].toString();
    editController.penggunaan_pempus_t_nm.text            = data['penggunaan_pempus_t_nm'].toString();
    editController.penggunaan_pdl_status.text             = data['penggunaan_pdl_status'].toString();
    editController.penggunaan_pdl_yt.text                 = data['penggunaan_pdl_yt'].toString();
    editController.penggunaan_pdl_y_nm.text               = data['penggunaan_pdl_y_nm'].toString();
    editController.penggunaan_pdl_y_doc.text              = data['penggunaan_pdl_y_doc'].toString();
    editController.penggunaan_pdl_t_nm.text               = data['penggunaan_pdl_t_nm'].toString();
    editController.penggunaan_pl_status.text              = data['penggunaan_pl_status'].toString();
    editController.penggunaan_pl_yt.text                  = data['penggunaan_pl_yt'].toString();
    editController.penggunaan_pl_y_nm.text                = data['penggunaan_pl_y_nm'].toString();
    editController.penggunaan_pl_y_doc.text               = data['penggunaan_pl_y_doc'].toString();
    editController.penggunaan_pl_t_nm.text                = data['penggunaan_pl_t_nm'].toString();
    editController.tercatat_ganda.text                    = data['tercatat_ganda'].toString();
    editController.tercatat_ganda_nibar.text              = data['tercatat_ganda_nibar'].toString();
    editController.tercatat_ganda_no_register.text        = data['tercatat_ganda_no_register'].toString();
    editController.tercatat_ganda_kode_barang.text        = data['tercatat_ganda_kode_barang'].toString();
    editController.tercatat_ganda_nama_barang.text        = data['tercatat_ganda_nama_barang'].toString();
    editController.tercatat_ganda_spesifikasi_barang.text = data['tercatat_ganda_spesifikasi_barang'].toString();
    editController.tercatat_ganda_luas.text               = data['tercatat_ganda_luas'].toString();
    editController.tercatat_ganda_satuan.text             = data['tercatat_ganda_satuan'].toString();
    editController.tercatat_ganda_perolehan.text          = data['tercatat_ganda_perolehan'].toString();
    editController.tercatat_ganda_tanggal_perolehan.text  = data['tercatat_ganda_tanggal_perolehan'].toString();
    editController.tercatat_ganda_kuasa_pengguna.text     = data['tercatat_ganda_kuasa_pengguna'].toString();
    editController.pemilik_id.text                        = data['pemilik_id'].toString();
    editController.lat.text                               = (statusInventaris == "0") ? data['lat_penetapan'].toString() : data['lat_inventaris'].toString();
    editController.long.text                              = (statusInventaris == "0") ? data['long_penetapan'].toString() : data['long_inventaris'].toString();
    editController.lainnya.text                           = data['lainnya'].toString();
    editController.keterangan.text                        = (statusInventaris == "0") ? data['keterangan_penetapan'].toString() : data['keterangan_inventaris'].toString();
    editController.file_nm.text                           = data['file_nm'].toString();
    editController.petugas.text                           = data['petugas'].toString();
  }

  Map<String, String> dropdownPerolehan = {
    "1": "Pembelian",
    "2": "Hibah",
    "3": "Barang & Jasa",
    "4": "Hasil Inventarisasi",
  };

  List<String> dropdownKondisi = ["B", "RR", "RB"];

  // BAWAH BELUM
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
      body: Obx(
        () => Padding(
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
                            value: invC.statusNoRegister,
                            onChanged: (String? newValue) {
                              setState(() {
                                invC.statusNoRegister =
                                    newValue ?? invC.statusNoRegister;
                              });
                            },
                            items: invC.keteranganNoRegister.map((String item) {
                              return DropdownMenuItem<String>(
                                value:
                                    invC.keteranganNoRegister.indexOf(item) == 0
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
                    invC.statusNoRegister == "2"
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
                            value: invC.statusBarang,
                            onChanged: (String? newValue) {
                              setState(() {
                                invC.statusBarang =
                                    newValue ?? invC.statusBarang;
                              });
                            },
                            items: invC.keteranganBarang.map((String item) {
                              return DropdownMenuItem<String>(
                                value: invC.keteranganBarang.indexOf(item) == 0
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
                    invC.statusBarang == "2"
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
                              value: invC.selectedKategori,
                              onChanged: (String? newValue) {
                                setState(() {
                                  invC.selectedKategori =
                                      newValue ?? invC.selectedKategori;
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
                                controller:
                                    editController.nama_spesifikasi_awal,
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
                            value: invC.statusNamaBarang,
                            onChanged: (String? newValue) {
                              setState(() {
                                invC.statusNamaBarang =
                                    newValue ?? invC.statusNamaBarang;
                              });
                            },
                            items: invC.keteranganNamaBarang.map((String item) {
                              return DropdownMenuItem<String>(
                                value:
                                    invC.keteranganNamaBarang.indexOf(item) == 0
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
                    invC.statusNamaBarang == "2"
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextFormField(
                                controller:
                                    editController.nama_spesifikasi_akhir,
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
                // Luas Lantai
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Luas Lantai',
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
                                controller: editController.c_luas_lantai,
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
                            value: invC.statusLuasLantai,
                            onChanged: (String? newValue) {
                              setState(() {
                                invC.statusLuasLantai = newValue ?? invC.statusLuasLantai;
                              });
                            },
                            items: invC.keteranganLuasLantai.map((String item) {
                              return DropdownMenuItem<String>(
                                value: invC.keteranganLuasLantai.indexOf(item) == 0
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
                    invC.statusLuasLantai == "2"
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextFormField(
                                controller: editController.c_luas_lantai,
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
                        value: invC.selectedSatuan != ""
                            ? invC.selectedSatuan
                            : "",
                        onChanged: (String? newValue) {
                          setState(() {
                            invC.selectedSatuan =
                                newValue ?? invC.selectedSatuan;
                          });
                        },
                        dropdownStyleData: DropdownStyleData(maxHeight: 300),
                        items: [
                          DropdownMenuItem<String>(
                            value: "",
                            child: Text("Pilih satuan"),
                          ),
                          ...satuanController.satuanList
                              .map<DropdownMenuItem<String>>(
                            (Map<String, dynamic> item) {
                              return DropdownMenuItem<String>(
                                value: item['satuan_kd'].toString(),
                                child: Text(item['satuan_nm'].toString()),
                              );
                            },
                          ),
                        ],
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
                            value: invC.statusPerolehan,
                            onChanged: (String? newValue) {
                              setState(() {
                                invC.statusPerolehan =
                                    newValue ?? invC.statusPerolehan;
                              });
                            },
                            items: invC.keteranganPerolehan.map((String item) {
                              return DropdownMenuItem<String>(
                                value:
                                    invC.keteranganPerolehan.indexOf(item) == 0
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
                    invC.statusPerolehan == "2"
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
                              value: dropdownPerolehan.keys
                                      .contains(invC.selectedPerolehan)
                                  ? invC.selectedPerolehan
                                  : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  invC.selectedPerolehan =
                                      newValue ?? invC.selectedPerolehan;
                                });
                                print(invC.selectedPerolehan);
                              },
                              items: dropdownPerolehan.keys.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: item,
                                  child: Text(dropdownPerolehan[item]!),
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
                            value: invC.statusNilaiPerolehan,
                            onChanged: (String? newValue) {
                              setState(() {
                                invC.statusNilaiPerolehan =
                                    newValue ?? invC.statusNilaiPerolehan;
                              });
                            },
                            items: invC.keteranganNilaiPerolehan
                                .map((String item) {
                              return DropdownMenuItem<String>(
                                value: invC.keteranganNilaiPerolehan
                                            .indexOf(item) ==
                                        0
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
                    invC.statusNilaiPerolehan == "2"
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
                                title:
                                    Text("Tidak diketahui data awal/induknya"),
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
                            value: invC.statusAlamat,
                            onChanged: (String? newValue) {
                              setState(() {
                                invC.statusAlamat =
                                    newValue ?? invC.statusAlamat;
                              });
                            },
                            items: invC.keteranganAlamat.map((String item) {
                              return DropdownMenuItem<String>(
                                value: invC.keteranganAlamat.indexOf(item) == 0
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
                    invC.statusAlamat == "2"
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
                                    controller: editController.alamat_kota,
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
                                  value: invC.selectedKecamatan != "" ? invC.selectedKecamatan : "",
                                  onChanged: (String? newValue) async {
                                    setState(() {
                                      invC.selectedKecamatan = newValue ?? invC.selectedKecamatan;
                                    });

                                    final filteredList = addressController.kecamatanList
                                        .where((kecamatan) => kecamatan['kecamatan_kd'].toString() == newValue);

                                    if (filteredList.isNotEmpty) {
                                      final Map<String, dynamic> selectedKecamatan = filteredList.first;
                                      int idKecamatan = selectedKecamatan['id'];

                                      await addressController.getKelurahan(idKecamatan.toString());
                                      setState(() {
                                        invC.selectedKelurahan = (idKecamatan.toString() == "1") ? "000" : "001";
                                      });
                                    }
                                  },
                                  dropdownStyleData: DropdownStyleData(maxHeight: 300),
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: "",
                                      child: Text("Pilih kecamatan"),
                                    ),
                                    ...addressController.kecamatanList
                                      .map<DropdownMenuItem<String>>(
                                        (Map<String, dynamic> item) {
                                          return DropdownMenuItem<String>(
                                            value: item['kecamatan_kd'].toString(),
                                            child: Text(item['kecamatan_kd'].toString() + ' - ' + item['kecamatan_nm'].toString()),
                                          );
                                        },
                                      )
                                  ],
                                ),
                              ),
                              SizedBox(height: 15),
                              Text(
                                'Kelurahan',
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
                                  value: invC.selectedKelurahan != "" ? invC.selectedKelurahan : "",
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      invC.selectedKelurahan = newValue ?? invC.selectedKelurahan;
                                    });
                                  },
                                  dropdownStyleData: DropdownStyleData(maxHeight: 300),
                                  items: [
                                    DropdownMenuItem<String>(
                                      value: "",
                                      child: Text("Pilih kelurahan"),
                                    ),
                                    ...addressController.kelurahanList
                                      .map<DropdownMenuItem<String>>(
                                        (Map<String, dynamic> item) {
                                          return DropdownMenuItem<String>(
                                            value: item['kelurahan_kd'].toString(),
                                            child: Text(item['kelurahan_kd'].toString() + ' - ' + item['kelurahan_nm'].toString()),
                                          );
                                        },
                                      )
                                  ],
                                  
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
                                    controller: editController.alamat_jalan,
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
                                    controller: editController.alamat_no,
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
                                    controller: editController.alamat_rt,
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
                                    controller: editController.alamat_rw,
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
                                    controller: editController.alamat_kodepos,
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
                            value: invC.statusKondisi,
                            onChanged: (String? newValue) {
                              setState(() {
                                invC.statusKondisi =
                                    newValue ?? invC.statusKondisi;
                              });
                            },
                            items: invC.keteranganKondisi.map((String item) {
                              return DropdownMenuItem<String>(
                                value: invC.keteranganKondisi.indexOf(item) == 0
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
                    invC.statusKondisi == "2"
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
                              value: invC.selectedKondisi,
                              onChanged: (String? newValue) {
                                setState(() {
                                  invC.selectedKondisi = newValue ?? invC.selectedKondisi;
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
                            value: invC.statusAsalUsul,
                            onChanged: (String? newValue) {
                              setState(() {
                                invC.statusAsalUsul =
                                    newValue ?? invC.statusAsalUsul;
                              });
                            },
                            items: invC.keteranganAsalUsul.map((String item) {
                              return DropdownMenuItem<String>(
                                value:
                                    invC.keteranganAsalUsul.indexOf(item) == 0
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
                    invC.statusAsalUsul == "2"
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
                        items:
                            keteranganPenggunaanDaerahPusat.map((String item) {
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
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                        items:
                            keteranganPenggunaanDaerahLain.map((String item) {
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
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                                          border:
                                              Border.all(color: Colors.grey),
                                          borderRadius:
                                              BorderRadius.circular(12),
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
                            controller: editController.lat,
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
                            controller: editController.long,
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
                          controller: editController.keterangan,
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
                      List<String> data = [
                        editController.tgl_inventaris.text,
                        editController.no_register_awal.text,
                        editController.no_register_akhir.text,
                        invC.statusNoRegister,
                        editController.kategori_id_awal.text,
                        invC.selectedKategori,
                        invC.statusBarang,
                        editController.nama_spesifikasi_awal.text,
                        editController.nama_spesifikasi_akhir.text,
                        invC.statusNamaBarang,
                        editController.jumlah_awal.text,
                        invC.selectedSatuan,
                        editController.cara_perolehan_awal.text,
                        invC.selectedPerolehan,
                        invC.statusPerolehan,
                        editController.tgl_perolehan.text,
                        editController.tahun_perolehan.text,
                        editController.perolehan_awal.text,
                        editController.perolehan_akhir.text,
                        invC.statusNilaiPerolehan
                      ];
                      print(editController.kib_id.text);
                      print(data);
                      editController.editInsertInventarisC(
                          editController.kib_id.text, data);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
