import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:kib_application/constans/inventoryVariablesD.dart';
import 'package:kib_application/controllers/addressController.dart';
import 'package:kib_application/controllers/appointmentController.dart';
import 'package:kib_application/controllers/categoryController.dart';
import 'package:kib_application/controllers/getLocationController.dart';
import 'package:kib_application/controllers/inventoryDController.dart';
import 'package:kib_application/controllers/kuasaController.dart';
import 'package:kib_application/controllers/unitController.dart';
import 'package:kib_application/widgets/formPetugas.dart';

class EditInventoryDScreen extends StatefulWidget {
  const EditInventoryDScreen({super.key});

  @override
  State<EditInventoryDScreen> createState() => _EditInventoryDScreenState();
}

class _EditInventoryDScreenState extends State<EditInventoryDScreen> {
  final penetapanController = Get.put(AppointmentController());
  final editController      = Get.put(InventoryDController());
  final kategoriController  = Get.put(CategoryController());
  final satuanController    = Get.put(UnitController());
  final kuasaController     = Get.put(KuasaController());
  final addressController   = Get.put(AddressController());
  final locationController  = Get.put(LocationController());
  final invD                = Get.put(InventoryVariablesD());

  List<dynamic> _petugasList = [''];

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    final data         = penetapanController.penetapanListById[0];
    final kuasa        = kuasaController.kuasaList[0];
    final filteredList = addressController.kecamatanList
      .where((kecamatan) => kecamatan['kecamatan_kd'].toString() == data['alamat_kecamatan'].toString());

    invD.statusInventaris                                   = data['status_inventaris'].toString();
    editController.kib_id.text                              = data['kib_id'].toString();
    editController.penetapan_id.text                        = data['penetapan_id'].toString();
    editController.departemen_id.text                       = data['departemen_id'].toString();

    editController.tgl_inventaris.text                      = (invD.statusInventaris == "0") ? DateFormat('dd-MM-yyyy').format(now) : data['tgl_inventaris_formatted'].toString();
    editController.skpd.text                                = data['departemen_kd'].toString();
    editController.skpd_uraian.text                         = data['departemen_nm'].toString();
    editController.no_register_awal.text                    = (invD.statusInventaris == "0") ? data['no_register'].toString() : data['no_register_awal'].toString();
    editController.no_register_akhir.text                   = (invD.statusInventaris == "0") ? data['no_register'].toString() : data['no_register_akhir'].toString();
    invD.statusNoRegister                                   = data['no_register_status']      != "" ? data['no_register_status'].toString() : "1";
    editController.barang.text                              = data['kategori_kd'].toString() + ' - ' + data['kategori_nm'].toString();
    editController.kategori_id_awal.text                    = (invD.statusInventaris == "0") ? data['kategori_id'].toString() : data['kategori_id_awal'].toString();
    invD.selectedKategori                                   = (invD.statusInventaris == "0") ? data['kategori_id'].toString() : data['kategori_id_akhir'].toString();
    invD.statusBarang                                       = data['kategori_id_status']      != "" ? data['kategori_id_status'].toString() : "1";
    editController.nama_spesifikasi_awal.text               = (invD.statusInventaris == "0") ? "" : data['nama_spesifikasi_awal'].toString();
    editController.nama_spesifikasi_akhir.text              = (invD.statusInventaris == "0") ? "" : data['nama_spesifikasi_akhir'].toString();
    invD.statusNamaBarang                                   = data['nama_spesifikasi_status'] != "" ? data['nama_spesifikasi_status'].toString() : "1";
    editController.jumlah_awal.text                         = data['jumlah'].toString();
    invD.selectedSatuan                                     = (invD.statusInventaris == "0") ? (data['satuan_awal'] != "") ? data['satuan_awal'].toString() : "" : (data['satuan_akhir'] != "") ? data['satuan_akhir'].toString() : "";
    editController.cara_perolehan_awal.text                 = (invD.statusInventaris == "0") ? data['cara_perolehan'].toString() : data['cara_perolehan_awal'].toString();
    invD.statusPerolehan                                    = data['cara_perolehan_status']   != "" ? data['cara_perolehan_status'].toString() : "1";

    String caraPerolehan = (invD.statusInventaris == "0") ? data['cara_perolehan'].toString() : data['cara_perolehan_akhir'].toString();
    if (caraPerolehan == "Pembelian" || caraPerolehan == "1" || caraPerolehan == "") {
      invD.selectedPerolehan = "1";
    } else if (caraPerolehan == "Hibah" || caraPerolehan == "2") {
      invD.selectedPerolehan = "2";
    } else if (caraPerolehan == "Barang & Jasa" || caraPerolehan == "3") {
      invD.selectedPerolehan = "3";
    } else if (caraPerolehan == "Hasil Inventarisasi" || caraPerolehan == "4") {
      invD.selectedPerolehan = "4";
    }
    
    editController.tgl_perolehan.text                       = (invD.statusInventaris == "0") ? data['tgl_perolehan_penetapan'].toString() : data['tgl_perolehan_inventaris'].toString();
    editController.tahun_perolehan.text                     = (invD.statusInventaris == "0") ? data['th_beli'].toString() : data['tahun_perolehan'].toString();
    editController.perolehan_awal.text                      = (invD.statusInventaris == "0") ? data['perolehan_formatted'].toString() : data['perolehan_awal_formatted'].toString();
    editController.perolehan_akhir.text                     = (invD.statusInventaris == "0") ? data['perolehan_formatted'].toString() : data['perolehan_akhir_formatted'].toString();
    invD.statusNilaiPerolehan                               = data['perolehan_status'] != "" ? data['perolehan_status'].toString() : "1";
    invD.statusAtribusi                                     = data['atribusi_biaya']   != "" ? data['atribusi_biaya'].toString() : "0";
    invD.chooseAtribusi                                     = data['atribusi_status']  != "" ? data['atribusi_status'].toString() : "0";
    editController.atribusi_nibar.text                      = (invD.statusInventaris == "0") ? "" : data['atribusi_nibar'].toString();
    editController.atribusi_kode_barang.text                = (invD.statusInventaris == "0") ? "" : data['atribusi_kode_barang'].toString();
    editController.atribusi_kode_lokasi.text                = (invD.statusInventaris == "0") ? "" : data['atribusi_kode_lokasi'].toString();
    editController.atribusi_no_register.text                = (invD.statusInventaris == "0") ? "" : data['atribusi_no_register'].toString();
    editController.atribusi_nama_barang.text                = (invD.statusInventaris == "0") ? "" : data['atribusi_nama_barang'].toString();
    editController.atribusi_spesifikasi_barang.text         = (invD.statusInventaris == "0") ? "" : data['atribusi_spesifikasi_barang'].toString();
    editController.a_alamat_awal.text                       = data['d_lokasi'].toString();
    invD.statusAlamat                                       = data['a_alamat_status']  != "" ? data['a_alamat_status'].toString() : "1";
    editController.alamat_kota.text                         = data['alamat_kota']      != "" ? data['alamat_kota'].toString() : "KOTA BOGOR";
    invD.selectedKecamatan                                  = data['alamat_kecamatan'].toString();
    
    if (filteredList.isNotEmpty) {
      final Map<String, dynamic> selectedKecamatan = filteredList.first;
      int idKecamatan = selectedKecamatan['id'];
      invD.selectedKelurahan = (idKecamatan.toString() == "1") ? "000" : data['alamat_kelurahan'].toString();
    }

    editController.alamat_jalan.text                        = data['alamat_jalan'].toString();
    editController.alamat_no.text                           = data['alamat_no'].toString();
    editController.alamat_rt.text                           = data['alamat_rt'].toString();
    editController.alamat_rw.text                           = data['alamat_rw'].toString();
    editController.alamat_kodepos.text                      = data['alamat_kodepos'].toString();
    invD.statusKeberadaanBarang                             = data['keberadaan_barang_status']        != "" ? data['keberadaan_barang_status'].toString() : "1";
    editController.kondisi_awal.text                        = (invD.statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_awal'].toString();
    invD.selectedKondisi                                    = (invD.statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_akhir'].toString();
    invD.statusKondisi                                      = data['kondisi_status']                  != "" ? data['kondisi_status'].toString() : "1";
    editController.asal_usul_awal.text                      = (invD.statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_awal'].toString();
    editController.asal_usul_akhir.text                     = (invD.statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_akhir'].toString();
    invD.statusAsalUsul                                     = data['asal_usul_status']                != "" ? data['asal_usul_status'].toString() : "1";
    invD.statusPenggunaanStatus                             = data['penggunaan_status']               != "" ? data['penggunaan_status'].toString() : "1";
    editController.penggunaan_awal.text                     = (invD.statusInventaris == "0") ? data['a_penggunaan'].toString() : data['penggunaan_awal'].toString();
    invD.choosePemerintahDaerah                             = (invD.statusInventaris == "0") ? "1" : data['penggunaan_pemda_status'].toString();
    editController.penggunaan_pemda_akhir.text              = (invD.statusInventaris == "0") ? kuasa['nama'].toString() : data['penggunaan_pemda_akhir'].toString();
    invD.choosePemerintahPusat                              = data['penggunaan_pempus_status'].toString();
    invD.statusPempus                                       = data['penggunaan_pempus_yt']            != "" ? data['penggunaan_pempus_yt'].toString() : "3";
    editController.penggunaan_pempus_y_nm.text              = data['penggunaan_pempus_y_nm'].toString();
    editController.penggunaan_pempus_y_doc.text             = data['penggunaan_pempus_y_doc'].toString();
    editController.penggunaan_pempus_t_nm.text              = data['penggunaan_pempus_t_nm'].toString();
    invD.choosePemerintahDaerahLain                         = data['penggunaan_pdl_status'].toString();
    invD.statusPdl                                          = data['penggunaan_pdl_yt']               != "" ? data['penggunaan_pdl_yt'].toString() : "3";
    editController.penggunaan_pdl_y_nm.text                 = data['penggunaan_pdl_y_nm'].toString();
    editController.penggunaan_pdl_y_doc.text                = data['penggunaan_pdl_y_doc'].toString();
    editController.penggunaan_pdl_t_nm.text                 = data['penggunaan_pdl_t_nm'].toString();
    invD.choosePihakLain                                    = data['penggunaan_pl_status'].toString();
    invD.statusPl                                           = data['penggunaan_pl_yt']                != "" ? data['penggunaan_pl_yt'].toString() : "3";
    editController.penggunaan_pl_y_nm.text                  = data['penggunaan_pl_y_nm'].toString();
    editController.penggunaan_pl_y_doc.text                 = data['penggunaan_pl_y_doc'].toString();
    editController.penggunaan_pl_t_nm.text                  = data['penggunaan_pl_t_nm'].toString();
    editController.d_jenis_pengkerasan_jln_awal.text        = data['d_jenis_pengkerasan_jln_awal']    != "" ? data['d_jenis_pengkerasan_jln_awal'].toString() : "";
    editController.d_jenis_pengkerasan_jln_akhir.text       = data['d_jenis_pengkerasan_jln_akhir']   != "" ? data['d_jenis_pengkerasan_jln_akhir'].toString() : "";
    invD.statusPengkerasanJalan                             = data['d_jenis_pengkerasan_jln_status']  != "" ? data['d_jenis_pengkerasan_jln_status'].toString() : "1";
    editController.d_jenis_bahan_jembatan_awal.text         = data['d_jenis_bahan_jembatan_awal']     != "" ? data['d_jenis_bahan_jembatan_awal'].toString() : "";
    editController.d_jenis_bahan_jembatan_akhir.text        = data['d_jenis_bahan_jembatan_akhir']    != "" ? data['d_jenis_bahan_jembatan_akhir'].toString() : "";
    invD.statusBahanJembatan                                = data['d_jenis_bahan_jembatan_status']   != "" ? data['d_jenis_bahan_jembatan_status'].toString() : "1";
    editController.d_nomor_ruas_jln_awal.text               = data['d_nomor_ruas_jln_awal']           != "" ? data['d_nomor_ruas_jln_awal'].toString() : "";
    editController.d_nomor_ruas_jln_akhir.text              = data['d_nomor_ruas_jln_akhir']          != "" ? data['d_nomor_ruas_jln_akhir'].toString() : "";
    invD.statusNoRuasJalan                                  = data['d_nomor_ruas_jln_status']         != "" ? data['d_nomor_ruas_jln_status'].toString() : "1";
    editController.d_nomor_jaringan_irigasi_awal.text       = data['d_nomor_jaringan_irigasi_awal']   != "" ? data['d_nomor_jaringan_irigasi_awal'].toString() : "";
    editController.d_nomor_jaringan_irigasi_akhir.text      = data['d_nomor_jaringan_irigasi_awal']   != "" ? data['d_nomor_jaringan_irigasi_awal'].toString() : "";
    invD.statusNoJaringanIrigasi                            = data['d_nomor_jaringan_irigasi_status'] != "" ? data['d_nomor_jaringan_irigasi_status'].toString() : "1";
    editController.d_konstruksi_awal.text                   = (invD.statusInventaris == "0") ? data['d_konstruksi'] : data['d_konstruksi_awal'].toString();
    editController.d_konstruksi_akhir.text                  = (invD.statusInventaris == "0") ? data['d_konstruksi'] : data['d_konstruksi_akhir'].toString();
    invD.statusKonstruksi                                   = data['d_konstruksi_status']             != "" ? data['d_konstruksi_status'].toString() : "1";
    editController.d_panjang_awal.text                      = (invD.statusInventaris == "0") ? data['d_panjang'] : data['d_panjang_awal'].toString();
    editController.d_panjang_akhir.text                     = (invD.statusInventaris == "0") ? data['d_panjang'] : data['d_panjang_akhir'].toString();
    invD.statusPanjang                                      = data['d_panjang_status']                != "" ? data['d_panjang_status'].toString() : "1";
    invD.selectedPanjang                                    = (invD.statusInventaris == "0") ? "Km" : data['d_panjang_satuan'].toString();
    editController.d_lebar_awal.text                        = (invD.statusInventaris == "0") ? data['d_lebar'] : data['d_lebar_awal'].toString();
    editController.d_lebar_akhir.text                       = (invD.statusInventaris == "0") ? data['d_lebar'] : data['d_lebar_akhir'].toString();
    invD.statusLebar                                        = data['d_lebar_status']                  != "" ? data['d_lebar_status'].toString() : "1";
    invD.selectedLebar                                      = (invD.statusInventaris == "0") ? "M" : data['d_lebar_satuan'].toString();
    editController.d_luas_awal.text                         = (invD.statusInventaris == "0") ? data['d_luas'] : data['d_luas_awal'].toString();
    editController.d_luas_akhir.text                        = (invD.statusInventaris == "0") ? data['d_luas'] : data['d_luas_akhir'].toString();
    invD.statusLuas                                         = data['d_luas_status']                   != "" ? data['d_luas_status'].toString() : "1";
    invD.selectedLuas                                       = (invD.statusInventaris == "0") ? "M2" : data['d_luas_satuan'].toString();
    editController.d_luas_tanah.text                        = data['d_luas_tanah']                    != "" ? data['d_luas_tanah'].toString() : "";
    invD.selectedStatusTanah                                = (invD.statusInventaris == "0") ? "Hak Milik" : data['d_status_tanah_inventaris'].toString();
    invD.statusGanda                                        = data['tercatat_ganda']                  != "" ? data['tercatat_ganda'].toString() : "2";
    editController.tercatat_ganda_nibar.text                = data['tercatat_ganda_nibar'].toString();
    editController.tercatat_ganda_no_register.text          = data['tercatat_ganda_no_register'].toString();
    editController.tercatat_ganda_kode_barang.text          = data['tercatat_ganda_kode_barang'].toString();
    editController.tercatat_ganda_nama_barang.text          = data['tercatat_ganda_nama_barang'].toString();
    editController.tercatat_ganda_spesifikasi_barang.text   = data['tercatat_ganda_spesifikasi_barang'].toString();
    editController.tercatat_ganda_luas.text                 = data['tercatat_ganda_luas'].toString();
    editController.tercatat_ganda_satuan.text               = data['tercatat_ganda_satuan'].toString();
    editController.tercatat_ganda_perolehan.text            = data['tercatat_ganda_perolehan'].toString();
    editController.tercatat_ganda_tanggal_perolehan.text    = data['tercatat_ganda_tanggal_perolehan'].toString();
    editController.tercatat_ganda_kuasa_pengguna.text       = data['tercatat_ganda_kuasa_pengguna'].toString();
    invD.statusAtasNama                                     = data['pemilik_id']                      != "" ? data['pemilik_id'].toString() : "1";
    editController.lat.text                                 = (invD.statusInventaris == "0") ? data['lat_penetapan'].toString() : data['lat_inventaris'].toString();
    editController.long.text                                = (invD.statusInventaris == "0") ? data['long_penetapan'].toString() : data['long_inventaris'].toString();
    editController.lainnya.text                             = data['lainnya'].toString();
    editController.keterangan.text                          = (invD.statusInventaris == "0") ? data['keterangan_penetapan'].toString() : data['keterangan_inventaris'].toString();
    editController.file_nm.text                             = (invD.statusInventaris == "0") ? data['file_penetapan'].toString() : data['file_inventaris'].toString();
    _petugasList                                            = data['petugas']                         != null && data['petugas'].isNotEmpty ? List<String>.from(data['petugas']) : [""];
  
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
        title: Text('Edit Inventaris - D'),
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
                          value: invD.statusNoRegister,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusNoRegister =
                                  newValue ?? invD.statusNoRegister;
                            });
                          },
                          items: invD.keteranganNoRegister.map((String item) {
                            return DropdownMenuItem<String>(
                              value:
                                  invD.keteranganNoRegister.indexOf(item) == 0
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
                  invD.statusNoRegister == "2"
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
                          value: invD.statusBarang,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusBarang =
                                  newValue ?? invD.statusBarang;
                            });
                          },
                          items: invD.keteranganBarang.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invD.keteranganBarang.indexOf(item) == 0
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
                  invD.statusBarang == "2"
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
                                invD.selectedKategori = id;
                                print(invD.selectedKategori);
                              });
                            }
                          },
                          selectedItem: invD.selectedKategori != ""
                            ? kategoriController.kategoriList
                                .where((item) => item['id'].toString() == invD.selectedKategori)
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
                          value: invD.statusNamaBarang,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusNamaBarang =
                                  newValue ?? invD.statusNamaBarang;
                            });
                          },
                          items: invD.keteranganNamaBarang.map((String item) {
                            return DropdownMenuItem<String>(
                              value:
                                  invD.keteranganNamaBarang.indexOf(item) == 0
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
                  invD.statusNamaBarang == "2"
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
                        invD.selectedSatuan = newValue ?? invD.selectedSatuan;
                      });
                    },
                    selectedItem: invD.selectedSatuan != "" ? invD.selectedSatuan : "Pilih satuan",
                    dropdownBuilder: (context, selectedItem) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 5),
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
                          value: invD.statusPerolehan,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusPerolehan =
                                  newValue ?? invD.statusPerolehan;
                            });
                          },
                          items: invD.keteranganPerolehan.map((String item) {
                            return DropdownMenuItem<String>(
                              value:
                                  invD.keteranganPerolehan.indexOf(item) == 0
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
                  invD.statusPerolehan == "2"
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
                            value: invD.dropdownPerolehan.keys
                                    .contains(invD.selectedPerolehan)
                                ? invD.selectedPerolehan
                                : null,
                            onChanged: (String? newValue) {
                              setState(() {
                                invD.selectedPerolehan =
                                    newValue ?? invD.selectedPerolehan;
                              });
                            },
                            items: invD.dropdownPerolehan.entries.map((entry) {
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
                          value: invD.statusNilaiPerolehan,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusNilaiPerolehan =
                                  newValue ?? invD.statusNilaiPerolehan;
                            });
                          },
                          items: invD.keteranganNilaiPerolehan
                              .map((String item) {
                            return DropdownMenuItem<String>(
                              value: invD.keteranganNilaiPerolehan
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
                  invD.statusNilaiPerolehan == "2"
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
                      value: invD.statusAtribusi,
                      onChanged: (String? newValue) {
                        setState(() {
                          invD.statusAtribusi = newValue ?? invD.statusAtribusi;
                        });
                      },
                      items: invD.keteranganAtribusi.map((String item) {
                        return DropdownMenuItem<String>(
                          value: invD.keteranganAtribusi.indexOf(item) == 0 ? "1" : "0",
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  invD.statusAtribusi == "1"
                    ? Column(
                        children: [
                          RadioListTile(
                            title:
                                Text("Tidak diketahui data awal/induknya"),
                            value: "0",
                            groupValue: invD.chooseAtribusi,
                            onChanged: (value) {
                              setState(() {
                                invD.chooseAtribusi = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text(
                                "Ya, Diketahui data awal/Induknya dan sebutkan data barang awal/induknya"),
                            value: "1",
                            groupValue: invD.chooseAtribusi,
                            onChanged: (value) {
                              setState(() {
                                invD.chooseAtribusi = value.toString();
                              });
                            },
                          ),
                        ],
                      )
                    : SizedBox(),
                  SizedBox(height: 10),
                  invD.chooseAtribusi == "1" 
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
                          value: invD.statusAlamat,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusAlamat =
                                  newValue ?? invD.statusAlamat;
                            });
                          },
                          items: invD.keteranganAlamat.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invD.keteranganAlamat.indexOf(item) == 0
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
                  invD.statusAlamat == "2"
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
                                value: invD.selectedKecamatan != "" ? invD.selectedKecamatan : "",
                                onChanged: (String? newValue) async {
                                  setState(() {
                                    invD.selectedKecamatan = newValue ?? invD.selectedKecamatan;
                                  });

                                  final filteredList = addressController.kecamatanList
                                      .where((kecamatan) => kecamatan['kecamatan_kd'].toString() == newValue);

                                  if (filteredList.isNotEmpty) {
                                    final Map<String, dynamic> selectedKecamatan = filteredList.first;
                                    int idKecamatan = selectedKecamatan['id'];

                                    await addressController.getKelurahan(idKecamatan.toString());
                                    setState(() {
                                      invD.selectedKelurahan = (idKecamatan.toString() == "1") ? "000" : "001";
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
                                value: invD.selectedKelurahan != "" ? invD.selectedKelurahan : "",
                                onChanged: (String? newValue) {
                                  setState(() {
                                    invD.selectedKelurahan = newValue ?? invD.selectedKelurahan;
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
                      value: invD.statusKeberadaanBarang,
                      onChanged: (String? newValue) {
                        setState(() {
                          invD.statusKeberadaanBarang = newValue ?? invD.statusKeberadaanBarang;
                        });
                      },
                      items: invD.keteranganKeberadaanBarang.map((String item) {
                        return DropdownMenuItem<String>(
                          value: invD.keteranganKeberadaanBarang.indexOf(item) == 0 ? "1": "2",
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
                          value: invD.statusKondisi,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusKondisi =
                                  newValue ?? invD.statusKondisi;
                            });
                          },
                          items: invD.keteranganKondisi.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invD.keteranganKondisi.indexOf(item) == 0
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
                  invD.statusKondisi == "2"
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
                            value: invD.selectedKondisi,
                            onChanged: (String? newValue) {
                              setState(() {
                                invD.selectedKondisi = newValue ?? invD.selectedKondisi;
                              });
                            },
                            items: invD.dropdownKondisi.map((String item) {
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
                          value: invD.statusAsalUsul,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusAsalUsul =
                                  newValue ?? invD.statusAsalUsul;
                            });
                          },
                          items: invD.keteranganAsalUsul.map((String item) {
                            return DropdownMenuItem<String>(
                              value:
                                  invD.keteranganAsalUsul.indexOf(item) == 0
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
                  invD.statusAsalUsul == "2"
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
                      value    : invD.statusPenggunaanStatus,
                      onChanged: (String? newValue) {
                        setState(() {
                          invD.statusPenggunaanStatus = newValue ?? invD.statusPenggunaanStatus;
                        });
                      },
                      items: invD.keteranganStatus.map((String item) {
                        return DropdownMenuItem<String>(
                          value: invD.keteranganStatus.indexOf(item) == 0 ? "1" : "2",
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
                    groupValue: invD.choosePemerintahDaerah,
                    onChanged: (value) {
                      setState(() {
                        invD.choosePemerintahDaerah = (value == "1") ? "1" : "";
                        invD.choosePemerintahPusat = "";
                        invD.choosePemerintahDaerahLain = "";
                        invD.choosePihakLain = "";
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
                    groupValue: invD.choosePemerintahPusat,
                    onChanged: (value) {
                      setState(() {
                        invD.choosePemerintahPusat = (value == "1") ? "1" : "";
                        invD.choosePemerintahDaerah= "";
                        invD.choosePemerintahDaerahLain = "";
                        invD.choosePihakLain = "";
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
                          value: invD.statusPempus,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusPempus = newValue ?? invD.statusPempus;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(maxHeight: 300),
                          items: [
                            DropdownMenuItem<String>(
                              value: "3",
                              child: Text("Pilih"),
                            ),
                            ...invD.keteranganPempus.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: invD.keteranganPempus.indexOf(item) == 0
                                      ? "1"
                                      : "0",
                                  child: Text(item),
                                );
                              }).toList(),
                          ],
                        ),
                      ),
                      if(invD.statusPempus == "1")
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
                      if(invD.statusPempus == "0")
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
                    groupValue: invD.choosePemerintahDaerahLain,
                    onChanged: (value) {
                      setState(() {
                        invD.choosePemerintahDaerahLain = (value == "1") ? "1" : "";
                        invD.choosePemerintahDaerah = "";
                        invD.choosePemerintahPusat = "";
                        invD.choosePihakLain = "";
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
                          value: invD.statusPdl,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusPdl = newValue ?? invD.statusPdl;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(maxHeight: 300),
                          items: [
                            DropdownMenuItem<String>(
                              value: "3",
                              child: Text("Pilih"),
                            ),
                            ...invD.keteranganPdl.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: invD.keteranganPdl.indexOf(item) == 0
                                      ? "1"
                                      : "0",
                                  child: Text(item),
                                );
                              }).toList(),
                          ],
                        ),
                      ),
                      if(invD.statusPdl == "1")
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
                      if(invD.statusPdl == "0")
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
                      groupValue: invD.choosePihakLain,
                      onChanged: (value) {
                        setState(() {
                          invD.choosePihakLain = (value == "1") ? "1" : "";
                          invD.choosePemerintahDaerah = "";
                          invD.choosePemerintahPusat = "";
                          invD.choosePemerintahDaerahLain = "";
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
                          value: invD.statusPl,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusPl = newValue ?? invD.statusPl;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(maxHeight: 300),
                          items: [
                            DropdownMenuItem<String>(
                              value: "3",
                              child: Text("Pilih"),
                            ),
                            ...invD.keteranganPl.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: invD.keteranganPl.indexOf(item) == 0
                                      ? "1"
                                      : "0",
                                  child: Text(item),
                                );
                              }).toList(),
                          ],
                        ),
                      ),
                      if(invD.statusPl == "1")
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
                      if(invD.statusPl == "0")
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
              // Jenis Pengkerasan Jalan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jenis Pengkerasan Jalan',
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
                              controller: editController.d_jenis_pengkerasan_jln_awal,
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
                          value: invD.statusPengkerasanJalan,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusPengkerasanJalan =
                                  newValue ?? invD.statusPengkerasanJalan;
                            });
                          },
                          items: invD.keteranganPengkerasanJalan.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invD.keteranganPengkerasanJalan.indexOf(item) == 0
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
                  invD.statusPengkerasanJalan == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.d_jenis_pengkerasan_jln_akhir,
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
              // Jenis Bahan Struktur Jembatan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Jenis Bahan Struktur Jembatan',
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
                              controller: editController.d_jenis_bahan_jembatan_awal,
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
                          value: invD.statusBahanJembatan,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusBahanJembatan =
                                  newValue ?? invD.statusBahanJembatan;
                            });
                          },
                          items: invD.keteranganBahanJembatan.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invD.keteranganBahanJembatan.indexOf(item) == 0
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
                  invD.statusBahanJembatan == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.d_jenis_bahan_jembatan_akhir,
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
              // Nomor Ruas Jalan
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nomor Ruas Jalan',
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
                              controller: editController.d_nomor_ruas_jln_awal,
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
                          value: invD.statusNoRuasJalan,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusNoRuasJalan =
                                  newValue ?? invD.statusNoRuasJalan;
                            });
                          },
                          items: invD.keteranganNoRuasJalan.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invD.keteranganNoRuasJalan.indexOf(item) == 0
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
                  invD.statusNoRuasJalan == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.d_nomor_ruas_jln_akhir,
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
              // Nomor Jaringan Irigasi
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nomor Jaringan Irigasi',
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
                              controller: editController.d_nomor_jaringan_irigasi_awal,
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
                          value: invD.statusNoJaringanIrigasi,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusNoJaringanIrigasi =
                                  newValue ?? invD.statusNoJaringanIrigasi;
                            });
                          },
                          items: invD.keteranganNoJaringanIrigasi.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invD.keteranganNoJaringanIrigasi.indexOf(item) == 0
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
                  invD.statusNoJaringanIrigasi == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.d_nomor_jaringan_irigasi_akhir,
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
              // Konstruksi
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Konstruksi',
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
                              controller: editController.d_konstruksi_awal,
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
                          value: invD.statusKonstruksi,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusKonstruksi =
                                  newValue ?? invD.statusKonstruksi;
                            });
                          },
                          items: invD.keteranganKonstruksi.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invD.keteranganKonstruksi.indexOf(item) == 0
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
                  invD.statusKonstruksi == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.d_konstruksi_akhir,
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
              // Panjang
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Panjang',
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
                              controller: editController.d_panjang_awal,
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
                          value: invD.statusPanjang,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusPanjang =
                                  newValue ?? invD.statusPanjang;
                            });
                          },
                          items: invD.keteranganPanjang.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invD.keteranganPanjang.indexOf(item) == 0
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
                  invD.statusPanjang == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.d_panjang_akhir,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
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
                      value: invD.selectedPanjang,
                      onChanged: (String? newValue) {
                        setState(() {
                          invD.selectedPanjang = newValue ?? invD.selectedPanjang;
                        });
                      },
                      items: invD.keteranganSatuanPanjang.map((String item) {
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
              // Lebar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Lebar',
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
                              controller: editController.d_lebar_awal,
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
                          value: invD.statusLebar,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusLebar =
                                  newValue ?? invD.statusLebar;
                            });
                          },
                          items: invD.keteranganLebar.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invD.keteranganLebar.indexOf(item) == 0
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
                  invD.statusLebar == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.d_lebar_akhir,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
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
                      value: invD.selectedLebar,
                      onChanged: (String? newValue) {
                        setState(() {
                          invD.selectedLebar = newValue ?? invD.selectedLebar;
                        });
                      },
                      items: invD.keteranganSatuanLebar.map((String item) {
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
                              controller: editController.d_luas_awal,
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
                          value: invD.statusLuas,
                          onChanged: (String? newValue) {
                            setState(() {
                              invD.statusLuas =
                                  newValue ?? invD.statusLuas;
                            });
                          },
                          items: invD.keteranganLuas.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invD.keteranganLuas.indexOf(item) == 0
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
                  invD.statusLuas == "2"
                      ? Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: TextFormField(
                              controller: editController.d_luas_akhir,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
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
                      value: invD.selectedLuas,
                      onChanged: (String? newValue) {
                        setState(() {
                          invD.selectedLuas = newValue ?? invD.selectedLuas;
                        });
                      },
                      items: invD.keteranganSatuanLuas.map((String item) {
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
              // Luas Tanah
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Luas Tanah',
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
                        controller: editController.d_luas_tanah,
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
              // Status Tanah
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Status Tanah',
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
                      value: invD.selectedStatusTanah,
                      onChanged: (String? newValue) {
                        setState(() {
                          invD.selectedStatusTanah = newValue ?? invD.selectedStatusTanah;
                        });
                      },
                      items: invD.dropdownStatusTanah.map((String item) {
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
                      value: invD.statusGanda,
                      onChanged: (String? newValue) {
                        setState(() {
                          invD.statusGanda = newValue ?? invD.statusGanda;
                        });
                      },
                      items: invD.keteranganGanda.map((String item) {
                        return DropdownMenuItem<String>(
                          value: invD.keteranganGanda.indexOf(item) == 0
                                ? "1"
                                : "2",
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  invD.statusGanda == "1"
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
                      value: invD.dropdownAtasNama.keys
                              .contains(invD.statusAtasNama)
                          ? invD.statusAtasNama
                          : null,
                      onChanged: (String? newValue) {
                        setState(() {
                          invD.statusAtasNama =
                              newValue ?? invD.statusAtasNama;
                        });
                      },
                      items: invD.dropdownAtasNama.keys.map((String item) {
                        return DropdownMenuItem<String>(
                          value: item,
                          child: Text(invD.dropdownAtasNama[item]!),
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
                child: Row(
                  children: [
                    Expanded(
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
                            (invD.statusNoRegister == "1") ? editController.no_register_awal.text : editController.no_register_akhir.text,
                            invD.statusNoRegister,
                            editController.kategori_id_awal.text,
                            (invD.statusBarang == "1") ? editController.kategori_id_awal.text : invD.selectedKategori,
                            invD.statusBarang,
                            editController.nama_spesifikasi_awal.text,
                            (invD.statusNamaBarang == "1") ? editController.nama_spesifikasi_awal.text : editController.nama_spesifikasi_akhir.text,
                            invD.statusNamaBarang,
                            editController.jumlah_awal.text,
                            invD.selectedSatuan,
                            editController.cara_perolehan_awal.text,
                            (invD.statusPerolehan == "1")
                              ? (editController.cara_perolehan_awal.text == "Pembelian") ? "1" : 
                                (editController.cara_perolehan_awal.text == "Hibah") ? "2" : 
                                (editController.cara_perolehan_awal.text == "Barang & Jasa") ? "3" :
                                (editController.cara_perolehan_awal.text == "Hasil Inventarisasi") ? "4" : ""
                              : invD.selectedPerolehan,
                            invD.statusPerolehan,
                            editController.tgl_perolehan.text,
                            editController.tahun_perolehan.text,
                            editController.perolehan_awal.text,
                            (invD.statusNilaiPerolehan == "1") ? editController.perolehan_awal.text: editController.perolehan_akhir.text,
                            invD.statusNilaiPerolehan,
                            invD.statusAtribusi,
                            invD.chooseAtribusi,
                            editController.atribusi_nibar.text,
                            editController.atribusi_kode_barang.text,
                            editController.atribusi_kode_lokasi.text,
                            editController.atribusi_no_register.text,
                            editController.atribusi_nama_barang.text,
                            editController.atribusi_spesifikasi_barang.text,
                            editController.a_alamat_awal.text,
                            invD.statusAlamat,
                            editController.alamat_kota.text,
                            invD.selectedKecamatan,
                            invD.selectedKelurahan,
                            editController.alamat_jalan.text,
                            editController.alamat_no.text,
                            editController.alamat_rt.text,
                            editController.alamat_rw.text,
                            editController.alamat_kodepos.text,
                            invD.statusKeberadaanBarang,
                            editController.kondisi_awal.text,
                            (invD.statusKondisi == "1") ? editController.kondisi_awal.text : invD.selectedKondisi,
                            invD.statusKondisi,
                            editController.asal_usul_awal.text,
                            (invD.statusAsalUsul == "1") ? editController.asal_usul_awal.text : editController.asal_usul_akhir.text,
                            invD.statusAsalUsul,
                            invD.statusPenggunaanStatus,
                            editController.penggunaan_awal.text,
                            invD.choosePemerintahDaerah,
                            editController.penggunaan_pemda_akhir.text,
                            invD.choosePemerintahPusat,
                            invD.statusPempus,
                            editController.penggunaan_pempus_y_nm.text,
                            editController.penggunaan_pempus_y_doc.text,
                            editController.penggunaan_pempus_t_nm.text,
                            invD.choosePemerintahDaerahLain,
                            invD.statusPdl,
                            editController.penggunaan_pdl_y_nm.text,
                            editController.penggunaan_pdl_y_doc.text,
                            editController.penggunaan_pdl_t_nm.text,
                            invD.choosePihakLain,
                            invD.statusPl,
                            editController.penggunaan_pl_y_nm.text,
                            editController.penggunaan_pl_y_doc.text,
                            editController.penggunaan_pl_t_nm.text,
                            editController.d_jenis_pengkerasan_jln_awal.text,
                            (invD.statusPengkerasanJalan == "1") ? editController.d_jenis_pengkerasan_jln_awal.text : editController.d_jenis_pengkerasan_jln_akhir.text,
                            invD.statusPengkerasanJalan,
                            editController.d_jenis_bahan_jembatan_awal.text,
                            (invD.statusBahanJembatan == "1") ? editController.d_jenis_bahan_jembatan_awal.text : editController.d_jenis_bahan_jembatan_akhir.text,
                            invD.statusBahanJembatan,
                            editController.d_nomor_ruas_jln_awal.text,
                            (invD.statusNoRuasJalan == "1") ? editController.d_nomor_ruas_jln_awal.text : editController.d_nomor_ruas_jln_akhir.text,
                            invD.statusNoRuasJalan,
                            editController.d_nomor_jaringan_irigasi_awal.text,
                            (invD.statusNoJaringanIrigasi == "1") ? editController.d_nomor_jaringan_irigasi_awal.text : editController.d_nomor_jaringan_irigasi_akhir.text,
                            invD.statusNoJaringanIrigasi,
                            editController.d_konstruksi_awal.text,
                            (invD.statusKonstruksi == "1") ? editController.d_konstruksi_awal.text : editController.d_konstruksi_akhir.text,
                            invD.statusKonstruksi,
                            editController.d_panjang_awal.text,
                            (invD.statusPanjang == "1") ? editController.d_panjang_awal.text : editController.d_panjang_akhir.text,
                            invD.statusPanjang,
                            invD.selectedPanjang,
                            editController.d_lebar_awal.text,
                            (invD.statusLebar == "1") ? editController.d_lebar_awal.text : editController.d_lebar_akhir.text,
                            invD.statusLebar,
                            invD.selectedLebar,
                            editController.d_luas_awal.text,
                            (invD.statusLuas == "1") ? editController.d_luas_awal.text : editController.d_luas_akhir.text,
                            invD.statusLuas,
                            invD.selectedLuas,
                            editController.d_luas_tanah.text,
                            invD.selectedStatusTanah,
                            invD.statusGanda,
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
                            invD.statusAtasNama,
                            editController.lat.text,
                            editController.long.text,
                            editController.lainnya.text,
                            editController.keterangan.text,
                            _petugasList
                          ];
                    
                          if(invD.statusInventaris == "0"){
                            editController.insertInventarisD(id, data);
                          } else {
                            editController.updateInventarisD(editController.kib_id.text, data);
                          }
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.red[800],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Center(
                            child: Text(
                          'Reset',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 2,
                          ),
                        )),
                      ),
                      onTap: () {
                        _resetForm();
                      },
                    ),
                  ],
                ),
              ),
            ],
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

  void _resetForm() {
    setState(() {
      final data         = penetapanController.penetapanListById[0];
      final kuasa        = kuasaController.kuasaList[0];
      final filteredList = addressController.kecamatanList
        .where((kecamatan) => kecamatan['kecamatan_kd'].toString() == data['alamat_kecamatan'].toString());

      invD.statusInventaris                                   = data['status_inventaris'].toString();
      editController.kib_id.text                              = data['kib_id'].toString();
      editController.penetapan_id.text                        = data['penetapan_id'].toString();
      editController.departemen_id.text                       = data['departemen_id'].toString();

      editController.tgl_inventaris.text                      = (invD.statusInventaris == "0") ? DateFormat('dd-MM-yyyy').format(now) : data['tgl_inventaris_formatted'].toString();
      editController.skpd.text                                = data['departemen_kd'].toString();
      editController.skpd_uraian.text                         = data['departemen_nm'].toString();
      editController.no_register_awal.text                    = (invD.statusInventaris == "0") ? data['no_register'].toString() : data['no_register_awal'].toString();
      editController.no_register_akhir.text                   = (invD.statusInventaris == "0") ? data['no_register'].toString() : data['no_register_akhir'].toString();
      invD.statusNoRegister                                   = data['no_register_status']      != "" ? data['no_register_status'].toString() : "1";
      editController.barang.text                              = data['kategori_kd'].toString() + ' - ' + data['kategori_nm'].toString();
      editController.kategori_id_awal.text                    = (invD.statusInventaris == "0") ? data['kategori_id'].toString() : data['kategori_id_awal'].toString();
      invD.selectedKategori                                   = (invD.statusInventaris == "0") ? data['kategori_id'].toString() : data['kategori_id_akhir'].toString();
      invD.statusBarang                                       = data['kategori_id_status']      != "" ? data['kategori_id_status'].toString() : "1";
      editController.nama_spesifikasi_awal.text               = (invD.statusInventaris == "0") ? "" : data['nama_spesifikasi_awal'].toString();
      editController.nama_spesifikasi_akhir.text              = (invD.statusInventaris == "0") ? "" : data['nama_spesifikasi_akhir'].toString();
      invD.statusNamaBarang                                   = data['nama_spesifikasi_status'] != "" ? data['nama_spesifikasi_status'].toString() : "1";
      editController.jumlah_awal.text                         = data['jumlah'].toString();
      invD.selectedSatuan                                     = (invD.statusInventaris == "0") ? (data['satuan_awal'] != "") ? data['satuan_awal'].toString() : "" : (data['satuan_akhir'] != "") ? data['satuan_akhir'].toString() : "";
      editController.cara_perolehan_awal.text                 = (invD.statusInventaris == "0") ? data['cara_perolehan'].toString() : data['cara_perolehan_awal'].toString();
      invD.statusPerolehan                                    = data['cara_perolehan_status']   != "" ? data['cara_perolehan_status'].toString() : "1";

      String caraPerolehan = (invD.statusInventaris == "0") ? data['cara_perolehan'].toString() : data['cara_perolehan_akhir'].toString();
      if (caraPerolehan == "Pembelian" || caraPerolehan == "1" || caraPerolehan == "") {
        invD.selectedPerolehan = "1";
      } else if (caraPerolehan == "Hibah" || caraPerolehan == "2") {
        invD.selectedPerolehan = "2";
      } else if (caraPerolehan == "Barang & Jasa" || caraPerolehan == "3") {
        invD.selectedPerolehan = "3";
      } else if (caraPerolehan == "Hasil Inventarisasi" || caraPerolehan == "4") {
        invD.selectedPerolehan = "4";
      }
      
      editController.tgl_perolehan.text                       = (invD.statusInventaris == "0") ? data['tgl_perolehan_penetapan'].toString() : data['tgl_perolehan_inventaris'].toString();
      editController.tahun_perolehan.text                     = (invD.statusInventaris == "0") ? data['th_beli'].toString() : data['tahun_perolehan'].toString();
      editController.perolehan_awal.text                      = (invD.statusInventaris == "0") ? data['perolehan_formatted'].toString() : data['perolehan_awal_formatted'].toString();
      editController.perolehan_akhir.text                     = (invD.statusInventaris == "0") ? data['perolehan_formatted'].toString() : data['perolehan_akhir_formatted'].toString();
      invD.statusNilaiPerolehan                               = data['perolehan_status'] != "" ? data['perolehan_status'].toString() : "1";
      invD.statusAtribusi                                     = data['atribusi_biaya']   != "" ? data['atribusi_biaya'].toString() : "0";
      invD.chooseAtribusi                                     = data['atribusi_status']  != "" ? data['atribusi_status'].toString() : "0";
      editController.atribusi_nibar.text                      = (invD.statusInventaris == "0") ? "" : data['atribusi_nibar'].toString();
      editController.atribusi_kode_barang.text                = (invD.statusInventaris == "0") ? "" : data['atribusi_kode_barang'].toString();
      editController.atribusi_kode_lokasi.text                = (invD.statusInventaris == "0") ? "" : data['atribusi_kode_lokasi'].toString();
      editController.atribusi_no_register.text                = (invD.statusInventaris == "0") ? "" : data['atribusi_no_register'].toString();
      editController.atribusi_nama_barang.text                = (invD.statusInventaris == "0") ? "" : data['atribusi_nama_barang'].toString();
      editController.atribusi_spesifikasi_barang.text         = (invD.statusInventaris == "0") ? "" : data['atribusi_spesifikasi_barang'].toString();
      editController.a_alamat_awal.text                       = data['d_lokasi'].toString();
      invD.statusAlamat                                       = data['a_alamat_status']  != "" ? data['a_alamat_status'].toString() : "1";
      editController.alamat_kota.text                         = data['alamat_kota']      != "" ? data['alamat_kota'].toString() : "KOTA BOGOR";
      invD.selectedKecamatan                                  = data['alamat_kecamatan'].toString();
      
      if (filteredList.isNotEmpty) {
        final Map<String, dynamic> selectedKecamatan = filteredList.first;
        int idKecamatan = selectedKecamatan['id'];
        invD.selectedKelurahan = (idKecamatan.toString() == "1") ? "000" : data['alamat_kelurahan'].toString();
      }

      editController.alamat_jalan.text                        = data['alamat_jalan'].toString();
      editController.alamat_no.text                           = data['alamat_no'].toString();
      editController.alamat_rt.text                           = data['alamat_rt'].toString();
      editController.alamat_rw.text                           = data['alamat_rw'].toString();
      editController.alamat_kodepos.text                      = data['alamat_kodepos'].toString();
      invD.statusKeberadaanBarang                             = data['keberadaan_barang_status']        != "" ? data['keberadaan_barang_status'].toString() : "1";
      editController.kondisi_awal.text                        = (invD.statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_awal'].toString();
      invD.selectedKondisi                                    = (invD.statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_akhir'].toString();
      invD.statusKondisi                                      = data['kondisi_status']                  != "" ? data['kondisi_status'].toString() : "1";
      editController.asal_usul_awal.text                      = (invD.statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_awal'].toString();
      editController.asal_usul_akhir.text                     = (invD.statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_akhir'].toString();
      invD.statusAsalUsul                                     = data['asal_usul_status']                != "" ? data['asal_usul_status'].toString() : "1";
      invD.statusPenggunaanStatus                             = data['penggunaan_status']               != "" ? data['penggunaan_status'].toString() : "1";
      editController.penggunaan_awal.text                     = (invD.statusInventaris == "0") ? data['a_penggunaan'].toString() : data['penggunaan_awal'].toString();
      invD.choosePemerintahDaerah                             = (invD.statusInventaris == "0") ? "1" : data['penggunaan_pemda_status'].toString();
      editController.penggunaan_pemda_akhir.text              = (invD.statusInventaris == "0") ? kuasa['nama'].toString() : data['penggunaan_pemda_akhir'].toString();
      invD.choosePemerintahPusat                              = data['penggunaan_pempus_status'].toString();
      invD.statusPempus                                       = data['penggunaan_pempus_yt']            != "" ? data['penggunaan_pempus_yt'].toString() : "3";
      editController.penggunaan_pempus_y_nm.text              = data['penggunaan_pempus_y_nm'].toString();
      editController.penggunaan_pempus_y_doc.text             = data['penggunaan_pempus_y_doc'].toString();
      editController.penggunaan_pempus_t_nm.text              = data['penggunaan_pempus_t_nm'].toString();
      invD.choosePemerintahDaerahLain                         = data['penggunaan_pdl_status'].toString();
      invD.statusPdl                                          = data['penggunaan_pdl_yt']               != "" ? data['penggunaan_pdl_yt'].toString() : "3";
      editController.penggunaan_pdl_y_nm.text                 = data['penggunaan_pdl_y_nm'].toString();
      editController.penggunaan_pdl_y_doc.text                = data['penggunaan_pdl_y_doc'].toString();
      editController.penggunaan_pdl_t_nm.text                 = data['penggunaan_pdl_t_nm'].toString();
      invD.choosePihakLain                                    = data['penggunaan_pl_status'].toString();
      invD.statusPl                                           = data['penggunaan_pl_yt']                != "" ? data['penggunaan_pl_yt'].toString() : "3";
      editController.penggunaan_pl_y_nm.text                  = data['penggunaan_pl_y_nm'].toString();
      editController.penggunaan_pl_y_doc.text                 = data['penggunaan_pl_y_doc'].toString();
      editController.penggunaan_pl_t_nm.text                  = data['penggunaan_pl_t_nm'].toString();
      editController.d_jenis_pengkerasan_jln_awal.text        = data['d_jenis_pengkerasan_jln_awal']    != "" ? data['d_jenis_pengkerasan_jln_awal'].toString() : "";
      editController.d_jenis_pengkerasan_jln_akhir.text       = data['d_jenis_pengkerasan_jln_akhir']   != "" ? data['d_jenis_pengkerasan_jln_akhir'].toString() : "";
      invD.statusPengkerasanJalan                             = data['d_jenis_pengkerasan_jln_status']  != "" ? data['d_jenis_pengkerasan_jln_status'].toString() : "1";
      editController.d_jenis_bahan_jembatan_awal.text         = data['d_jenis_bahan_jembatan_awal']     != "" ? data['d_jenis_bahan_jembatan_awal'].toString() : "";
      editController.d_jenis_bahan_jembatan_akhir.text        = data['d_jenis_bahan_jembatan_akhir']    != "" ? data['d_jenis_bahan_jembatan_akhir'].toString() : "";
      invD.statusBahanJembatan                                = data['d_jenis_bahan_jembatan_status']   != "" ? data['d_jenis_bahan_jembatan_status'].toString() : "1";
      editController.d_nomor_ruas_jln_awal.text               = data['d_nomor_ruas_jln_awal']           != "" ? data['d_nomor_ruas_jln_awal'].toString() : "";
      editController.d_nomor_ruas_jln_akhir.text              = data['d_nomor_ruas_jln_akhir']          != "" ? data['d_nomor_ruas_jln_akhir'].toString() : "";
      invD.statusNoRuasJalan                                  = data['d_nomor_ruas_jln_status']         != "" ? data['d_nomor_ruas_jln_status'].toString() : "1";
      editController.d_nomor_jaringan_irigasi_awal.text       = data['d_nomor_jaringan_irigasi_awal']   != "" ? data['d_nomor_jaringan_irigasi_awal'].toString() : "";
      editController.d_nomor_jaringan_irigasi_akhir.text      = data['d_nomor_jaringan_irigasi_awal']   != "" ? data['d_nomor_jaringan_irigasi_awal'].toString() : "";
      invD.statusNoJaringanIrigasi                            = data['d_nomor_jaringan_irigasi_status'] != "" ? data['d_nomor_jaringan_irigasi_status'].toString() : "1";
      editController.d_konstruksi_awal.text                   = (invD.statusInventaris == "0") ? data['d_konstruksi'] : data['d_konstruksi_awal'].toString();
      editController.d_konstruksi_akhir.text                  = (invD.statusInventaris == "0") ? data['d_konstruksi'] : data['d_konstruksi_akhir'].toString();
      invD.statusKonstruksi                                   = data['d_konstruksi_status']             != "" ? data['d_konstruksi_status'].toString() : "1";
      editController.d_panjang_awal.text                      = (invD.statusInventaris == "0") ? data['d_panjang'] : data['d_panjang_awal'].toString();
      editController.d_panjang_akhir.text                     = (invD.statusInventaris == "0") ? data['d_panjang'] : data['d_panjang_akhir'].toString();
      invD.statusPanjang                                      = data['d_panjang_status']                != "" ? data['d_panjang_status'].toString() : "1";
      invD.selectedPanjang                                    = (invD.statusInventaris == "0") ? "Km" : data['d_panjang_satuan'].toString();
      editController.d_lebar_awal.text                        = (invD.statusInventaris == "0") ? data['d_lebar'] : data['d_lebar_awal'].toString();
      editController.d_lebar_akhir.text                       = (invD.statusInventaris == "0") ? data['d_lebar'] : data['d_lebar_akhir'].toString();
      invD.statusLebar                                        = data['d_lebar_status']                  != "" ? data['d_lebar_status'].toString() : "1";
      invD.selectedLebar                                      = (invD.statusInventaris == "0") ? "M" : data['d_lebar_satuan'].toString();
      editController.d_luas_awal.text                         = (invD.statusInventaris == "0") ? data['d_luas'] : data['d_luas_awal'].toString();
      editController.d_luas_akhir.text                        = (invD.statusInventaris == "0") ? data['d_luas'] : data['d_luas_akhir'].toString();
      invD.statusLuas                                         = data['d_luas_status']                   != "" ? data['d_luas_status'].toString() : "1";
      invD.selectedLuas                                       = (invD.statusInventaris == "0") ? "M2" : data['d_luas_satuan'].toString();
      editController.d_luas_tanah.text                        = data['d_luas_tanah']                    != "" ? data['d_luas_tanah'].toString() : "";
      invD.selectedStatusTanah                                = (invD.statusInventaris == "0") ? "Hak Milik" : data['d_status_tanah_inventaris'].toString();
      invD.statusGanda                                        = data['tercatat_ganda']                  != "" ? data['tercatat_ganda'].toString() : "2";
      editController.tercatat_ganda_nibar.text                = data['tercatat_ganda_nibar'].toString();
      editController.tercatat_ganda_no_register.text          = data['tercatat_ganda_no_register'].toString();
      editController.tercatat_ganda_kode_barang.text          = data['tercatat_ganda_kode_barang'].toString();
      editController.tercatat_ganda_nama_barang.text          = data['tercatat_ganda_nama_barang'].toString();
      editController.tercatat_ganda_spesifikasi_barang.text   = data['tercatat_ganda_spesifikasi_barang'].toString();
      editController.tercatat_ganda_luas.text                 = data['tercatat_ganda_luas'].toString();
      editController.tercatat_ganda_satuan.text               = data['tercatat_ganda_satuan'].toString();
      editController.tercatat_ganda_perolehan.text            = data['tercatat_ganda_perolehan'].toString();
      editController.tercatat_ganda_tanggal_perolehan.text    = data['tercatat_ganda_tanggal_perolehan'].toString();
      editController.tercatat_ganda_kuasa_pengguna.text       = data['tercatat_ganda_kuasa_pengguna'].toString();
      invD.statusAtasNama                                     = data['pemilik_id']                      != "" ? data['pemilik_id'].toString() : "1";
      editController.lat.text                                 = (invD.statusInventaris == "0") ? data['lat_penetapan'].toString() : data['lat_inventaris'].toString();
      editController.long.text                                = (invD.statusInventaris == "0") ? data['long_penetapan'].toString() : data['long_inventaris'].toString();
      editController.lainnya.text                             = data['lainnya'].toString();
      editController.keterangan.text                          = (invD.statusInventaris == "0") ? data['keterangan_penetapan'].toString() : data['keterangan_inventaris'].toString();
      editController.file_nm.text                             = (invD.statusInventaris == "0") ? data['file_penetapan'].toString() : data['file_inventaris'].toString();
      _petugasList                                            = data['petugas']                         != null && data['petugas'].isNotEmpty ? List<String>.from(data['petugas']) : [""];
    
      ever(locationController.latitude, (_) {
        editController.lat.text = locationController.latitude.value;
      });

      ever(locationController.longitude, (_) {
        editController.long.text = locationController.longitude.value;
      });
    });
  }
}
