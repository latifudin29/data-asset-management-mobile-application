import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:kib_application/constans/inventoryVariablesB.dart';
import 'package:kib_application/controllers/addressController.dart';
import 'package:kib_application/controllers/appointmentController.dart';
import 'package:kib_application/controllers/categoryController.dart';
import 'package:kib_application/controllers/inventoryBController.dart';
import 'package:kib_application/controllers/unitController.dart';
import 'package:kib_application/controllers/roomController.dart';
import 'package:kib_application/widgets/formPetugas.dart';

class EditInventoryBScreen extends StatefulWidget {
  const EditInventoryBScreen({super.key});

  @override
  State<EditInventoryBScreen> createState() => _EditInventoryBScreenState();
}

class _EditInventoryBScreenState extends State<EditInventoryBScreen> {
  final penetapanController = Get.put(AppointmentController());
  final editController      = Get.put(InventoryBController());
  final kategoriController  = Get.put(CategoryController());
  final satuanController    = Get.put(UnitController());
  final ruangController     = Get.put(RoomController());
  final addressController   = Get.put(AddressController());
  final invB                = Get.put(InventoryVariablesB());

  List<dynamic> _petugasList = [''];

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    final data         = penetapanController.penetapanListById[0];
    final filteredList = addressController.kecamatanList
      .where((kecamatan) => kecamatan['kecamatan_kd'].toString() == data['alamat_kecamatan'].toString());   
    final dataRuang = ruangController.ruangList
      .where((ruang) => ruang['ruang_id'].toString() == data['b_kd_ruang'].toString());     
    
    invB.statusInventaris             = data['status_inventaris'].toString();
    editController.kib_id.text        = data['kib_id'].toString();
    editController.penetapan_id.text  = data['penetapan_id'].toString();
    editController.departemen_id.text = data['departemen_id'].toString();

    invB.statusNoRegister     = data['no_register_status']      != "" ? data['no_register_status'].toString() : "1";
    invB.statusBarang         = data['kategori_id_status']      != "" ? data['kategori_id_status'].toString() : "1";
    invB.statusNamaBarang     = data['nama_spesifikasi_status'] != "" ? data['nama_spesifikasi_status'].toString() : "1";
    invB.statusPerolehan      = data['cara_perolehan_status']   != "" ? data['cara_perolehan_status'].toString() : "1";
    invB.statusNilaiPerolehan = data['perolehan_status']        != "" ? data['perolehan_status'].toString() : "1";
    invB.statusAlamat         = data['a_alamat_status']         != "" ? data['a_alamat_status'].toString() : "1";
    invB.statusKondisi        = data['kondisi_status']          != "" ? data['kondisi_status'].toString() : "1";
    invB.statusAsalUsul       = data['asal_usul_status']        != "" ? data['asal_usul_status'].toString() : "1";
    invB.statusMerk           = data['b_merk_status']           != "" ? data['b_merk_status'].toString() : "1";
    invB.statusCC             = data['b_cc_status']             != "" ? data['b_cc_status'].toString() : "1";
    invB.statusNoPolisi       = data['b_nomor_polisi_status']   != "" ? data['b_nomor_polisi_status'].toString() : "1";
    invB.statusNoRangka       = data['b_nomor_rangka_status']   != "" ? data['b_nomor_rangka_status'].toString() : "1";
    invB.statusNoMesin        = data['b_nomor_mesin_status']    != "" ? data['b_nomor_mesin_status'].toString() : "1";
    invB.statusNoBPKB         = data['b_nomor_bpkb_status']     != "" ? data['b_nomor_bpkb_status'].toString() : "1";
    invB.statusBahan          = data['b_bahan_status']          != "" ? data['b_bahan_status'].toString() : "1";
    invB.statusNoPabrik       = data['b_nomor_pabrik_status']   != "" ? data['b_nomor_pabrik_status'].toString() : "1";
    invB.statusKartuRuangan   = data['kartu_inv_status']        != "" ? data['kartu_inv_status'].toString() : "1";
    
    invB.statusAtribusi         = data['atribusi_status']                      != "" ? data['atribusi_status'].toString() : "0";
    invB.statusKeberadaanBarang = data['keberadaan_barang_status']             != "" ? data['keberadaan_barang_status'].toString() : "1";
    invB.statusStatus           = data['penggunaan_status']                    != "" ? data['penggunaan_status'].toString() : "1";
    invB.statusAtasNama         = data['pemilik_id']                           != "" ? data['pemilik_id'].toString() : "1";
    invB.statusNamaPemakai      = data['penggunaan_pemda_nama_pemakai_status'] != "" ? data['penggunaan_pemda_nama_pemakai_status'].toString() : "1";
    invB.statusBast             = data['penggunaan_pemda_bast_pemakaian']      != "" ? data['penggunaan_pemda_bast_pemakaian'].toString() : "1";
    invB.statusGanda            = data['tercatat_ganda']                       != "" ? data['tercatat_ganda'].toString() : "2";

    invB.chooseAtribusi   = data['atribusi_status'] != "" ? data['atribusi_status'].toString() : "0";
    
    invB.choosePemerintahDaerah     = (invB.statusInventaris == "0") ? "1" : data['penggunaan_pemda_status'].toString();
    invB.choosePemerintahPusat      = data['penggunaan_pempus_status'].toString();
    invB.choosePemerintahDaerahLain = data['penggunaan_pdl_status'].toString();
    invB.choosePihakLain            = data['penggunaan_pl_status'].toString();

    invB.statusPempus = data['penggunaan_pempus_yt'] != "" ? data['penggunaan_pempus_yt'].toString() : "3";
    invB.statusPdl    = data['penggunaan_pdl_yt'] != "" ? data['penggunaan_pdl_yt'].toString() : "3";
    invB.statusPl     = data['penggunaan_pl_yt'] != "" ? data['penggunaan_pl_yt'].toString() : "3";

    String caraPerolehan = (invB.statusInventaris == "0") ? data['cara_perolehan'].toString() : data['cara_perolehan_akhir'].toString();
    if (caraPerolehan == "Pembelian" || caraPerolehan == "1" || caraPerolehan == "") {
      invB.selectedPerolehan = "1";
    } else if (caraPerolehan == "Hibah" || caraPerolehan == "2") {
      invB.selectedPerolehan = "2";
    } else if (caraPerolehan == "Barang & Jasa" || caraPerolehan == "3") {
      invB.selectedPerolehan = "3";
    } else if (caraPerolehan == "Hasil Inventarisasi" || caraPerolehan == "4") {
      invB.selectedPerolehan = "4";
    }

    invB.selectedKeberadaanBarang = data['keberadaan_barang_akhir'] != "" ? data['keberadaan_barang_akhir'].toString() : "1";

    editController.tgl_inventaris.text                      = (invB.statusInventaris == "0") ? DateFormat('dd-MM-yyyy').format(now) : data['tgl_inventaris_formatted'].toString();
    editController.skpd.text                                = data['departemen_kd'].toString();
    editController.skpd_uraian.text                         = data['departemen_nm'].toString();
    editController.barang.text                              = data['kategori_kd'].toString() + ' - ' + data['kategori_nm'].toString();
    editController.no_register_awal.text                    = (invB.statusInventaris == "0") ? data['no_register'].toString() : data['no_register_awal'].toString();
    editController.no_register_akhir.text                   = (invB.statusInventaris == "0") ? data['no_register'].toString() : data['no_register_akhir'].toString();
    editController.kategori_id_awal.text                    = (invB.statusInventaris == "0") ? data['kategori_id'].toString() : data['kategori_id_awal'].toString();
    invB.selectedKategori                                   = (invB.statusInventaris == "0") ? data['kategori_id'].toString() : data['kategori_id_akhir'].toString();
    editController.nama_spesifikasi_awal.text               = data['nama_spesifikasi_awal'].toString();
    editController.nama_spesifikasi_akhir.text              = data['nama_spesifikasi_akhir'].toString();
    editController.jumlah_awal.text                         = (invB.statusInventaris == "0") ? data['jumlah'].toString() : data['jumlah_awal'].toString();
    invB.selectedSatuan                                     = (invB.statusInventaris == "0") ? (data['satuan_awal'] != "") ? data['satuan_awal'].toString() : "" : (data['satuan_akhir'] != "") ? data['satuan_akhir'].toString() : "";
    editController.cara_perolehan_awal.text                 = (invB.statusInventaris == "0") ? data['cara_perolehan'].toString() : data['cara_perolehan_awal'].toString();
    editController.tgl_perolehan.text                       = (invB.statusInventaris == "0") ? data['tgl_perolehan_penetapan'].toString() : data['tgl_perolehan_inventaris'].toString();
    editController.tahun_perolehan.text                     = (invB.statusInventaris == "0") ? data['th_beli'].toString() : data['tahun_perolehan'].toString();
    editController.perolehan_awal.text                      = (invB.statusInventaris == "0") ? data['perolehan_formatted'].toString() : data['perolehan_awal_formatted'].toString();
    editController.perolehan_akhir.text                     = (invB.statusInventaris == "0") ? data['perolehan_formatted'].toString() : data['perolehan_akhir_formatted'].toString();
    editController.atribusi_nibar.text                      = data['atribusi_nibar'].toString();
    editController.atribusi_kode_barang.text                = data['atribusi_kode_barang'].toString();
    editController.atribusi_kode_lokasi.text                = data['atribusi_kode_lokasi'].toString();
    editController.atribusi_no_register.text                = data['atribusi_no_register'].toString();
    editController.atribusi_nama_barang.text                = data['atribusi_nama_barang'].toString();
    editController.atribusi_spesifikasi_barang.text         = data['atribusi_spesifikasi_barang'].toString();
    editController.a_alamat_awal.text                       = (invB.statusInventaris == "0") ? data['a_alamat'].toString() : data['a_alamat_awal'].toString();
    editController.alamat_kota.text                         = data['alamat_kota'] != "" ? data['alamat_kota'].toString() : "KOTA BOGOR";
    invB.selectedKecamatan                                  = data['alamat_kecamatan'].toString();
    if (filteredList.isNotEmpty) {
      final Map<String, dynamic> selectedKecamatan = filteredList.first;
      int idKecamatan = selectedKecamatan['id'];
      invB.selectedKelurahan = (idKecamatan.toString() == "1") ? "000" : data['alamat_kelurahan'].toString();
    }
    editController.alamat_jalan.text                        = data['alamat_jalan'].toString();
    editController.alamat_no.text                           = data['alamat_no'].toString();
    editController.alamat_rt.text                           = data['alamat_rt'].toString();
    editController.alamat_rw.text                           = data['alamat_rw'].toString();
    editController.alamat_kodepos.text                      = data['alamat_kodepos'].toString();
    editController.b_merk_awal.text                         = (invB.statusInventaris == "0") ? data['b_merk'].toString() : data['b_merk_awal'].toString();
    editController.b_merk_akhir.text                        = (invB.statusInventaris == "0") ? data['b_merk'] : data['b_merk_akhir'].toString();
    editController.b_cc_awal.text                           = (invB.statusInventaris == "0") ? data['b_cc'].toString() : data['b_cc_awal'].toString();
    editController.b_cc_akhir.text                          = (invB.statusInventaris == "0") ? data['b_cc'].toString() : data['b_cc_akhir'].toString();
    editController.b_nomor_polisi_awal.text                 = (invB.statusInventaris == "0") ? data['b_nomor_polisi'].toString() : data['b_nomor_polisi_awal'].toString();
    editController.b_nomor_polisi_akhir.text                = (invB.statusInventaris == "0") ? data['b_nomor_polisi'].toString() : data['b_nomor_polisi_akhir'].toString();
    editController.b_nomor_rangka_awal.text                 = (invB.statusInventaris == "0") ? data['b_nomor_rangka'].toString() : data['b_nomor_rangka_awal'].toString();
    editController.b_nomor_rangka_akhir.text                = (invB.statusInventaris == "0") ? data['b_nomor_rangka'].toString() : data['b_nomor_rangka_akhir'].toString();
    editController.b_nomor_mesin_awal.text                  = (invB.statusInventaris == "0") ? data['b_nomor_mesin'].toString() : data['b_nomor_mesin_awal'].toString();
    editController.b_nomor_mesin_akhir.text                 = (invB.statusInventaris == "0") ? data['b_nomor_mesin'].toString() : data['b_nomor_mesin_akhir'].toString();
    editController.b_nomor_bpkb_awal.text                   = (invB.statusInventaris == "0") ? data['b_nomor_bpkb'].toString() : data['b_nomor_bpkb_awal'].toString();
    editController.b_nomor_bpkb_akhir.text                  = (invB.statusInventaris == "0") ? data['b_nomor_bpkb'].toString() : data['b_nomor_bpkb_akhir'].toString();
    editController.b_bahan_awal.text                        = (invB.statusInventaris == "0") ? data['b_bahan'].toString() : data['b_bahan_awal'].toString();
    editController.b_bahan_akhir.text                       = (invB.statusInventaris == "0") ? data['b_bahan'].toString() : data['b_bahan_akhir'].toString();
    editController.b_nomor_pabrik_awal.text                 = (invB.statusInventaris == "0") ? data['b_nomor_pabrik'].toString() : data['b_nomor_pabrik_awal'].toString();
    editController.b_nomor_pabrik_akhir.text                = (invB.statusInventaris == "0") ? data['b_nomor_pabrik'].toString() : data['b_nomor_pabrik_akhir'].toString();
    if (dataRuang.isNotEmpty) {
      final Map<String, dynamic> selectedRuang = dataRuang.first;
      String namaRuang = selectedRuang['ruang_nm'];
      editController.kartu_inv_awal.text = (invB.statusInventaris == "0") ? namaRuang : data['kartu_inv_awal'].toString();
      invB.selectedKartuRuangan = (invB.statusInventaris == "0") ? namaRuang : data['kartu_inv_akhir'].toString();
    }
    invB.statusQRBarang                                     = data['barcode_barang']  != "" ? data['barcode_barang'].toString() : "0";
    invB.statusQRRuangan                                    = data['barcode_ruangan'] != "" ? data['barcode_ruangan'].toString() : "0";
    editController.kondisi_awal.text                        = (invB.statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_awal'].toString();
    invB.selectedKondisi                                    = (invB.statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_akhir'].toString();
    editController.asal_usul_awal.text                      = (invB.statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_awal'].toString();
    editController.asal_usul_akhir.text                     = (invB.statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_akhir'].toString();
    editController.penggunaan_awal.text                     = (invB.statusInventaris == "0") ? data['a_penggunaan'].toString() : data['penggunaan_awal'].toString();
    editController.penggunaan_pemda_akhir.text              = data['penggunaan_pemda_akhir'].toString();
    editController.penggunaan_pemda_nama_pemakai.text       = data['penggunaan_pemda_nama_pemakai'].toString();
    editController.penggunaan_pemda_nama_pemakai_akhir.text = data['penggunaan_pemda_nama_pemakai_akhir'].toString();
    editController.penggunaan_pemda_status_pemakai.text     = data['penggunaan_pemda_status_pemakai'].toString();
    editController.penggunaan_pempus_y_nm.text              = data['penggunaan_pempus_y_nm'].toString();
    editController.penggunaan_pempus_y_doc.text             = data['penggunaan_pempus_y_doc'].toString();
    editController.penggunaan_pempus_t_nm.text              = data['penggunaan_pempus_t_nm'].toString();
    editController.penggunaan_pdl_y_nm.text                 = data['penggunaan_pdl_y_nm'].toString();
    editController.penggunaan_pdl_y_doc.text                = data['penggunaan_pdl_y_doc'].toString();
    editController.penggunaan_pdl_t_nm.text                 = data['penggunaan_pdl_t_nm'].toString();
    editController.penggunaan_pl_y_nm.text                  = data['penggunaan_pl_y_nm'].toString();
    editController.penggunaan_pl_y_doc.text                 = data['penggunaan_pl_y_doc'].toString();
    editController.penggunaan_pl_t_nm.text                  = data['penggunaan_pl_t_nm'].toString();
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
    editController.lainnya.text                             = data['lainnya'].toString();
    editController.keterangan.text                          = (invB.statusInventaris == "0") ? data['keterangan_penetapan'].toString() : data['keterangan_inventaris'].toString();
    editController.file_nm.text                             = data['file_nm'].toString();
    _petugasList                                            = data['petugas']         != null && data['petugas'].isNotEmpty ? List<String>.from(data['petugas']) : [""];
    editController.tahun.text                               = (invB.statusInventaris == "0") ? now.year.toString() : data['tahun'].toString();
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
                          value: invB.statusNoRegister,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusNoRegister = newValue ?? invB.statusNoRegister;
                            });
                          },
                          items: invB.keteranganNoRegister.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganNoRegister.indexOf(item) == 0
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
                  invB.statusNoRegister == "2"
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
                          value: invB.statusBarang,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusBarang = newValue ?? invB.statusBarang;
                            });
                          },
                          items: invB.keteranganBarang.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganBarang.indexOf(item) == 0
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
                  invB.statusBarang == "2"
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
                                invB.selectedKategori = id;
                                print(invB.selectedKategori);
                              });
                            }
                          },
                          selectedItem: invB.selectedKategori != ""
                            ? kategoriController.kategoriList
                                .where((item) => item['id'].toString() == invB.selectedKategori)
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
                          value: invB.statusNamaBarang,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusNamaBarang = newValue ?? invB.statusNamaBarang;
                            });
                          },
                          items: invB.keteranganNamaBarang.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganNamaBarang.indexOf(item) == 0
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
                  invB.statusNamaBarang == "2"
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
                  DropdownSearch<String>(
                    popupProps: PopupProps.menu(
                      showSelectedItems: true,
                      showSearchBox: true,
                    ),
                    items: [
                      "Pilih satuan",
                      ...satuanController.satuanList.map<String>((Map<String, dynamic> item) {
                        return item['satuan_nm'].toString();
                      }).toList(),
                    ],
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        invB.selectedSatuan = newValue ?? invB.selectedSatuan;
                      });
                    },
                    selectedItem: invB.selectedSatuan != "" ? invB.selectedSatuan : "Pilih satuan",
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
                            value: invB.statusPerolehan,
                            onChanged: (String? newValue) {
                              setState(() {
                                invB.statusPerolehan =
                                    newValue ?? invB.statusPerolehan;
                              });
                            },
                            items: invB.keteranganPerolehan.map((String item) {
                              return DropdownMenuItem<String>(
                                value:
                                    invB.keteranganPerolehan.indexOf(item) == 0
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
                    invB.statusPerolehan == "2"
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
                              value: invB.dropdownPerolehan.keys
                                      .contains(invB.selectedPerolehan)
                                  ? invB.selectedPerolehan
                                  : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  invB.selectedPerolehan = newValue ?? invB.selectedPerolehan;
                                });
                              },
                              items: invB.dropdownPerolehan.entries.map((entry) {
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
                          value: invB.statusNilaiPerolehan,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusNilaiPerolehan =
                                  newValue ?? invB.statusNilaiPerolehan;
                            });
                          },
                          items: invB.keteranganNilaiPerolehan.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganNilaiPerolehan.indexOf(item) == 0
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
                  invB.statusNilaiPerolehan == "2"
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
                      value: invB.statusAtribusi,
                      onChanged: (String? newValue) {
                        setState(() {
                          invB.statusAtribusi = newValue ?? invB.statusAtribusi;
                        });
                      },
                      items: invB.keteranganAtribusi.map((String item) {
                        return DropdownMenuItem<String>(
                          value: invB.keteranganAtribusi.indexOf(item) == 0 ? "1" : "0",
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  invB.statusAtribusi == "1"
                      ? Column(
                          children: [
                            RadioListTile(
                              title:
                                  Text("Tidak diketahui data awal/induknya"),
                              value: "0",
                              groupValue: invB.chooseAtribusi,
                              onChanged: (value) {
                                setState(() {
                                  invB.chooseAtribusi = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text(
                                  "Ya, Diketahui data awal/Induknya dan sebutkan data barang awal/induknya"),
                              value: "1",
                              groupValue: invB.chooseAtribusi,
                              onChanged: (value) {
                                setState(() {
                                  invB.chooseAtribusi = value.toString();
                                });
                              },
                            ),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(height: 10),
                  invB.chooseAtribusi == "1" 
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
                          value: invB.statusAlamat,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusAlamat =
                                  newValue ?? invB.statusAlamat;
                            });
                          },
                          items: invB.keteranganAlamat.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganAlamat.indexOf(item) == 0
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
                  invB.statusAlamat == "2"
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
                                value: invB.selectedKecamatan != "" ? invB.selectedKecamatan : "",
                                onChanged: (String? newValue) async {
                                  setState(() {
                                    invB.selectedKecamatan = newValue ?? invB.selectedKecamatan;
                                  });

                                  final filteredList = addressController.kecamatanList
                                      .where((kecamatan) => kecamatan['kecamatan_kd'].toString() == newValue);

                                  if (filteredList.isNotEmpty) {
                                    final Map<String, dynamic> selectedKecamatan = filteredList.first;
                                    int idKecamatan = selectedKecamatan['id'];

                                    await addressController.getKelurahan(idKecamatan.toString());
                                    setState(() {
                                      invB.selectedKelurahan = (idKecamatan.toString() == "1") ? "000" : "001";
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
                                value: invB.selectedKelurahan != "" ? invB.selectedKelurahan : "",
                                onChanged: (String? newValue) {
                                  setState(() {
                                    invB.selectedKelurahan = newValue ?? invB.selectedKelurahan;
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
                          value: invB.statusMerk,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusMerk = newValue ?? invB.statusMerk;
                            });
                          },
                          items: invB.keteranganMerk.map((String item) {
                            return DropdownMenuItem<String>(
                              value:
                                  invB.keteranganMerk.indexOf(item) == 0 ? "1" : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  invB.statusMerk == "2"
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
                          value: invB.statusCC,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusCC = newValue ?? invB.statusCC;
                            });
                          },
                          items: invB.keteranganCC.map((String item) {
                            return DropdownMenuItem<String>(
                              value:
                                  invB.keteranganCC.indexOf(item) == 0 ? "1" : "2",
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  invB.statusCC == "2"
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
                          value: invB.statusNoPolisi,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusNoPolisi = newValue ?? invB.statusNoPolisi;
                            });
                          },
                          items: invB.keteranganNoPolisi.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganNoPolisi.indexOf(item) == 0
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
                  invB.statusNoPolisi == "2"
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
                          value: invB.statusNoRangka,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusNoRangka = newValue ?? invB.statusNoRangka;
                            });
                          },
                          items: invB.keteranganNoRangka.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganNoRangka.indexOf(item) == 0
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
                  invB.statusNoRangka == "2"
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
                          value: invB.statusNoMesin,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusNoMesin = newValue ?? invB.statusNoMesin;
                            });
                          },
                          items: invB.keteranganNoMesin.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganNoMesin.indexOf(item) == 0
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
                  invB.statusNoMesin == "2"
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
                          value: invB.statusNoBPKB,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusNoBPKB = newValue ?? invB.statusNoBPKB;
                            });
                          },
                          items: invB.keteranganNoBPKB.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganNoBPKB.indexOf(item) == 0
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
                  invB.statusNoBPKB == "2"
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
                          value: invB.statusBahan,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusBahan = newValue ?? invB.statusBahan;
                            });
                          },
                          items: invB.keteranganBahan.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganBahan.indexOf(item) == 0
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
                  invB.statusBahan == "2"
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
                          value: invB.statusNoPabrik,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusNoPabrik = newValue ?? invB.statusNoPabrik;
                            });
                          },
                          items: invB.keteranganNoPabrik.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganNoPabrik.indexOf(item) == 0
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
                  invB.statusNoPabrik == "2"
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
                          value: invB.statusKartuRuangan,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusKartuRuangan =
                                  newValue ?? invB.statusKartuRuangan;
                            });
                          },
                          items: invB.keteranganKartuRuangan.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganKartuRuangan.indexOf(item) == 0
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
                  invB.statusKartuRuangan == "2"
                      ? DropdownSearch<String>(
                          popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            showSearchBox: true,
                          ),
                          items: ruangController.ruangList
                              .map<String>((Map<String, dynamic> item) {
                                return item['ruang_nm'];
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
                            setState(() {
                              invB.selectedKartuRuangan = newValue ?? invB.selectedKartuRuangan;
                            });
                          },
                          selectedItem: invB.selectedKartuRuangan != ""
                              ? invB.selectedKartuRuangan
                              : ruangController.ruangList.isNotEmpty
                                  ? ruangController.ruangList[0]['ruang_nm']
                                  : "Pilih ruangan",
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
                        value: invB.statusQRBarang,
                        onChanged: (String? newValue) {
                          setState(() {
                            invB.statusQRBarang = newValue ?? invB.statusQRBarang;
                          });
                        },
                        items: invB.barcodeBarang.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invB.barcodeBarang.indexOf(item) == 0 ? "1" : "0",
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
                        value: invB.statusQRRuangan,
                        onChanged: (String? newValue) {
                          setState(() {
                            invB.statusQRRuangan = newValue ?? invB.statusQRRuangan;
                          });
                        },
                        items: invB.barcodeRuang.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invB.barcodeRuang.indexOf(item) == 0 ? "1" : "0",
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
                        value: invB.statusKeberadaanBarang,
                        onChanged: (String? newValue) {
                          setState(() {
                            invB.statusKeberadaanBarang = newValue ?? invB.statusKeberadaanBarang;
                          });
                        },
                        items: invB.keteranganKeberadaanBarang.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invB.keteranganKeberadaanBarang.indexOf(item) == 0 ? "1": "0",
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10),
                    invB.statusKeberadaanBarang == "0"
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
                            value: invB.dropdownKeberadaanBarang.keys
                                .contains(invB.selectedKeberadaanBarang)
                            ? invB.selectedKeberadaanBarang
                            : null,
                            onChanged: (String? newValue) {
                              setState(() {
                                invB.selectedKeberadaanBarang =
                                    newValue ?? invB.selectedKeberadaanBarang;
                              });
                            },
                            items: invB.dropdownKeberadaanBarang.keys.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(invB.dropdownKeberadaanBarang[item]!),
                              );
                            }).toList(),
                          ),
                        )
                      : SizedBox(),
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
                          value: invB.statusKondisi,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusKondisi = newValue ?? invB.statusKondisi;
                            });
                          },
                          items: invB.keteranganKondisi.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganKondisi.indexOf(item) == 0
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
                  invB.statusKondisi == "2"
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
                            value: invB.selectedKondisi,
                            onChanged: (String? newValue) {
                              setState(() {
                                invB.selectedKondisi = newValue ?? invB.selectedKondisi;
                              });
                            },
                            items: invB.dropdownKondisi.map((String item) {
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
                          value: invB.statusAsalUsul,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusAsalUsul = newValue ?? invB.statusAsalUsul;
                            });
                          },
                          items: invB.keteranganAsalUsul.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invB.keteranganAsalUsul.indexOf(item) == 0
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
                  invB.statusAsalUsul == "2"
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
                        value: invB.statusStatus,
                        onChanged: (String? newValue) {
                          setState(() {
                            invB.statusStatus = newValue ?? invB.statusStatus;
                          });
                        },
                        items: invB.keteranganStatus.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invB.keteranganStatus.indexOf(item) == 0 ? "1" : "2",
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
                    groupValue: invB.choosePemerintahDaerah,
                    onChanged: (value) {
                      setState(() {
                        invB.choosePemerintahDaerah = (value == "1") ? "1" : "";
                        invB.choosePemerintahPusat = "";
                        invB.choosePemerintahDaerahLain = "";
                        invB.choosePihakLain = "";
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
                      // Nama Pemakai
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Nama Pemakai',
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
                                      controller: editController.penggunaan_pemda_nama_pemakai,
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
                                  value: invB.statusNamaPemakai,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      invB.statusNamaPemakai = newValue ?? invB.statusNamaPemakai;
                                    });
                                  },
                                  items: invB.keteranganNamaPemakai.map((String item) {
                                    return DropdownMenuItem<String>(
                                      value: invB.keteranganNamaPemakai.indexOf(item) == 0
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
                          invB.statusNamaPemakai == "2"
                              ? Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.grey),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: TextFormField(
                                      controller: editController.penggunaan_pemda_nama_pemakai_akhir,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox(),                     
                        ],
                        
                      ),
                      SizedBox(height: 10),
                      // Status Pemakai
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Status Pemakai',
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
                                controller: editController.penggunaan_pemda_status_pemakai,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ) 
                        ],
                      ),
                      SizedBox(height: 15),
                      // BAST Pemakaian
                      Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'BAST Pemakaian',
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
                            value: invB.statusBast,
                            onChanged: (String? newValue) {
                              setState(() {
                                invB.statusBast = newValue ?? invB.statusBast;
                              });
                            },
                            items: invB.keteranganBast.map((String item) {
                              return DropdownMenuItem<String>(
                                value: invB.keteranganBast.indexOf(item) == 0 ? "1": "2",
                                child: Text(item),
                              );
                            }).toList(),
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
                    groupValue: invB.choosePemerintahPusat,
                    onChanged: (value) {
                      setState(() {
                        invB.choosePemerintahPusat = (value == "1") ? "1" : "";
                        invB.choosePemerintahDaerah= "";
                        invB.choosePemerintahDaerahLain = "";
                        invB.choosePihakLain = "";
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
                          value: invB.statusPempus,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusPempus = newValue ?? invB.statusPempus;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(maxHeight: 300),
                          items: [
                            DropdownMenuItem<String>(
                              value: "3",
                              child: Text("Pilih"),
                            ),
                            ...invB.keteranganPempus.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: invB.keteranganPempus.indexOf(item) == 0
                                      ? "1"
                                      : "0",
                                  child: Text(item),
                                );
                              }).toList(),
                          ],
                        ),
                      ),
                      if(invB.statusPempus == "1")
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
                      if(invB.statusPempus == "0")
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
                    groupValue: invB.choosePemerintahDaerahLain,
                    onChanged: (value) {
                      setState(() {
                        invB.choosePemerintahDaerahLain = (value == "1") ? "1" : "";
                        invB.choosePemerintahDaerah = "";
                        invB.choosePemerintahPusat = "";
                        invB.choosePihakLain = "";
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
                          value: invB.statusPdl,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusPdl = newValue ?? invB.statusPdl;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(maxHeight: 300),
                          items: [
                            DropdownMenuItem<String>(
                              value: "3",
                              child: Text("Pilih"),
                            ),
                            ...invB.keteranganPdl.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: invB.keteranganPdl.indexOf(item) == 0
                                      ? "1"
                                      : "0",
                                  child: Text(item),
                                );
                              }).toList(),
                          ],
                        ),
                      ),
                      if(invB.statusPdl == "1")
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
                      if(invB.statusPdl == "0")
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
                      groupValue: invB.choosePihakLain,
                      onChanged: (value) {
                        setState(() {
                          invB.choosePihakLain = (value == "1") ? "1" : "";
                          invB.choosePemerintahDaerah = "";
                          invB.choosePemerintahPusat = "";
                          invB.choosePemerintahDaerahLain = "";
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
                          value: invB.statusPl,
                          onChanged: (String? newValue) {
                            setState(() {
                              invB.statusPl = newValue ?? invB.statusPl;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(maxHeight: 300),
                          items: [
                            DropdownMenuItem<String>(
                              value: "3",
                              child: Text("Pilih"),
                            ),
                            ...invB.keteranganPl.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: invB.keteranganPl.indexOf(item) == 0
                                      ? "1"
                                      : "0",
                                  child: Text(item),
                                );
                              }).toList(),
                          ],
                        ),
                      ),
                      if(invB.statusPl == "1")
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
                      if(invB.statusPl == "0")
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
                      value: invB.statusGanda,
                      onChanged: (String? newValue) {
                        setState(() {
                          invB.statusGanda = newValue ?? invB.statusGanda;
                        });
                      },
                      items: invB.keteranganGanda.map((String item) {
                        return DropdownMenuItem<String>(
                          value: invB.keteranganGanda.indexOf(item) == 0
                                ? "1"
                                : "2",
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  invB.statusGanda == "1"
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
                        value: invB.dropdownAtasNama.keys
                                .contains(invB.statusAtasNama)
                            ? invB.statusAtasNama
                            : null,
                        onChanged: (String? newValue) {
                          setState(() {
                            invB.statusAtasNama =
                                newValue ?? invB.statusAtasNama;
                          });
                        },
                        items: invB.dropdownAtasNama.keys.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(invB.dropdownAtasNama[item]!),
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
                      editController.no_register_akhir.text,
                      invB.statusNoRegister,
                      editController.kategori_id_awal.text,
                      invB.selectedKategori,
                      invB.statusBarang,
                      editController.nama_spesifikasi_awal.text,
                      editController.nama_spesifikasi_akhir.text,
                      invB.statusNamaBarang,
                      editController.jumlah_awal.text,
                      invB.selectedSatuan,
                      editController.cara_perolehan_awal.text,
                      invB.selectedPerolehan,
                      invB.statusPerolehan,
                      editController.tgl_perolehan.text,
                      editController.tahun_perolehan.text,
                      editController.perolehan_awal.text,
                      editController.perolehan_akhir.text,
                      invB.statusNilaiPerolehan,
                      invB.statusAtribusi,
                      editController.atribusi_nibar.text,
                      editController.atribusi_kode_barang.text,
                      editController.atribusi_kode_lokasi.text,
                      editController.atribusi_no_register.text,
                      editController.atribusi_nama_barang.text,
                      editController.atribusi_spesifikasi_barang.text,
                      editController.a_alamat_awal.text,
                      invB.statusAlamat,
                      editController.alamat_kota.text,
                      invB.selectedKecamatan,
                      invB.selectedKelurahan,
                      editController.alamat_jalan.text,
                      editController.alamat_no.text,
                      editController.alamat_rt.text,
                      editController.alamat_rw.text,
                      editController.alamat_kodepos.text,
                      editController.b_merk_awal.text,
                      editController.b_merk_akhir.text,
                      invB.statusMerk,
                      editController.b_cc_awal.text,
                      editController.b_cc_akhir.text,
                      invB.statusCC,
                      editController.b_nomor_polisi_awal.text,
                      editController.b_nomor_polisi_akhir.text,
                      invB.statusNoPolisi,
                      editController.b_nomor_rangka_awal.text,
                      editController.b_nomor_rangka_akhir.text,
                      invB.statusNoRangka,
                      editController.b_nomor_mesin_awal.text,
                      editController.b_nomor_mesin_akhir.text,
                      invB.statusNoMesin,
                      editController.b_nomor_bpkb_awal.text,
                      editController.b_nomor_bpkb_akhir.text,
                      invB.statusNoBPKB,
                      editController.b_bahan_awal.text,
                      editController.b_bahan_akhir.text,
                      invB.statusBahan,
                      editController.b_nomor_pabrik_awal.text,
                      editController.b_nomor_pabrik_akhir.text,
                      invB.statusNoPabrik,
                      editController.kartu_inv_awal.text,
                      invB.selectedKartuRuangan,
                      invB.statusKartuRuangan,
                      invB.statusQRBarang,
                      invB.statusQRRuangan,
                      invB.selectedKeberadaanBarang,
                      invB.statusKeberadaanBarang,
                      editController.kondisi_awal.text,
                      invB.selectedKondisi,
                      invB.statusKondisi,
                      editController.asal_usul_awal.text,
                      editController.asal_usul_akhir.text,
                      invB.statusAsalUsul,
                      invB.statusStatus,
                      editController.penggunaan_awal.text,
                      invB.choosePemerintahDaerah,
                      editController.penggunaan_pemda_akhir.text,
                      editController.penggunaan_pemda_nama_pemakai.text,
                      editController.penggunaan_pemda_nama_pemakai_akhir.text,
                      invB.statusNamaPemakai,
                      editController.penggunaan_pemda_status_pemakai.text,
                      invB.statusBast,
                      invB.choosePemerintahPusat,
                      invB.statusPempus,
                      editController.penggunaan_pempus_y_nm.text,
                      editController.penggunaan_pempus_y_doc.text,
                      editController.penggunaan_pempus_t_nm.text,
                      invB.choosePemerintahDaerahLain,
                      invB.statusPdl,
                      editController.penggunaan_pdl_y_nm.text,
                      editController.penggunaan_pdl_y_doc.text,
                      editController.penggunaan_pdl_t_nm.text,
                      invB.choosePihakLain,
                      invB.statusPl,
                      editController.penggunaan_pl_y_nm.text,
                      editController.penggunaan_pl_y_doc.text,
                      editController.penggunaan_pl_t_nm.text,
                      invB.statusGanda,
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
                      invB.statusAtasNama,
                      editController.lainnya.text,
                      editController.keterangan.text,
                      _petugasList,
                      editController.tahun.text
                    ];
                    
                    if(invB.statusInventaris == "0"){
                      editController.insertInventarisB(id, data);
                    } else {
                      editController.updateInventarisB(editController.kib_id.text, data);
                    }
                  },
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
}
