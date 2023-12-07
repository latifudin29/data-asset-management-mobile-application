import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:kib_application/constans/inventoryVariablesA.dart';
import 'package:kib_application/controllers/addressController.dart';
import 'package:kib_application/controllers/appointmentController.dart';
import 'package:kib_application/controllers/categoryController.dart';
import 'package:kib_application/controllers/getLocationController.dart';
import 'package:kib_application/controllers/inventoryAController.dart';
import 'package:kib_application/controllers/unitController.dart';
import 'package:kib_application/widgets/formPetugas.dart';

class EditInventoryAScreen extends StatefulWidget {
  const EditInventoryAScreen({super.key});

  @override
  State<EditInventoryAScreen> createState() => _EditInventoryAScreenState();
}

class _EditInventoryAScreenState extends State<EditInventoryAScreen> {
  final penetapanController = Get.put(AppointmentController());
  final editController      = Get.put(InventoryAController());
  final kategoriController  = Get.put(CategoryController());
  final satuanController    = Get.put(UnitController());
  final addressController   = Get.put(AddressController());
  final locationController  = Get.put(LocationController());
  final invA                = Get.put(InventoryVariablesA());

  List<dynamic> _petugasList = [''];

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    final data         = penetapanController.penetapanListById[0];
    final filteredList = addressController.kecamatanList
      .where((kecamatan) => kecamatan['kecamatan_kd'].toString() == data['alamat_kecamatan'].toString());

    invA.statusInventaris                                 = data['status_inventaris'].toString();
    editController.kib_id.text                            = data['kib_id'].toString();
    editController.penetapan_id.text                      = data['penetapan_id'].toString();
    editController.departemen_id.text                     = data['departemen_id'].toString();

    editController.tgl_inventaris.text                    = (invA.statusInventaris == "0") ? DateFormat('dd-MM-yyyy').format(now) : data['tgl_inventaris_formatted'].toString();
    editController.skpd.text                              = data['departemen_kd'].toString();
    editController.skpd_uraian.text                       = data['departemen_nm'].toString();
    editController.no_register_awal.text                  = (invA.statusInventaris == "0") ? data['no_register'].toString() : data['no_register_awal'].toString();
    editController.no_register_akhir.text                 = (invA.statusInventaris == "0") ? data['no_register'].toString() : data['no_register_akhir'].toString();
    invA.statusNoRegister                                 = data['no_register_status']      != "" ? data['no_register_status'].toString() : "1";
    editController.barang.text                            = data['kategori_kd'].toString() + ' - ' + data['kategori_nm'].toString();
    editController.kategori_id_awal.text                  = (invA.statusInventaris == "0") ? data['kategori_id'].toString() : data['kategori_id_awal'].toString();
    invA.selectedKategori                                 = (invA.statusInventaris == "0") ? data['kategori_id'].toString() : data['kategori_id_akhir'].toString();
    invA.statusBarang                                     = data['kategori_id_status']      != "" ? data['kategori_id_status'].toString() : "1";
    editController.nama_spesifikasi_awal.text             = (invA.statusInventaris == "0") ? "" : data['nama_spesifikasi_awal'].toString();
    editController.nama_spesifikasi_akhir.text            = (invA.statusInventaris == "0") ? "" : data['nama_spesifikasi_akhir'].toString();
    invA.statusNamaBarang                                 = data['nama_spesifikasi_status'] != "" ? data['nama_spesifikasi_status'].toString() : "1";
    editController.jumlah_awal.text                       = (invA.statusInventaris == "0") ? data['jumlah'].toString() : data['jumlah_awal'].toString();
    editController.jumlah_akhir.text                      = (invA.statusInventaris == "0") ? data['jumlah'].toString() : data['jumlah_akhir'].toString();
    invA.statusJumlah                                     = data['jumlah_status']           != "" ? data['jumlah_status'].toString() : "1";
    editController.a_luas_m2_awal.text                    = (invA.statusInventaris == "0") ? data['a_luas_m2'].toString() : data['a_luas_m2_awal'].toString();
    editController.a_luas_m2_akhir.text                   = (invA.statusInventaris == "0") ? data['a_luas_m2'].toString() : data['a_luas_m2_akhir'].toString();
    invA.statusLuas                                       = data['a_luas_m2_status']        != "" ? data['a_luas_m2_status'].toString() : "1";
    invA.selectedSatuan                                   = (invA.statusInventaris == "0") ? (data['satuan_awal'] != "") ? data['satuan_awal'].toString() : "" : (data['satuan_akhir'] != "") ? data['satuan_akhir'].toString() : "";
    editController.cara_perolehan_awal.text               = (invA.statusInventaris == "0") ? data['cara_perolehan'].toString() : data['cara_perolehan_awal'].toString();
    invA.statusPerolehan                                  = data['cara_perolehan_status']   != "" ? data['cara_perolehan_status'].toString() : "1";

    String caraPerolehan = (invA.statusInventaris == "0") ? data['cara_perolehan'].toString() : data['cara_perolehan_akhir'].toString();
    if (caraPerolehan == "Pembelian" || caraPerolehan == "1" || caraPerolehan == "") {
      invA.selectedPerolehan = "1";
    } else if (caraPerolehan == "Hibah" || caraPerolehan == "2") {
      invA.selectedPerolehan = "2";
    } else if (caraPerolehan == "Barang & Jasa" || caraPerolehan == "3") {
      invA.selectedPerolehan = "3";
    } else if (caraPerolehan == "Hasil Inventarisasi" || caraPerolehan == "4") {
      invA.selectedPerolehan = "4";
    }
    
    editController.tgl_perolehan.text                     = (invA.statusInventaris == "0") ? data['tgl_perolehan_penetapan'].toString() : data['tgl_perolehan_inventaris'].toString();
    editController.tahun_perolehan.text                   = (invA.statusInventaris == "0") ? data['th_beli'].toString() : data['tahun_perolehan'].toString();
    editController.perolehan_awal.text                    = (invA.statusInventaris == "0") ? data['perolehan_formatted'].toString() : data['perolehan_awal_formatted'].toString();
    editController.perolehan_akhir.text                   = (invA.statusInventaris == "0") ? data['perolehan_formatted'].toString() : data['perolehan_akhir_formatted'].toString();
    invA.statusNilaiPerolehan                             = data['perolehan_status'] != "" ? data['perolehan_status'].toString() : "1";
    invA.statusAtribusi                                   = data['atribusi_biaya']   != "" ? data['atribusi_biaya'].toString() : "0";
    invA.chooseAtribusi                                   = data['atribusi_status']  != "" ? data['atribusi_status'].toString() : "0";
    editController.atribusi_nibar.text                    = (invA.statusInventaris == "0") ? "" : data['atribusi_nibar'].toString();
    editController.atribusi_kode_barang.text              = (invA.statusInventaris == "0") ? "" : data['atribusi_kode_barang'].toString();
    editController.atribusi_kode_lokasi.text              = (invA.statusInventaris == "0") ? "" : data['atribusi_kode_lokasi'].toString();
    editController.atribusi_no_register.text              = (invA.statusInventaris == "0") ? "" : data['atribusi_no_register'].toString();
    editController.atribusi_nama_barang.text              = (invA.statusInventaris == "0") ? "" : data['atribusi_nama_barang'].toString();
    editController.atribusi_spesifikasi_barang.text       = (invA.statusInventaris == "0") ? "" : data['atribusi_spesifikasi_barang'].toString();
    editController.a_alamat_awal.text                     = (invA.statusInventaris == "0") ? data['a_alamat'].toString() : data['a_alamat_awal'].toString();
    invA.statusAlamat                                     = data['a_alamat_status']  != "" ? data['a_alamat_status'].toString() : "1";
    editController.alamat_kota.text                       = data['alamat_kota']      != "" ? data['alamat_kota'].toString() : "KOTA BOGOR";
    invA.selectedKecamatan                                = data['alamat_kecamatan'].toString();
    
    if (filteredList.isNotEmpty) {
      final Map<String, dynamic> selectedKecamatan = filteredList.first;
      int idKecamatan = selectedKecamatan['id'];
      invA.selectedKelurahan = (idKecamatan.toString() == "1") ? "000" : data['alamat_kelurahan'].toString();
    }

    editController.alamat_jalan.text                      = data['alamat_jalan'].toString();
    editController.alamat_no.text                         = data['alamat_no'].toString();
    editController.alamat_rt.text                         = data['alamat_rt'].toString();
    editController.alamat_rw.text                         = data['alamat_rw'].toString();
    editController.alamat_kodepos.text                    = data['alamat_kodepos'].toString();
    editController.a_hak_tanah_awal.text                  = (invA.statusInventaris == "0") ? data['a_hak_tanah'].toString() : data['a_hak_tanah_awal'].toString();
    editController.a_hak_tanah_akhir.text                 = (invA.statusInventaris == "0") ? data['a_hak_tanah'].toString() : data['a_hak_tanah_akhir'].toString();
    invA.statusHakTanah                                   = data['a_hak_tanah_status']          != "" ? data['a_hak_tanah_status'].toString() : "1";
    editController.a_sertifikat_nomor_awal.text           = (invA.statusInventaris == "0") ? data['a_sertifikat_nomor'].toString() : data['a_sertifikat_nomor_awal'].toString();
    editController.a_sertifikat_nomor_akhir.text          = (invA.statusInventaris == "0") ? data['a_sertifikat_nomor'].toString() : data['a_sertifikat_nomor_akhir'].toString();
    invA.statusNoSertifikat                               = data['a_sertifikat_nomor_status']   != "" ? data['a_sertifikat_nomor_status'].toString() : "1";
    editController.a_sertifikat_tanggal_awal.text         = (invA.statusInventaris == "0") ? data['a_sertifikat_tanggal_formatted'].toString() : data['a_sertifikat_tanggal_awal_formatted'].toString();
    editController.a_sertifikat_tanggal_akhir.text        = (invA.statusInventaris == "0") ? data['a_sertifikat_tanggal_formatted'].toString() : data['a_sertifikat_tanggal_akhir_formatted'].toString();
    invA.statusTglSertifikat                              = data['a_sertifikat_tanggal_status'] != "" ? data['a_sertifikat_tanggal_status'].toString() : "1";
    invA.statusKeberadaanBarang                           = data['keberadaan_barang_status']    != "" ? data['keberadaan_barang_status'].toString() : "1";
    editController.kondisi_awal.text                      = (invA.statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_awal'].toString();
    invA.selectedKondisi                                  = (invA.statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_akhir'].toString();
    invA.statusKondisi                                    = data['kondisi_status']              != "" ? data['kondisi_status'].toString() : "1";
    editController.asal_usul_awal.text                    = (invA.statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_awal'].toString();
    editController.asal_usul_akhir.text                   = (invA.statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_akhir'].toString();
    invA.statusAsalUsul                                   = data['asal_usul_status']            != "" ? data['asal_usul_status'].toString() : "1";
    invA.statusPenggunaanStatus                           = data['penggunaan_status']           != "" ? data['penggunaan_status'].toString() : "1";
    editController.penggunaan_awal.text                   = (invA.statusInventaris == "0") ? data['a_penggunaan'].toString() : data['penggunaan_awal'].toString();
    invA.choosePemerintahDaerah                           = (invA.statusInventaris == "0") ? "1" : data['penggunaan_pemda_status'].toString();
    editController.penggunaan_pemda_akhir.text            = data['penggunaan_pemda_akhir'].toString();
    invA.choosePemerintahPusat                            = data['penggunaan_pempus_status'].toString();
    invA.statusPempus                                     = data['penggunaan_pempus_yt']        != "" ? data['penggunaan_pempus_yt'].toString() : "3";
    editController.penggunaan_pempus_y_nm.text            = data['penggunaan_pempus_y_nm'].toString();
    editController.penggunaan_pempus_y_doc.text           = data['penggunaan_pempus_y_doc'].toString();
    editController.penggunaan_pempus_t_nm.text            = data['penggunaan_pempus_t_nm'].toString();
    invA.choosePemerintahDaerahLain                       = data['penggunaan_pdl_status'].toString();
    invA.statusPdl                                        = data['penggunaan_pdl_yt']           != "" ? data['penggunaan_pdl_yt'].toString() : "3";
    editController.penggunaan_pdl_y_nm.text               = data['penggunaan_pdl_y_nm'].toString();
    editController.penggunaan_pdl_y_doc.text              = data['penggunaan_pdl_y_doc'].toString();
    editController.penggunaan_pdl_t_nm.text               = data['penggunaan_pdl_t_nm'].toString();
    invA.choosePihakLain                                  = data['penggunaan_pl_status'].toString();
    invA.statusPl                                         = data['penggunaan_pl_yt']            != "" ? data['penggunaan_pl_yt'].toString() : "3";
    editController.penggunaan_pl_y_nm.text                = data['penggunaan_pl_y_nm'].toString();
    editController.penggunaan_pl_y_doc.text               = data['penggunaan_pl_y_doc'].toString();
    editController.penggunaan_pl_t_nm.text                = data['penggunaan_pl_t_nm'].toString();
    invA.statusGanda                                      = data['tercatat_ganda']              != "" ? data['tercatat_ganda'].toString() : "2";
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
    invA.statusAtasNama                                   = data['pemilik_id']                  != "" ? data['pemilik_id'].toString() : "1";
    editController.lat.text                               = (invA.statusInventaris == "0") ? data['lat_penetapan'].toString() : data['lat_inventaris'].toString();
    editController.long.text                              = (invA.statusInventaris == "0") ? data['long_penetapan'].toString() : data['long_inventaris'].toString();
    editController.lainnya.text                           = data['lainnya'].toString();
    editController.keterangan.text                        = (invA.statusInventaris == "0") ? data['keterangan_penetapan'].toString() : data['keterangan_inventaris'].toString();
    editController.file_nm.text                           = (invA.statusInventaris == "0") ? data['file_penetapan'].toString() : data['file_inventaris'].toString();
    _petugasList                                          = data['petugas']                     != null && data['petugas'].isNotEmpty ? List<String>.from(data['petugas']) : [""];
  
    ever(locationController.latitude, (_) {
      editController.lat.text = locationController.latitude.value;
    });

    ever(locationController.longitude, (_) {
      editController.long.text = locationController.longitude.value;
    });
  }

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
                              String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
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
                            value: invA.statusNoRegister,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusNoRegister =
                                    newValue ?? invA.statusNoRegister;
                              });
                            },
                            items: invA.keteranganNoRegister.map((String item) {
                              return DropdownMenuItem<String>(
                                value:
                                    invA.keteranganNoRegister.indexOf(item) == 0
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
                    invA.statusNoRegister == "2"
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
                            value: invA.statusBarang,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusBarang =
                                    newValue ?? invA.statusBarang;
                              });
                            },
                            items: invA.keteranganBarang.map((String item) {
                              return DropdownMenuItem<String>(
                                value: invA.keteranganBarang.indexOf(item) == 0
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
                    invA.statusBarang == "2"
                        ? DropdownSearch<String>(
                            popupProps: PopupProps.menu(
                              showSelectedItems: true,
                              showSearchBox: true,
                            ),
                            items: kategoriController.kategoriList
                              .map<String>((Map<String, dynamic> item) {
                                return item['kode'] + ' - ' + item['nama'];
                              })
                              .toList(),
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            onChanged: (String? newValue) {
                              if (newValue != null) {
                                List<String> values = newValue.split(' - ');
                                String kode = values[0];
                                String nama = values[1];
                                String id = kategoriController.kategoriList
                                    .firstWhere((item) => item['kode'] == kode && item['nama'] == nama)['id']
                                    .toString();
                                setState(() {
                                  invA.selectedKategori = id;
                                  print(invA.selectedKategori);
                                });
                              }
                            },
                            selectedItem: invA.selectedKategori != ""
                              ? kategoriController.kategoriList
                                  .where((item) => item['id'].toString() == invA.selectedKategori)
                                  .map((item) => item['kode'] + ' - ' + item['nama'])
                                  .first
                              : kategoriController.kategoriList.isNotEmpty
                                  ? kategoriController.kategoriList[0]['kode'] +
                                      ' - ' +
                                      kategoriController.kategoriList[0]['nama']
                                  : "Pilih kategori",
                            dropdownBuilder: (context, selectedItem) {
                              return Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: Text(selectedItem.toString(), style: TextStyle(fontSize: 16)),
                              );
                            },
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
                            value: invA.statusNamaBarang,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusNamaBarang =
                                    newValue ?? invA.statusNamaBarang;
                              });
                            },
                            items: invA.keteranganNamaBarang.map((String item) {
                              return DropdownMenuItem<String>(
                                value:
                                    invA.keteranganNamaBarang.indexOf(item) == 0
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
                    invA.statusNamaBarang == "2"
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
                                controller: editController.jumlah_awal,
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
                            value: invA.statusJumlah,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusJumlah =
                                    newValue ?? invA.statusJumlah;
                              });
                            },
                            items: invA.keteranganJumlah.map((String item) {
                              return DropdownMenuItem<String>(
                                value: invA.keteranganJumlah.indexOf(item) == 0
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
                    invA.statusJumlah == "2"
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextFormField(
                                controller: editController.jumlah_akhir,
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
                            value: invA.statusLuas,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusLuas = newValue ?? invA.statusLuas;
                              });
                            },
                            items: invA.keteranganLuas.map((String item) {
                              return DropdownMenuItem<String>(
                                value: invA.keteranganLuas.indexOf(item) == 0
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
                    invA.statusLuas == "2"
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
                    DropdownSearch<String>(
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        showSearchBox: true,
                      ),
                      items: satuanController.satuanList.map<String>((Map<String, dynamic> item) {
                          return item['satuan_nm'].toString();
                        }).toList(),
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          invA.selectedSatuan = newValue ?? invA.selectedSatuan;
                        });
                      },
                      selectedItem: invA.selectedSatuan != "" ? invA.selectedSatuan : "Pilih satuan",
                      dropdownBuilder: (context, selectedItem) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(selectedItem.toString(), style: TextStyle(fontSize: 16)),
                        );
                      },
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
                            value: invA.statusPerolehan,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusPerolehan =
                                    newValue ?? invA.statusPerolehan;
                              });
                            },
                            items: invA.keteranganPerolehan.map((String item) {
                              return DropdownMenuItem<String>(
                                value:
                                    invA.keteranganPerolehan.indexOf(item) == 0
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
                    invA.statusPerolehan == "2"
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
                              value: invA.dropdownPerolehan.keys
                                      .contains(invA.selectedPerolehan)
                                  ? invA.selectedPerolehan
                                  : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  invA.selectedPerolehan =
                                      newValue ?? invA.selectedPerolehan;
                                });
                              },
                              items: invA.dropdownPerolehan.entries.map((entry) {
                                return DropdownMenuItem<String>(
                                  value: entry.key,
                                  child: Text(entry.value),
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
                            value: invA.statusNilaiPerolehan,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusNilaiPerolehan =
                                    newValue ?? invA.statusNilaiPerolehan;
                              });
                            },
                            items: invA.keteranganNilaiPerolehan
                                .map((String item) {
                              return DropdownMenuItem<String>(
                                value: invA.keteranganNilaiPerolehan
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
                    invA.statusNilaiPerolehan == "2"
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
                        value: invA.statusAtribusi,
                        onChanged: (String? newValue) {
                          setState(() {
                            invA.statusAtribusi = newValue ?? invA.statusAtribusi;
                          });
                        },
                        items: invA.keteranganAtribusi.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invA.keteranganAtribusi.indexOf(item) == 0 ? "1" : "0",
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        RadioListTile(
                          title:
                              Text("Tidak diketahui data awal/induknya"),
                          value: "0",
                          groupValue: invA.chooseAtribusi,
                          onChanged: (value) {
                            setState(() {
                              invA.chooseAtribusi = value.toString();
                            });
                          },
                        ),
                        RadioListTile(
                          title: Text(
                              "Ya, Diketahui data awal/Induknya dan sebutkan data barang awal/induknya"),
                          value: "1",
                          groupValue: invA.chooseAtribusi,
                          onChanged: (value) {
                            setState(() {
                              invA.chooseAtribusi = value.toString();
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    invA.chooseAtribusi == "1" 
                        ? Column(
                            children: [
                              // Nibar
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nibar',
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
                                        controller: editController.atribusi_nibar,
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
                              // Kode Barang
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kode Barang',
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
                                        controller: editController.atribusi_kode_barang,
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
                              // Kode Lokasi
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kode Lokasi',
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
                                        controller: editController.atribusi_kode_lokasi,
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
                              // Kode Register
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Kode Register',
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
                                        controller: editController.atribusi_no_register,
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
                              // Nama Barang
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nama Barang',
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
                                        controller: editController.atribusi_nama_barang,
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
                              // Spesifikasi Barang
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Spesifikasi Barang',
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
                                        controller: editController.atribusi_spesifikasi_barang,
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
                            ],
                          ) 
                        : SizedBox(),
                    ],
                  ),
                SizedBox(height: 10),
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
                            value: invA.statusAlamat,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusAlamat =
                                    newValue ?? invA.statusAlamat;
                              });
                            },
                            items: invA.keteranganAlamat.map((String item) {
                              return DropdownMenuItem<String>(
                                value: invA.keteranganAlamat.indexOf(item) == 0
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
                    invA.statusAlamat == "2"
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
                                  value: invA.selectedKecamatan != "" ? invA.selectedKecamatan : "",
                                  onChanged: (String? newValue) async {
                                    setState(() {
                                      invA.selectedKecamatan = newValue ?? invA.selectedKecamatan;
                                    });

                                    final filteredList = addressController.kecamatanList
                                        .where((kecamatan) => kecamatan['kecamatan_kd'].toString() == newValue);

                                    if (filteredList.isNotEmpty) {
                                      final Map<String, dynamic> selectedKecamatan = filteredList.first;
                                      int idKecamatan = selectedKecamatan['id'];

                                      await addressController.getKelurahan(idKecamatan.toString());
                                      setState(() {
                                        invA.selectedKelurahan = (idKecamatan.toString() == "1") ? "000" : "001";
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
                                  value: invA.selectedKelurahan != "" ? invA.selectedKelurahan : "",
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      invA.selectedKelurahan = newValue ?? invA.selectedKelurahan;
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
                            value: invA.statusHakTanah,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusHakTanah =
                                    newValue ?? invA.statusHakTanah;
                              });
                            },
                            items: invA.keteranganHakTanah.map((String item) {
                              return DropdownMenuItem<String>(
                                value:
                                    invA.keteranganHakTanah.indexOf(item) == 0
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
                    invA.statusHakTanah == "2"
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
                            value: invA.statusNoSertifikat,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusNoSertifikat =
                                    newValue ?? invA.statusNoSertifikat;
                              });
                            },
                            items:
                                invA.keteranganNoSertifikat.map((String item) {
                              return DropdownMenuItem<String>(
                                value:
                                    invA.keteranganNoSertifikat.indexOf(item) ==
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
                    invA.statusNoSertifikat == "2"
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
                            value: invA.statusTglSertifikat,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusTglSertifikat =
                                    newValue ?? invA.statusTglSertifikat;
                              });
                            },
                            items:
                                invA.keteranganTglSertifikat.map((String item) {
                              return DropdownMenuItem<String>(
                                value: invA.keteranganTglSertifikat
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
                    invA.statusTglSertifikat == "2"
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextFormField(
                                controller: editController.a_sertifikat_tanggal_akhir,
                                keyboardType: TextInputType.none,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onTap: () async {
                                  DateTime initialDateTime;
                                  if (editController.a_sertifikat_tanggal_akhir.text.isEmpty) {
                                    initialDateTime = DateTime.now();
                                  } else {
                                    initialDateTime = DateFormat('dd-MM-yyyy').parse(editController.a_sertifikat_tanggal_akhir.text);
                                  }
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
                                      editController.a_sertifikat_tanggal_akhir.text =
                                          formattedDate;
                                    });
                                  } else {
                                    print("Tanggal tidak dipilih");
                                  }
                                },
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
                        value: invA.statusKeberadaanBarang,
                        onChanged: (String? newValue) {
                          setState(() {
                            invA.statusKeberadaanBarang = newValue ?? invA.statusKeberadaanBarang;
                          });
                        },
                        items: invA.keteranganKeberadaanBarang.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invA.keteranganKeberadaanBarang.indexOf(item) == 0 ? "1": "2",
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
                            value: invA.statusKondisi,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusKondisi =
                                    newValue ?? invA.statusKondisi;
                              });
                            },
                            items: invA.keteranganKondisi.map((String item) {
                              return DropdownMenuItem<String>(
                                value: invA.keteranganKondisi.indexOf(item) == 0
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
                    invA.statusKondisi == "2"
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
                              value: invA.selectedKondisi,
                              onChanged: (String? newValue) {
                                setState(() {
                                  invA.selectedKondisi = newValue ?? invA.selectedKondisi;
                                });
                              },
                              items: invA.dropdownKondisi.map((String item) {
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
                            value: invA.statusAsalUsul,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusAsalUsul =
                                    newValue ?? invA.statusAsalUsul;
                              });
                            },
                            items: invA.keteranganAsalUsul.map((String item) {
                              return DropdownMenuItem<String>(
                                value:
                                    invA.keteranganAsalUsul.indexOf(item) == 0
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
                    invA.statusAsalUsul == "2"
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
                        value    : invA.statusPenggunaanStatus,
                        onChanged: (String? newValue) {
                          setState(() {
                            invA.statusPenggunaanStatus = newValue ?? invA.statusPenggunaanStatus;
                          });
                        },
                        items: invA.keteranganStatus.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invA.keteranganStatus.indexOf(item) == 0 ? "1" : "2",
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
                      value: "1",
                      groupValue: invA.choosePemerintahDaerah,
                      onChanged: (value) {
                        setState(() {
                          invA.choosePemerintahDaerah = (value == "1") ? "1" : "";
                          invA.choosePemerintahPusat = "";
                          invA.choosePemerintahDaerahLain = "";
                          invA.choosePihakLain = "";
                        });
                      },
                    ),
                    SizedBox(height: 3),
                    Column(
                      children: [
                        // Nama Kuasa
                        Column(
                          children: [
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
                                  controller: editController.penggunaan_pemda_akhir,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                      ],
                    )
                  ],
                ),
                // Pemerintah Pusat
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile(
                      title: Text("Pemerintah Pusat"),
                      value: "1",
                      groupValue: invA.choosePemerintahPusat,
                      onChanged: (value) {
                        setState(() {
                          invA.choosePemerintahPusat = (value == "1") ? "1" : "";
                          invA.choosePemerintahDaerah= "";
                          invA.choosePemerintahDaerahLain = "";
                          invA.choosePihakLain = "";
                        });
                      },
                    ),
                    SizedBox(height: 3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            value: invA.statusPempus,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusPempus = newValue ?? invA.statusPempus;
                              });
                            },
                            dropdownStyleData: DropdownStyleData(maxHeight: 300),
                            items: [
                              DropdownMenuItem<String>(
                                value: "3",
                                child: Text("Pilih"),
                              ),
                              ...invA.keteranganPempus.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: invA.keteranganPempus.indexOf(item) == 0
                                        ? "1"
                                        : "0",
                                    child: Text(item),
                                  );
                                }).toList(),
                            ],
                          ),
                        ),
                        if(invA.statusPempus == "1")
                        Padding(
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
                                            controller: editController.penggunaan_pempus_y_nm,
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
                                            controller: editController.penggunaan_pempus_y_doc,
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
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        if(invA.statusPempus == "0")
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 10),
                          child: Row(
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
                                        controller: editController.penggunaan_pempus_t_nm,
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
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
                // Pemerintah Daerah Lain
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile(
                      title: Text("Pemerintah Daerah Lain"),
                      value: "1",
                      groupValue: invA.choosePemerintahDaerahLain,
                      onChanged: (value) {
                        setState(() {
                          invA.choosePemerintahDaerahLain = (value == "1") ? "1" : "";
                          invA.choosePemerintahDaerah = "";
                          invA.choosePemerintahPusat = "";
                          invA.choosePihakLain = "";
                        });
                      },
                    ),
                    SizedBox(height: 3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            value: invA.statusPdl,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusPdl = newValue ?? invA.statusPdl;
                              });
                            },
                            dropdownStyleData: DropdownStyleData(maxHeight: 300),
                            items: [
                              DropdownMenuItem<String>(
                                value: "3",
                                child: Text("Pilih"),
                              ),
                              ...invA.keteranganPdl.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: invA.keteranganPdl.indexOf(item) == 0
                                        ? "1"
                                        : "0",
                                    child: Text(item),
                                  );
                                }).toList(),
                            ],
                          ),
                        ),
                        if(invA.statusPdl == "1")
                        Padding(
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
                                            controller: editController.penggunaan_pdl_y_nm,
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
                                            controller: editController.penggunaan_pdl_y_doc,
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
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        if(invA.statusPdl == "0")
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 10),
                          child: Row(
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
                                        controller: editController.penggunaan_pdl_t_nm,
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
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 10),
                // Pihak Lain
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RadioListTile(
                        title: Text("Pihak Lain"),
                        value: "1",
                        groupValue: invA.choosePihakLain,
                        onChanged: (value) {
                          setState(() {
                            invA.choosePihakLain = (value == "1") ? "1" : "";
                            invA.choosePemerintahDaerah = "";
                            invA.choosePemerintahPusat = "";
                            invA.choosePemerintahDaerahLain = "";
                          });
                        },
                    ),
                    SizedBox(height: 3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            value: invA.statusPl,
                            onChanged: (String? newValue) {
                              setState(() {
                                invA.statusPl = newValue ?? invA.statusPl;
                              });
                            },
                            dropdownStyleData: DropdownStyleData(maxHeight: 300),
                            items: [
                              DropdownMenuItem<String>(
                                value: "3",
                                child: Text("Pilih"),
                              ),
                              ...invA.keteranganPl.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: invA.keteranganPl.indexOf(item) == 0
                                        ? "1"
                                        : "0",
                                    child: Text(item),
                                  );
                                }).toList(),
                            ],
                          ),
                        ),
                        if(invA.statusPl == "1")
                        Padding(
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
                                            controller: editController.penggunaan_pl_y_nm,
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
                                            controller: editController.penggunaan_pl_y_doc,
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
                              SizedBox(height: 10),
                            ],
                          ),
                        ),
                        if(invA.statusPl == "0")
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 10),
                          child: Row(
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
                                        controller: editController.penggunaan_pl_t_nm,
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
                        ),
                      ],
                    )
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
                        value: invA.statusGanda,
                        onChanged: (String? newValue) {
                          setState(() {
                            invA.statusGanda = newValue ?? invA.statusGanda;
                          });
                        },
                        items: invA.keteranganGanda.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invA.keteranganGanda.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                    invA.statusGanda == "1"
                      ? Column(
                          children: [
                            SizedBox(height: 15),
                            // Nibar
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nibar',
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
                                      controller: editController.tercatat_ganda_nibar,
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
                            // Kode Register
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kode Register',
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
                                      controller: editController.tercatat_ganda_no_register,
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
                            // Kode Barang
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kode Barang',
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
                                      controller: editController.tercatat_ganda_kode_barang,
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
                            // Nama Barang
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nama Barang',
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
                                      controller: editController.tercatat_ganda_nama_barang,
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
                            // Spesifikasi Barang
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nama Spesifikasi Barang',
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
                                      controller: editController.tercatat_ganda_spesifikasi_barang,
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
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey.shade400,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: TextFormField(
                                      controller: editController.tercatat_ganda_luas,
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
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.grey.shade400,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: TextFormField(
                                      controller: editController.tercatat_ganda_satuan,
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
                            // Nilai Perolehan Barang
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Nilai Perolehan Barang',
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
                                      controller: editController.tercatat_ganda_perolehan,
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
                            // Tanggal, Bulan, Tahun Perolehan
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tanggal, Bulan, Tahun Perolehan',
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
                                      controller: editController.tercatat_ganda_tanggal_perolehan,
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
                            // Kuasa Pengguna Barang Lainnya, Pengguna Barang lainnya atau Pengelola Barang
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Kuasa Pengguna Barang Lainnya, Pengguna Barang lainnya atau Pengelola Barang',
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
                                      controller: editController.tercatat_ganda_kuasa_pengguna,
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
                          ],
                        )
                      : SizedBox(),
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
                        value: invA.dropdownAtasNama.keys
                                .contains(invA.statusAtasNama)
                            ? invA.statusAtasNama
                            : null,
                        onChanged: (String? newValue) {
                          setState(() {
                            invA.statusAtasNama =
                                newValue ?? invA.statusAtasNama;
                          });
                        },
                        items: invA.dropdownAtasNama.keys.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(invA.dropdownAtasNama[item]!),
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
                        SizedBox(width: 10),
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Icon(
                                // Icons.location_on_sharp,
                                Icons.my_location_rounded,
                                size: 27,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          onTap: () {
                            locationController.determinePosition();
                          },
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
                          controller: editController.lainnya,
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
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.add_photo_alternate_outlined,
                                size: 27,
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
                  ],
                ),
                SizedBox(height: 10),
                Column(
                  children: List.generate(
                    _petugasList.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: FormDynamicPetugas(
                              key: UniqueKey(),
                              initialValue: _petugasList[index],
                              onChanged: (v) => _petugasList[index] = v,
                            ),
                          ),
                          const SizedBox(width: 10),
                          _textfieldBtn(index),
                        ],
                      ),
                    ),
                  ),
                ),
                // Button Simpan
                Padding(
                  padding: const EdgeInsets.only(bottom: 35, top: 20),
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
                      List<String> id = [
                        editController.kib_id.text,
                        editController.penetapan_id.text,
                        editController.departemen_id.text,
                      ];

                      List<dynamic> data = [
                        editController.tgl_inventaris.text,
                        editController.no_register_awal.text,
                        (invA.statusNoRegister == "1") ? editController.no_register_awal.text : editController.no_register_akhir.text,
                        invA.statusNoRegister,
                        editController.kategori_id_awal.text,
                        (invA.statusBarang == "1") ? editController.kategori_id_awal.text : invA.selectedKategori,
                        invA.statusBarang,
                        editController.nama_spesifikasi_awal.text,
                        (invA.statusNamaBarang == "1") ? editController.nama_spesifikasi_awal.text : editController.nama_spesifikasi_akhir.text,
                        invA.statusNamaBarang,
                        editController.jumlah_awal.text,
                        (invA.statusJumlah == "1") ? editController.jumlah_awal.text : editController.jumlah_akhir.text,
                        invA.statusJumlah,
                        editController.a_luas_m2_awal.text,
                        (invA.statusLuas == "1") ? editController.a_luas_m2_awal.text : editController.a_luas_m2_akhir.text,
                        invA.statusLuas,
                        invA.selectedSatuan,
                        editController.cara_perolehan_awal.text,
                        (invA.statusPerolehan == "1")
                          ? (editController.cara_perolehan_awal.text == "Pembelian") ? "1" : 
                            (editController.cara_perolehan_awal.text == "Hibah") ? "2" : 
                            (editController.cara_perolehan_awal.text == "Barang & Jasa") ? "3" :
                            (editController.cara_perolehan_awal.text == "Hasil Inventarisasi") ? "4" : ""
                          : invA.selectedPerolehan,
                        invA.statusPerolehan,
                        editController.tgl_perolehan.text,
                        editController.tahun_perolehan.text,
                        editController.perolehan_awal.text,
                        (invA.statusNilaiPerolehan == "1") ? editController.perolehan_awal.text : editController.perolehan_akhir.text,
                        invA.statusNilaiPerolehan,
                        invA.statusAtribusi,
                        invA.chooseAtribusi,
                        editController.atribusi_nibar.text,
                        editController.atribusi_kode_barang.text,
                        editController.atribusi_kode_lokasi.text,
                        editController.atribusi_no_register.text,
                        editController.atribusi_nama_barang.text,
                        editController.atribusi_spesifikasi_barang.text,
                        editController.a_alamat_awal.text,
                        invA.statusAlamat,
                        editController.alamat_kota.text,
                        invA.selectedKecamatan,
                        invA.selectedKelurahan,
                        editController.alamat_jalan.text,
                        editController.alamat_no.text,
                        editController.alamat_rt.text,
                        editController.alamat_rw.text,
                        editController.alamat_kodepos.text,
                        editController.a_hak_tanah_awal.text,
                        (invA.statusHakTanah == "1") ? editController.a_hak_tanah_awal.text : editController.a_hak_tanah_akhir.text,
                        invA.statusHakTanah,
                        editController.a_sertifikat_nomor_awal.text,
                        (invA.statusNoSertifikat == "1") ? editController.a_sertifikat_nomor_awal.text : editController.a_sertifikat_nomor_akhir.text,
                        invA.statusNoSertifikat,
                        editController.a_sertifikat_tanggal_awal.text,
                        (invA.statusTglSertifikat == "1") ? editController.a_sertifikat_tanggal_awal.text : editController.a_sertifikat_tanggal_akhir.text,
                        invA.statusTglSertifikat,
                        invA.statusKeberadaanBarang,
                        editController.kondisi_awal.text,
                        (invA.statusKondisi == "1") ? editController.kondisi_awal.text : invA.selectedKondisi,
                        invA.statusKondisi,
                        editController.asal_usul_awal.text,
                        (invA.statusAsalUsul == "1") ? editController.asal_usul_awal.text : editController.asal_usul_akhir.text,
                        invA.statusAsalUsul,
                        invA.statusPenggunaanStatus,
                        editController.penggunaan_awal.text,
                        invA.choosePemerintahDaerah,
                        editController.penggunaan_pemda_akhir.text,
                        invA.choosePemerintahPusat,
                        invA.statusPempus,
                        editController.penggunaan_pempus_y_nm.text,
                        editController.penggunaan_pempus_y_doc.text,
                        editController.penggunaan_pempus_t_nm.text,
                        invA.choosePemerintahDaerahLain,
                        invA.statusPdl,
                        editController.penggunaan_pdl_y_nm.text,
                        editController.penggunaan_pdl_y_doc.text,
                        editController.penggunaan_pdl_t_nm.text,
                        invA.choosePihakLain,
                        invA.statusPl,
                        editController.penggunaan_pl_y_nm.text,
                        editController.penggunaan_pl_y_doc.text,
                        editController.penggunaan_pl_t_nm.text,
                        invA.statusGanda,
                        editController.tercatat_ganda_nibar.text,          
                        editController.tercatat_ganda_no_register.text,       
                        editController.tercatat_ganda_kode_barang.text,       
                        editController.tercatat_ganda_nama_barang.text,       
                        editController.tercatat_ganda_spesifikasi_barang.text,
                        editController.tercatat_ganda_luas.text,              
                        editController.tercatat_ganda_satuan.text,            
                        editController.tercatat_ganda_perolehan.text,         
                        editController.tercatat_ganda_tanggal_perolehan.text,                        
                        editController.tercatat_ganda_kuasa_pengguna.text,
                        invA.statusAtasNama,
                        editController.lat.text,
                        editController.long.text,
                        editController.lainnya.text,
                        editController.keterangan.text,
                        _petugasList,
                      ];

                      if(invA.statusInventaris == "0"){
                        editController.insertInventarisA(id, data);
                      } else {
                        editController.updateInventarisA(editController.kib_id.text, data);
                      }
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

  Widget _textfieldBtn(int index) {
    bool isLast = index == _petugasList.length - 1;

    return InkWell(
      onTap: () => setState(
        () => isLast ? _petugasList.add('') : _petugasList.removeAt(index),
      ),
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isLast ? Colors.green : Colors.red,
        ),
        child: Icon(
          isLast ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}