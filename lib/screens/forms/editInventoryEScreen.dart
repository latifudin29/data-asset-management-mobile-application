import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kib_application/constans/colors.dart';
import 'package:kib_application/constans/inventoryVariablesE.dart';
import 'package:kib_application/controllers/addressController.dart';
import 'package:kib_application/controllers/appointmentController.dart';
import 'package:kib_application/controllers/categoryController.dart';
import 'package:kib_application/controllers/inventoryEController.dart';
import 'package:kib_application/controllers/unitController.dart';
import 'package:kib_application/widgets/formPetugas.dart';

class EditInventoryEScreen extends StatefulWidget {
  const EditInventoryEScreen({super.key});

  @override
  State<EditInventoryEScreen> createState() => _EditInventoryEScreenState();
}

class _EditInventoryEScreenState extends State<EditInventoryEScreen> {
  final penetapanController = Get.put(AppointmentController());
  final editController      = Get.put(InventoryEController());
  final kategoriController  = Get.put(CategoryController());
  final satuanController    = Get.put(UnitController());
  final addressController   = Get.put(AddressController());
  final invE                = Get.put(InventoryVariablesE());

  List<dynamic> _petugasList = [''];

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    final data = penetapanController.penetapanListById[0];
    final filteredList = addressController.kecamatanList
      .where((kecamatan) => kecamatan['kecamatan_kd'].toString() == data['alamat_kecamatan'].toString());   
    
    invE.statusInventaris             = data['status_inventaris'].toString();
    editController.kib_id.text        = data['kib_id'].toString();
    editController.penetapan_id.text  = data['penetapan_id'].toString();
    editController.departemen_id.text = data['departemen_id'].toString();

    invE.statusNoRegister       = data['no_register_status']       != "" ? data['no_register_status'].toString() : "1";
    invE.statusBarang           = data['kategori_id_status']       != "" ? data['kategori_id_status'].toString() : "1";
    invE.statusNamaBarang       = data['nama_spesifikasi_status']  != "" ? data['nama_spesifikasi_status'].toString() : "1";
    invE.statusPerolehan        = data['cara_perolehan_status']    != "" ? data['cara_perolehan_status'].toString() : "1";
    invE.statusNilaiPerolehan   = data['perolehan_status']         != "" ? data['perolehan_status'].toString() : "1";
    invE.statusAlamat           = data['a_alamat_status']          != "" ? data['a_alamat_status'].toString() : "1";
    invE.statusKondisi          = data['kondisi_status']           != "" ? data['kondisi_status'].toString() : "1";
    invE.statusAsalUsul         = data['asal_usul_status']         != "" ? data['asal_usul_status'].toString() : "1";
    invE.statusAtribusi         = data['atribusi_status']          != "" ? data['atribusi_status'].toString() : "0";
    invE.statusKeberadaanBarang = data['keberadaan_barang_status'] != "" ? data['keberadaan_barang_status'].toString() : "1";
    invE.statusStatus           = data['penggunaan_status']        != "" ? data['penggunaan_status'].toString() : "1";
    invE.statusAtasNama         = data['pemilik_id']               != "" ? data['pemilik_id'].toString() : "1";
    
    invE.statusSpek           = data['e_spek_status']     != "" ? data['e_spek_status'].toString() : "1";
    invE.statusJudul          = data['e_judul_status']    != "" ? data['e_judul_status'].toString() : "1";
    invE.statusJenisBarang    = data['e_jenis_status']    != "" ? data['e_jenis_status'].toString() : "1";
    invE.statusBahanBarang    = data['e_bahan_status']    != "" ? data['e_bahan_status'].toString() : "1";
    invE.statusPenciptaBarang = data['e_pencipta_status'] != "" ? data['e_pencipta_status'].toString() : "1";
    invE.statusUkuranBarang   = data['e_ukuran_status']   != "" ? data['e_ukuran_status'].toString() : "1";

    invE.chooseAtribusi   = data['atribusi_status'] != "" ? data['atribusi_status'].toString() : "0";
    
    invE.choosePemerintahDaerah     = (invE.statusInventaris == "0") ? "1" : data['penggunaan_pemda_status'].toString();
    invE.choosePemerintahPusat      = data['penggunaan_pempus_status'].toString();
    invE.choosePemerintahDaerahLain = data['penggunaan_pdl_status'].toString();
    invE.choosePihakLain            = data['penggunaan_pl_status'].toString();

    invE.statusPempus = data['penggunaan_pempus_yt'] != "" ? data['penggunaan_pempus_yt'].toString() : "3";
    invE.statusPdl    = data['penggunaan_pdl_yt'] != "" ? data['penggunaan_pdl_yt'].toString() : "3";
    invE.statusPl     = data['penggunaan_pl_yt'] != "" ? data['penggunaan_pl_yt'].toString() : "3";

    String caraPerolehan = (invE.statusInventaris == "0") ? data['cara_perolehan'].toString() : data['cara_perolehan_akhir'].toString();
    if (caraPerolehan == "Pembelian" || caraPerolehan == "1" || caraPerolehan == "") {
      invE.selectedPerolehan = "1";
    } else if (caraPerolehan == "Hibah" || caraPerolehan == "2") {
      invE.selectedPerolehan = "2";
    } else if (caraPerolehan == "Barang & Jasa" || caraPerolehan == "3") {
      invE.selectedPerolehan = "3";
    } else if (caraPerolehan == "Hasil Inventarisasi" || caraPerolehan == "4") {
      invE.selectedPerolehan = "4";
    }

    invE.selectedKeberadaanBarang = data['keberadaan_barang_akhir'] != "" ? data['keberadaan_barang_akhir'].toString() : "1";

    editController.tgl_inventaris.text                      = (invE.statusInventaris == "0") ? DateFormat('dd-MM-yyyy').format(now) : data['tgl_inventaris_formatted'].toString();
    editController.skpd.text                                = data['departemen_kd'].toString();
    editController.skpd_uraian.text                         = data['departemen_nm'].toString();
    editController.barang.text                              = data['kategori_kd'].toString() + ' - ' + data['kategori_nm'].toString();
    editController.no_register_awal.text                    = (invE.statusInventaris == "0") ? data['no_register'].toString() : data['no_register_awal'].toString();
    editController.no_register_akhir.text                   = (invE.statusInventaris == "0") ? data['no_register'].toString() : data['no_register_akhir'].toString();
    editController.kategori_id_awal.text                    = (invE.statusInventaris == "0") ? data['kategori_id'].toString() : data['kategori_id_awal'].toString();
    invE.selectedKategori                                   = (invE.statusInventaris == "0") ? data['kategori_id'].toString() : data['kategori_id_akhir'].toString();
    editController.nama_spesifikasi_awal.text               = data['nama_spesifikasi_awal'].toString();
    editController.nama_spesifikasi_akhir.text              = data['nama_spesifikasi_akhir'].toString();
    editController.jumlah_awal.text                         = (invE.statusInventaris == "0") ? data['jumlah'].toString() : data['jumlah_awal'].toString();
    invE.selectedSatuan                                     = (invE.statusInventaris == "0") ? (data['satuan_awal'] != "") ? data['satuan_awal'].toString() : "" : (data['satuan_akhir'] != "") ? data['satuan_akhir'].toString() : "";
    editController.cara_perolehan_awal.text                 = (invE.statusInventaris == "0") ? data['cara_perolehan'].toString() : data['cara_perolehan_awal'].toString();
    editController.tgl_perolehan.text                       = (invE.statusInventaris == "0") ? data['tgl_perolehan_penetapan'].toString() : data['tgl_perolehan_inventaris'].toString();
    editController.tahun_perolehan.text                     = (invE.statusInventaris == "0") ? data['th_beli'].toString() : data['tahun_perolehan'].toString();
    editController.perolehan_awal.text                      = (invE.statusInventaris == "0") ? data['perolehan_formatted'].toString() : data['perolehan_awal_formatted'].toString();
    editController.perolehan_akhir.text                     = (invE.statusInventaris == "0") ? data['perolehan_formatted'].toString() : data['perolehan_akhir_formatted'].toString();
    editController.atribusi_nibar.text                      = data['atribusi_nibar'].toString();
    editController.atribusi_kode_barang.text                = data['atribusi_kode_barang'].toString();
    editController.atribusi_kode_lokasi.text                = data['atribusi_kode_lokasi'].toString();
    editController.atribusi_no_register.text                = data['atribusi_no_register'].toString();
    editController.atribusi_nama_barang.text                = data['atribusi_nama_barang'].toString();
    editController.atribusi_spesifikasi_barang.text         = data['atribusi_spesifikasi_barang'].toString();
    editController.a_alamat_awal.text                       = (invE.statusInventaris == "0") ? data['a_alamat'].toString() : data['a_alamat_awal'].toString();
    editController.alamat_kota.text                         = data['alamat_kota'] != "" ? data['alamat_kota'].toString() : "KOTA BOGOR";
    invE.selectedKecamatan                                  = data['alamat_kecamatan'].toString();
    if (filteredList.isNotEmpty) {
      final Map<String, dynamic> selectedKecamatan = filteredList.first;
      int idKecamatan = selectedKecamatan['id'];
      invE.selectedKelurahan = (idKecamatan.toString() == "1") ? "000" : data['alamat_kelurahan'].toString();
    }
    editController.alamat_jalan.text                      = data['alamat_jalan'].toString();
    editController.alamat_no.text                         = data['alamat_no'].toString();
    editController.alamat_rt.text                         = data['alamat_rt'].toString();
    editController.alamat_rw.text                         = data['alamat_rw'].toString();
    editController.alamat_kodepos.text                    = data['alamat_kodepos'].toString();
    editController.e_spek_awal.text                       = (invE.statusInventaris == "0") ? data['e_spek'].toString() : data['e_spek_awal'].toString();
    editController.e_spek_akhir.text                      = (invE.statusInventaris == "0") ? data['e_spek'].toString() : data['e_spek_akhir'].toString();
    editController.e_judul_awal.text                      = (invE.statusInventaris == "0") ? data['e_judul'].toString() : data['e_judul_awal'].toString();
    editController.e_judul_akhir.text                     = (invE.statusInventaris == "0") ? data['e_judul'].toString() : data['e_judul_akhir'].toString();
    editController.e_jenis_awal.text                      = (invE.statusInventaris == "0") ? data['e_jenis'].toString() : data['e_jenis_awal'].toString();
    editController.e_jenis_akhir.text                     = (invE.statusInventaris == "0") ? data['e_jenis'].toString() : data['e_jenis_akhir'].toString();
    editController.e_bahan_awal.text                      = (invE.statusInventaris == "0") ? data['e_bahan'].toString() : data['e_bahan_awal'].toString();
    editController.e_bahan_akhir.text                     = (invE.statusInventaris == "0") ? data['e_bahan'].toString() : data['e_bahan_akhir'].toString();
    editController.e_pencipta_awal.text                   = (invE.statusInventaris == "0") ? data['e_pencipta'].toString() : data['e_pencipta_awal'].toString();
    editController.e_pencipta_akhir.text                  = (invE.statusInventaris == "0") ? data['e_pencipta'].toString() : data['e_pencipta_akhir'].toString();
    editController.e_ukuran_awal.text                     = (invE.statusInventaris == "0") ? data['e_ukuran'].toString() : data['e_ukuran_awal'].toString();
    editController.e_ukuran_akhir.text                    = (invE.statusInventaris == "0") ? data['e_ukuran'].toString() : data['e_ukuran_akhir'].toString();
    editController.kondisi_awal.text                      = (invE.statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_awal'].toString();
    invE.selectedKondisi                                  = (invE.statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_akhir'].toString();
    editController.asal_usul_awal.text                    = (invE.statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_awal'].toString();
    editController.asal_usul_akhir.text                   = (invE.statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_akhir'].toString();
    editController.penggunaan_awal.text                   = (invE.statusInventaris == "0") ? data['a_penggunaan'].toString() : data['penggunaan_awal'].toString();
    editController.penggunaan_pemda_akhir.text            = data['penggunaan_pemda_akhir'].toString();
    editController.penggunaan_pempus_y_nm.text            = data['penggunaan_pempus_y_nm'].toString();
    editController.penggunaan_pempus_y_doc.text           = data['penggunaan_pempus_y_doc'].toString();
    editController.penggunaan_pempus_t_nm.text            = data['penggunaan_pempus_t_nm'].toString();
    editController.penggunaan_pdl_y_nm.text               = data['penggunaan_pdl_y_nm'].toString();
    editController.penggunaan_pdl_y_doc.text              = data['penggunaan_pdl_y_doc'].toString();
    editController.penggunaan_pdl_t_nm.text               = data['penggunaan_pdl_t_nm'].toString();
    editController.penggunaan_pl_y_nm.text                = data['penggunaan_pl_y_nm'].toString();
    editController.penggunaan_pl_y_doc.text               = data['penggunaan_pl_y_doc'].toString();
    editController.penggunaan_pl_t_nm.text                = data['penggunaan_pl_t_nm'].toString();
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
    editController.lainnya.text                           = data['lainnya'].toString();
    editController.keterangan.text                        = (invE.statusInventaris == "0") ? data['keterangan_penetapan'].toString() : data['keterangan_inventaris'].toString();
    editController.file_nm.text                           = data['file_nm'].toString();
    _petugasList                                          = data['petugas'] != null && data['petugas'].isNotEmpty ? List<String>.from(data['petugas']) : [""];
    editController.tahun.text                             = (invE.statusInventaris == "0") ? now.year.toString() : data['tahun'].toString();
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
        title: Text('Edit Inventaris - E'),
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
                          value: invE.statusNoRegister,
                          onChanged: (String? newValue) {
                            setState(() {
                              invE.statusNoRegister = newValue ?? invE.statusNoRegister;
                            });
                          },
                          items: invE.keteranganNoRegister.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invE.keteranganNoRegister.indexOf(item) == 0
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
                  invE.statusNoRegister == "2"
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
                          value: invE.statusBarang,
                          onChanged: (String? newValue) {
                            setState(() {
                              invE.statusBarang = newValue ?? invE.statusBarang;
                            });
                          },
                          items: invE.keteranganBarang.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invE.keteranganBarang.indexOf(item) == 0
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
                  invE.statusBarang == "2"
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
                                invE.selectedKategori = id;
                                print(invE.selectedKategori);
                              });
                            }
                          },
                          selectedItem: invE.selectedKategori != ""
                            ? kategoriController.kategoriList
                                .where((item) => item['id'].toString() == invE.selectedKategori)
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
                          value: invE.statusNamaBarang,
                          onChanged: (String? newValue) {
                            setState(() {
                              invE.statusNamaBarang = newValue ?? invE.statusNamaBarang;
                            });
                          },
                          items: invE.keteranganNamaBarang.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invE.keteranganNamaBarang.indexOf(item) == 0
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
                  invE.statusNamaBarang == "2"
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
                        invE.selectedSatuan = newValue ?? invE.selectedSatuan;
                      });
                    },
                    selectedItem: invE.selectedSatuan != "" ? invE.selectedSatuan : "Pilih satuan",
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
                            value: invE.statusPerolehan,
                            onChanged: (String? newValue) {
                              setState(() {
                                invE.statusPerolehan =
                                    newValue ?? invE.statusPerolehan;
                              });
                            },
                            items: invE.keteranganPerolehan.map((String item) {
                              return DropdownMenuItem<String>(
                                value:
                                    invE.keteranganPerolehan.indexOf(item) == 0
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
                    invE.statusPerolehan == "2"
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
                              value: invE.dropdownPerolehan.keys
                                      .contains(invE.selectedPerolehan)
                                  ? invE.selectedPerolehan
                                  : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  invE.selectedPerolehan = newValue ?? invE.selectedPerolehan;
                                });
                              },
                              items: invE.dropdownPerolehan.entries.map((entry) {
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
                          value: invE.statusNilaiPerolehan,
                          onChanged: (String? newValue) {
                            setState(() {
                              invE.statusNilaiPerolehan =
                                  newValue ?? invE.statusNilaiPerolehan;
                            });
                          },
                          items: invE.keteranganNilaiPerolehan.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invE.keteranganNilaiPerolehan.indexOf(item) == 0
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
                  invE.statusNilaiPerolehan == "2"
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
                      value: invE.statusAtribusi,
                      onChanged: (String? newValue) {
                        setState(() {
                          invE.statusAtribusi = newValue ?? invE.statusAtribusi;
                        });
                      },
                      items: invE.keteranganAtribusi.map((String item) {
                        return DropdownMenuItem<String>(
                          value: invE.keteranganAtribusi.indexOf(item) == 0 ? "1" : "0",
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 10),
                  invE.statusAtribusi == "1"
                      ? Column(
                          children: [
                            RadioListTile(
                              title:
                                  Text("Tidak diketahui data awal/induknya"),
                              value: "0",
                              groupValue: invE.chooseAtribusi,
                              onChanged: (value) {
                                setState(() {
                                  invE.chooseAtribusi = value.toString();
                                });
                              },
                            ),
                            RadioListTile(
                              title: Text(
                                  "Ya, Diketahui data awal/Induknya dan sebutkan data barang awal/induknya"),
                              value: "1",
                              groupValue: invE.chooseAtribusi,
                              onChanged: (value) {
                                setState(() {
                                  invE.chooseAtribusi = value.toString();
                                });
                              },
                            ),
                          ],
                        )
                      : SizedBox(),
                  SizedBox(height: 10),
                  invE.chooseAtribusi == "1" 
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
                          value: invE.statusAlamat,
                          onChanged: (String? newValue) {
                            setState(() {
                              invE.statusAlamat =
                                  newValue ?? invE.statusAlamat;
                            });
                          },
                          items: invE.keteranganAlamat.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invE.keteranganAlamat.indexOf(item) == 0
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
                  invE.statusAlamat == "2"
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
                                value: invE.selectedKecamatan != "" ? invE.selectedKecamatan : "",
                                onChanged: (String? newValue) async {
                                  setState(() {
                                    invE.selectedKecamatan = newValue ?? invE.selectedKecamatan;
                                  });

                                  final filteredList = addressController.kecamatanList
                                      .where((kecamatan) => kecamatan['kecamatan_kd'].toString() == newValue);

                                  if (filteredList.isNotEmpty) {
                                    final Map<String, dynamic> selectedKecamatan = filteredList.first;
                                    int idKecamatan = selectedKecamatan['id'];

                                    await addressController.getKelurahan(idKecamatan.toString());
                                    setState(() {
                                      invE.selectedKelurahan = (idKecamatan.toString() == "1") ? "000" : "001";
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
                                value: invE.selectedKelurahan != "" ? invE.selectedKelurahan : "",
                                onChanged: (String? newValue) {
                                  setState(() {
                                    invE.selectedKelurahan = newValue ?? invE.selectedKelurahan;
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
              
              // Inventaris E

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
                        value: invE.statusKeberadaanBarang,
                        onChanged: (String? newValue) {
                          setState(() {
                            invE.statusKeberadaanBarang = newValue ?? invE.statusKeberadaanBarang;
                          });
                        },
                        items: invE.keteranganKeberadaanBarang.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invE.keteranganKeberadaanBarang.indexOf(item) == 0 ? "1": "0",
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10),
                    invE.statusKeberadaanBarang == "0"
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
                            value: invE.dropdownKeberadaanBarang.keys
                                .contains(invE.selectedKeberadaanBarang)
                            ? invE.selectedKeberadaanBarang
                            : null,
                            onChanged: (String? newValue) {
                              setState(() {
                                invE.selectedKeberadaanBarang =
                                    newValue ?? invE.selectedKeberadaanBarang;
                              });
                            },
                            items: invE.dropdownKeberadaanBarang.keys.map((String item) {
                              return DropdownMenuItem<String>(
                                value: item,
                                child: Text(invE.dropdownKeberadaanBarang[item]!),
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
                          value: invE.statusKondisi,
                          onChanged: (String? newValue) {
                            setState(() {
                              invE.statusKondisi = newValue ?? invE.statusKondisi;
                            });
                          },
                          items: invE.keteranganKondisi.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invE.keteranganKondisi.indexOf(item) == 0
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
                  invE.statusKondisi == "2"
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
                            value: invE.selectedKondisi,
                            onChanged: (String? newValue) {
                              setState(() {
                                invE.selectedKondisi = newValue ?? invE.selectedKondisi;
                              });
                            },
                            items: invE.dropdownKondisi.map((String item) {
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
                          value: invE.statusAsalUsul,
                          onChanged: (String? newValue) {
                            setState(() {
                              invE.statusAsalUsul = newValue ?? invE.statusAsalUsul;
                            });
                          },
                          items: invE.keteranganAsalUsul.map((String item) {
                            return DropdownMenuItem<String>(
                              value: invE.keteranganAsalUsul.indexOf(item) == 0
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
                  invE.statusAsalUsul == "2"
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
                        value: invE.statusStatus,
                        onChanged: (String? newValue) {
                          setState(() {
                            invE.statusStatus = newValue ?? invE.statusStatus;
                          });
                        },
                        items: invE.keteranganStatus.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invE.keteranganStatus.indexOf(item) == 0 ? "1" : "2",
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
                    groupValue: invE.choosePemerintahDaerah,
                    onChanged: (value) {
                      setState(() {
                        invE.choosePemerintahDaerah = (value == "1") ? "1" : "";
                        invE.choosePemerintahPusat = "";
                        invE.choosePemerintahDaerahLain = "";
                        invE.choosePihakLain = "";
                      });
                    },
                  ),
                  SizedBox(height: 3),
                  Column(
                    children: [
                      // Nama Kuasa
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
                    groupValue: invE.choosePemerintahPusat,
                    onChanged: (value) {
                      setState(() {
                        invE.choosePemerintahPusat = (value == "1") ? "1" : "";
                        invE.choosePemerintahDaerah= "";
                        invE.choosePemerintahDaerahLain = "";
                        invE.choosePihakLain = "";
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
                          value: invE.statusPempus,
                          onChanged: (String? newValue) {
                            setState(() {
                              invE.statusPempus = newValue ?? invE.statusPempus;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(maxHeight: 300),
                          items: [
                            DropdownMenuItem<String>(
                              value: "3",
                              child: Text("Pilih"),
                            ),
                            ...invE.keteranganPempus.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: invE.keteranganPempus.indexOf(item) == 0
                                      ? "1"
                                      : "0",
                                  child: Text(item),
                                );
                              }).toList(),
                          ],
                        ),
                      ),
                      if(invE.statusPempus == "1")
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
                      if(invE.statusPempus == "0")
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
                    groupValue: invE.choosePemerintahDaerahLain,
                    onChanged: (value) {
                      setState(() {
                        invE.choosePemerintahDaerahLain = (value == "1") ? "1" : "";
                        invE.choosePemerintahDaerah = "";
                        invE.choosePemerintahPusat = "";
                        invE.choosePihakLain = "";
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
                          value: invE.statusPdl,
                          onChanged: (String? newValue) {
                            setState(() {
                              invE.statusPdl = newValue ?? invE.statusPdl;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(maxHeight: 300),
                          items: [
                            DropdownMenuItem<String>(
                              value: "3",
                              child: Text("Pilih"),
                            ),
                            ...invE.keteranganPdl.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: invE.keteranganPdl.indexOf(item) == 0
                                      ? "1"
                                      : "0",
                                  child: Text(item),
                                );
                              }).toList(),
                          ],
                        ),
                      ),
                      if(invE.statusPdl == "1")
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
                      if(invE.statusPdl == "0")
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
                      groupValue: invE.choosePihakLain,
                      onChanged: (value) {
                        setState(() {
                          invE.choosePihakLain = (value == "1") ? "1" : "";
                          invE.choosePemerintahDaerah = "";
                          invE.choosePemerintahPusat = "";
                          invE.choosePemerintahDaerahLain = "";
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
                          value: invE.statusPl,
                          onChanged: (String? newValue) {
                            setState(() {
                              invE.statusPl = newValue ?? invE.statusPl;
                            });
                          },
                          dropdownStyleData: DropdownStyleData(maxHeight: 300),
                          items: [
                            DropdownMenuItem<String>(
                              value: "3",
                              child: Text("Pilih"),
                            ),
                            ...invE.keteranganPl.map((String item) {
                                return DropdownMenuItem<String>(
                                  value: invE.keteranganPl.indexOf(item) == 0
                                      ? "1"
                                      : "0",
                                  child: Text(item),
                                );
                              }).toList(),
                          ],
                        ),
                      ),
                      if(invE.statusPl == "1")
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
                      if(invE.statusPl == "0")
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
                      value: invE.statusGanda,
                      onChanged: (String? newValue) {
                        setState(() {
                          invE.statusGanda = newValue ?? invE.statusGanda;
                        });
                      },
                      items: invE.keteranganGanda.map((String item) {
                        return DropdownMenuItem<String>(
                          value: invE.keteranganGanda.indexOf(item) == 0
                                ? "1"
                                : "2",
                          child: Text(item),
                        );
                      }).toList(),
                    ),
                  ),
                  invE.statusGanda == "1"
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
                        value: invE.dropdownAtasNama.keys
                                .contains(invE.statusAtasNama)
                            ? invE.statusAtasNama
                            : null,
                        onChanged: (String? newValue) {
                          setState(() {
                            invE.statusAtasNama =
                                newValue ?? invE.statusAtasNama;
                          });
                        },
                        items: invE.dropdownAtasNama.keys.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(invE.dropdownAtasNama[item]!),
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
                      invE.statusNoRegister,
                      editController.kategori_id_awal.text,
                      invE.selectedKategori,
                      invE.statusBarang,
                      editController.nama_spesifikasi_awal.text,
                      editController.nama_spesifikasi_akhir.text,
                      invE.statusNamaBarang,
                      editController.jumlah_awal.text,
                      invE.selectedSatuan,
                      editController.cara_perolehan_awal.text,
                      invE.selectedPerolehan,
                      invE.statusPerolehan,
                      editController.tgl_perolehan.text,
                      editController.tahun_perolehan.text,
                      editController.perolehan_awal.text,
                      editController.perolehan_akhir.text,
                      invE.statusNilaiPerolehan,
                      invE.statusAtribusi,
                      editController.atribusi_nibar.text,
                      editController.atribusi_kode_barang.text,
                      editController.atribusi_kode_lokasi.text,
                      editController.atribusi_no_register.text,
                      editController.atribusi_nama_barang.text,
                      editController.atribusi_spesifikasi_barang.text,
                      editController.a_alamat_awal.text,
                      invE.statusAlamat,
                      editController.alamat_kota.text,
                      invE.selectedKecamatan,
                      invE.selectedKelurahan,
                      editController.alamat_jalan.text,
                      editController.alamat_no.text,
                      editController.alamat_rt.text,
                      editController.alamat_rw.text,
                      editController.alamat_kodepos.text,
                      // Inventaris E
                      invE.selectedKeberadaanBarang,
                      invE.statusKeberadaanBarang,
                      editController.kondisi_awal.text,
                      invE.selectedKondisi,
                      invE.statusKondisi,
                      editController.asal_usul_awal.text,
                      editController.asal_usul_akhir.text,
                      invE.statusAsalUsul,
                      invE.statusStatus,
                      editController.penggunaan_awal.text,
                      invE.choosePemerintahDaerah,
                      editController.penggunaan_pemda_akhir.text,
                      invE.choosePemerintahPusat,
                      invE.statusPempus,
                      editController.penggunaan_pempus_y_nm.text,
                      editController.penggunaan_pempus_y_doc.text,
                      editController.penggunaan_pempus_t_nm.text,
                      invE.choosePemerintahDaerahLain,
                      invE.statusPdl,
                      editController.penggunaan_pdl_y_nm.text,
                      editController.penggunaan_pdl_y_doc.text,
                      editController.penggunaan_pdl_t_nm.text,
                      invE.choosePihakLain,
                      invE.statusPl,
                      editController.penggunaan_pl_y_nm.text,
                      editController.penggunaan_pl_y_doc.text,
                      editController.penggunaan_pl_t_nm.text,
                      invE.statusGanda,
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
                      invE.statusAtasNama,
                      editController.lainnya.text,
                      editController.keterangan.text,
                      _petugasList,
                      editController.tahun.text
                    ];
                    
                    if(invE.statusInventaris == "0"){
                      editController.insertInventarisE(id, data);
                    } else {
                      editController.updateInventarisE(editController.kib_id.text, data);
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
