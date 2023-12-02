import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
  final editController      = Get.put(InventoryCController());
  final kategoriController  = Get.put(CategoryController());
  final satuanController    = Get.put(UnitController());
  final addressController   = Get.put(AddressController());
  final invC                = Get.put(InventoryVariablesC());

  DateTime now = DateTime.now();

  @override
  void initState() {
    super.initState();
    final data         = penetapanController.penetapanListById[0];
    final filteredList = addressController.kecamatanList
      .where((kecamatan) => kecamatan['kecamatan_kd'].toString() == data['alamat_kecamatan'].toString());

    String statusInventaris = data['status_inventaris'].toString();
    editController.kib_id.text = data['kib_id'].toString();

    invC.statusNoRegister       = data['no_register_status']                   != "" ? data['no_register_status'].toString() : "1";
    invC.statusBarang           = data['kategori_id_status']                   != "" ? data['kategori_id_status'].toString() : "1";
    invC.statusNamaBarang       = data['nama_spesifikasi_status']              != "" ? data['nama_spesifikasi_status'].toString() : "1";
    invC.statusLuasLantai       = "1";
    invC.statusPerolehan        = data['cara_perolehan_status']                != "" ? data['cara_perolehan_status'].toString() : "1";
    invC.statusNilaiPerolehan   = data['perolehan_status']                     != "" ? data['perolehan_status'].toString() : "1";
    invC.statusAlamat           = data['a_alamat_status']                      != "" ? data['a_alamat_status'].toString() : "1";
    invC.statusLuasTanah        = data['c_luas_tanah_status']                  != "" ? data['c_luas_tanah_status'].toString() : "1";
    invC.statusKondisi          = data['kondisi_status']                       != "" ? data['kondisi_status'].toString() : "1";
    invC.statusAsalUsul         = data['asal_usul_status']                     != "" ? data['asal_usul_status'].toString() : "1";
    invC.statusAtribusi         = data['atribusi_status']                      != "" ? data['atribusi_status'].toString() : "0";
    invC.statusKeberadaanBarang = data['keberadaan_barang_status']             != "" ? data['keberadaan_barang_status'].toString() : "1";
    invC.statusStatus           = data['penggunaan_status']                    != "" ? data['penggunaan_status'].toString() : "1";
    invC.statusAtasNama         = data['pemilik_id']                           != "" ? data['pemilik_id'].toString() : "1";
    invC.statusNamaPemakai      = data['penggunaan_pemda_nama_pemakai_status'] != "" ? data['penggunaan_pemda_nama_pemakai_status'].toString() : "1";
    invC.statusBast             = data['penggunaan_pemda_bast_pemakaian']      != "" ? data['penggunaan_pemda_bast_pemakaian'].toString() : "1";
    invC.statusSIP              = data['penggunaan_pemda_sip']                 != "" ? data['penggunaan_pemda_sip'].toString() : "1";
    invC.statusIMB              = data['penggunaan_pemda_imb']                 != "" ? data['penggunaan_pemda_imb'].toString() : "1";
    invC.statusGanda            = data['tercatat_ganda']                       != "" ? data['tercatat_ganda'].toString() : "2";
    invC.statusPempus           = data['penggunaan_pempus_yt']                 != "" ? data['penggunaan_pempus_yt'].toString() : "3";
    invC.statusPdl              = data['penggunaan_pdl_yt']                    != "" ? data['penggunaan_pdl_yt'].toString() : "3";
    invC.statusPl               = data['penggunaan_pl_yt']                     != "" ? data['penggunaan_pl_yt'].toString() : "3";

    invC.chooseAtribusi   = data['atribusi_status'] != "" ? data['atribusi_status'].toString() : "0";
    invC.choosePemerintah = "1";

    String caraPerolehan = (statusInventaris == "0") ? data['cara_perolehan'].toString() : data['cara_perolehan_akhir'].toString();
    if (caraPerolehan == "Pembelian" || caraPerolehan == "1") {
      invC.selectedPerolehan = "1";
    } else if (caraPerolehan == "Hibah" || caraPerolehan == "2") {
      invC.selectedPerolehan = "2";
    } else if (caraPerolehan == "Barang & Jasa" || caraPerolehan == "3") {
      invC.selectedPerolehan = "3";
    } else if (caraPerolehan == "Hasil Inventarisasi" || caraPerolehan == "4") {
      invC.selectedPerolehan = "4";
    } else {
      invC.selectedPerolehan = "";
    }

    String bertingkatTidak = (statusInventaris == "0") ? data['c_bertingkat_tidak'].toString() : data['c_bertingkat'].toString();
    if (bertingkatTidak == "Bertingkat") {
      invC.statusBertingkat = "1";
    } else {
      invC.statusBertingkat = "0";
    }

    String betonTidak = (statusInventaris == "0") ? data['c_beton_tidak'].toString() : data['c_beton'].toString();
    if (betonTidak == "Beton") {
      invC.statusBeton = "1";
    } else {
      invC.statusBeton = "0";
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
    editController.atribusi_nibar.text                    = data['atribusi_nibar'].toString();
    editController.atribusi_kode_barang.text              = data['atribusi_kode_barang'].toString();
    editController.atribusi_kode_lokasi.text              = data['atribusi_kode_lokasi'].toString();
    editController.atribusi_no_register.text              = data['atribusi_no_register'].toString();
    editController.atribusi_nama_barang.text              = data['atribusi_nama_barang'].toString();
    editController.atribusi_spesifikasi_barang.text       = data['atribusi_spesifikasi_barang'].toString();
    editController.a_alamat_awal.text                     = (statusInventaris == "0") ? data['c_lokasi'].toString() : data['c_lokasi_awal'].toString();
    editController.alamat_kota.text                       = data['alamat_kota'] != "" ? data['alamat_kota'].toString() : "KOTA BOGOR";
    invC.selectedKecamatan                                = data['alamat_kecamatan'].toString();
    if (filteredList.isNotEmpty) {
      final Map<String, dynamic> selectedKecamatan = filteredList.first;
      int idKecamatan = selectedKecamatan['id'];
      invC.selectedKelurahan = (idKecamatan.toString() == "1") ? "000" : data['alamat_kelurahan'].toString();
    }
    editController.alamat_jalan.text                        = data['alamat_jalan'].toString();
    editController.alamat_no.text                           = data['alamat_no'].toString();
    editController.alamat_rt.text                           = data['alamat_rt'].toString();
    editController.alamat_rw.text                           = data['alamat_rw'].toString();
    editController.alamat_kodepos.text                      = data['alamat_kodepos'].toString();
    editController.c_luas_tanah_awal.text                   = data['c_luas_tanah_awal']  != "" ? data['c_luas_tanah_awal'].toString() : "";
    editController.c_luas_tanah_akhir.text                  = data['c_luas_tanah_akhir'] != "" ? data['c_luas_tanah_akhir'].toString() : "";
    invC.statusSatuan                                       = (statusInventaris == "0") ? "M2" : data['c_satuan_tanah'].toString();
    invC.selectedStatusTanah                                = (statusInventaris == "0") ? "Hak Milik" : data['c_status_tanah_awal'].toString();
    editController.kondisi_awal.text                        = (statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_awal'].toString();
    invC.selectedKondisi                                    = (statusInventaris == "0") ? data['kondisi'].toString() : data['kondisi_akhir'].toString();
    editController.asal_usul_awal.text                      = (statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_awal'].toString();
    editController.asal_usul_akhir.text                     = (statusInventaris == "0") ? data['asal_usul'].toString() : data['asal_usul_akhir'].toString();
    editController.penggunaan_awal.text                     = (statusInventaris == "0") ? data['a_penggunaan'].toString() : data['penggunaan_awal'].toString();
    editController.penggunaan_pemda_status.text             = data['penggunaan_pemda_status'].toString();
    editController.penggunaan_pemda_akhir.text              = data['penggunaan_pemda_akhir'].toString();
    editController.penggunaan_pemda_nama_pemakai.text       = data['penggunaan_pemda_nama_pemakai'].toString();
    editController.penggunaan_pemda_nama_pemakai_akhir.text = data['penggunaan_pemda_nama_pemakai_akhir'].toString();
    editController.penggunaan_pemda_status_pemakai.text     = data['penggunaan_pemda_status_pemakai'].toString();
    editController.penggunaan_pempus_status.text            = data['penggunaan_pempus_status'].toString();
    editController.penggunaan_pempus_yt.text                = data['penggunaan_pempus_yt'].toString();
    editController.penggunaan_pempus_y_nm.text              = data['penggunaan_pempus_y_nm'].toString();
    editController.penggunaan_pempus_y_doc.text             = data['penggunaan_pempus_y_doc'].toString();
    editController.penggunaan_pempus_t_nm.text              = data['penggunaan_pempus_t_nm'].toString();
    editController.penggunaan_pdl_status.text               = data['penggunaan_pdl_status'].toString();
    editController.penggunaan_pdl_yt.text                   = data['penggunaan_pdl_yt'].toString();
    editController.penggunaan_pdl_y_nm.text                 = data['penggunaan_pdl_y_nm'].toString();
    editController.penggunaan_pdl_y_doc.text                = data['penggunaan_pdl_y_doc'].toString();
    editController.penggunaan_pdl_t_nm.text                 = data['penggunaan_pdl_t_nm'].toString();
    editController.penggunaan_pl_status.text                = data['penggunaan_pl_status'].toString();
    editController.penggunaan_pl_yt.text                    = data['penggunaan_pl_yt'].toString();
    editController.penggunaan_pl_y_nm.text                  = data['penggunaan_pl_y_nm'].toString();
    editController.penggunaan_pl_y_doc.text                 = data['penggunaan_pl_y_doc'].toString();
    editController.penggunaan_pl_t_nm.text                  = data['penggunaan_pl_t_nm'].toString();
    editController.tercatat_ganda_nibar.text                = data['tercatat_ganda_nibar'].toString();
    editController.tercatat_ganda_no_register.text          = data['tercatat_ganda_no_register'].toString();
    editController.tercatat_ganda_kode_barang.text          = data['tercatat_ganda_kode_barang'].toString();
    editController.tercatat_ganda_nama_barang.text          = data['tercatat_ganda_nama_barang'].toString();
    editController.tercatat_ganda_spesifikasi_barang.text   = data['tercatat_ganda_spesifikasi_barang'].toString();
    editController.tercatat_ganda_luas.text                 = data[ 'tercatat_ganda_luas'].toString();
    editController.tercatat_ganda_satuan.text               = data['tercatat_ganda_satuan'].toString();
    editController.tercatat_ganda_perolehan.text            = data['tercatat_ganda_perolehan'].toString();
    editController.tercatat_ganda_tanggal_perolehan.text    = data['tercatat_ganda_tanggal_perolehan'].toString();
    editController.tercatat_ganda_kuasa_pengguna.text       = data['tercatat_ganda_kuasa_pengguna'].toString();
    editController.lat.text                                 = (statusInventaris == "0") ? data['lat_penetapan'].toString() : data['lat_inventaris'].toString();
    editController.long.text                                = (statusInventaris == "0") ? data['long_penetapan'].toString() : data['long_inventaris'].toString();
    editController.lainnya.text                             = data['lainnya'].toString();
    editController.keterangan.text                          = (statusInventaris == "0") ? data['keterangan_penetapan'].toString() : data['keterangan_inventaris'].toString();
    editController.file_nm.text                             = data['file_nm'].toString();
    editController.petugas.text                             = data['petugas'].toString();
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
        title: Text('Edit Inventaris - C'),
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
                                  invC.selectedKategori = id;
                                  print(invC.selectedKategori);
                                });
                              }
                            },
                            selectedItem: invC.selectedKategori != ""
                              ? kategoriController.kategoriList
                                  .where((item) => item['id'].toString() == invC.selectedKategori)
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
                          invC.selectedSatuan = newValue ?? invC.selectedSatuan;
                        });
                      },
                      selectedItem: invC.selectedSatuan != "" ? invC.selectedSatuan : "Pilih satuan",
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
                              value: invC.dropdownPerolehan.keys
                                      .contains(invC.selectedPerolehan)
                                  ? invC.selectedPerolehan
                                  : null,
                              onChanged: (String? newValue) {
                                setState(() {
                                  invC.selectedPerolehan =
                                      newValue ?? invC.selectedPerolehan;
                                });
                              },
                              items: invC.dropdownPerolehan.entries.map((entry) {
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
                        value: invC.statusAtribusi,
                        onChanged: (String? newValue) {
                          setState(() {
                            invC.statusAtribusi = newValue ?? invC.statusAtribusi;
                          });
                        },
                        items: invC.keteranganAtribusi.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invC.keteranganAtribusi.indexOf(item) == 0 ? "1" : "0",
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                    SizedBox(height: 10),
                    invC.statusAtribusi == "1"
                        ? Column(
                            children: [
                              RadioListTile(
                                title:
                                    Text("Tidak diketahui data awal/induknya"),
                                value: "0",
                                groupValue: invC.chooseAtribusi,
                                onChanged: (value) {
                                  setState(() {
                                    invC.chooseAtribusi = value.toString();
                                  });
                                },
                              ),
                              RadioListTile(
                                title: Text(
                                    "Ya, Diketahui data awal/Induknya dan sebutkan data barang awal/induknya"),
                                value: "1",
                                groupValue: invC.chooseAtribusi,
                                onChanged: (value) {
                                  setState(() {
                                    invC.chooseAtribusi = value.toString();
                                  });
                                },
                              ),
                            ],
                          )
                        : SizedBox(),
                    SizedBox(height: 10),
                    invC.chooseAtribusi == "1" 
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
                // Bertingkat/Tidak
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bertingkat/Tidak',
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
                        value: invC.statusBertingkat,
                        onChanged: (String? newValue) {
                          setState(() {
                            invC.statusBertingkat = newValue ?? invC.statusBertingkat;
                          });
                        },
                        items: invC.keteranganBertingkat.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invC.keteranganBertingkat.indexOf(item) == 0 ? "1" : "0",
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15),
                // Beton/Tidak
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Beton/Tidak',
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
                        value: invC.statusBeton,
                        onChanged: (String? newValue) {
                          setState(() {
                            invC.statusBeton = newValue ?? invC.statusBeton;
                          });
                        },
                        items: invC.keteranganBeton.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invC.keteranganBeton.indexOf(item) == 0 ? "1" : "0",
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
                                controller: editController.c_luas_tanah_awal,
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
                            value: invC.statusLuasTanah,
                            onChanged: (String? newValue) {
                              setState(() {
                                invC.statusLuasTanah =
                                    newValue ?? invC.statusLuasTanah;
                              });
                            },
                            items: invC.keteranganLuasTanah.map((String item) {
                              return DropdownMenuItem<String>(
                                value:
                                    invC.keteranganLuasTanah.indexOf(item) == 0
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
                    invC.statusLuasTanah == "2"
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15),
                              child: TextFormField(
                                controller: editController.c_luas_tanah_akhir,
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
                // Satuan Tanah
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
                        value: invC.statusSatuan,
                        onChanged: (String? newValue) {
                          setState(() {
                            invC.statusSatuan = newValue ?? invC.statusSatuan;
                          });
                        },
                        items: invC.keteranganSatuan.map((String item) {
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
                        value: invC.selectedStatusTanah,
                        onChanged: (String? newValue) {
                          setState(() {
                            invC.selectedStatusTanah = newValue ?? invC.selectedStatusTanah;
                          });
                        },
                        items: invC.dropdownStatusTanah.map((String item) {
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
                        value: invC.statusKeberadaanBarang,
                        onChanged: (String? newValue) {
                          setState(() {
                            invC.statusKeberadaanBarang = newValue ?? invC.statusKeberadaanBarang;
                          });
                        },
                        items: invC.keteranganKeberadaanBarang.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invC.keteranganKeberadaanBarang.indexOf(item) == 0 ? "1": "2",
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
                              items: invC.dropdownKondisi.map((String item) {
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
                        value: invC.statusStatus,
                        onChanged: (String? newValue) {
                          setState(() {
                            invC.statusStatus = newValue ?? invC.statusStatus;
                          });
                        },
                        items: invC.keteranganStatus.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invC.keteranganStatus.indexOf(item) == 0 ? "1" : "2",
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
                      groupValue: invC.choosePemerintah,
                      onChanged: (value) {
                        setState(() {
                          invC.choosePemerintah = value.toString();
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
                                    value: invC.statusNamaPemakai,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        invC.statusNamaPemakai = newValue ?? invC.statusNamaPemakai;
                                      });
                                    },
                                    items: invC.keteranganNamaPemakai.map((String item) {
                                      return DropdownMenuItem<String>(
                                        value: invC.keteranganNamaPemakai.indexOf(item) == 0
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
                            invC.statusNamaPemakai == "2"
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
                                  controller: editController.penggunaan_pemda_nama_pemakai_akhir,
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
                                value: invC.statusBast,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    invC.statusBast = newValue ?? invC.statusBast;
                                  });
                                },
                                items: invC.keteranganBast.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: invC.keteranganBast.indexOf(item) == 0 ? "1": "2",
                                    child: Text(item),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        // SIP
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SIP',
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
                                value: invC.statusSIP,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    invC.statusSIP = newValue ?? invC.statusSIP;
                                  });
                                },
                                items: invC.keteranganSIP.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: invC.keteranganSIP.indexOf(item) == 0 ? "1": "2",
                                    child: Text(item),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        // IMB
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'IMB',
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
                                value: invC.statusIMB,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    invC.statusIMB = newValue ?? invC.statusIMB;
                                  });
                                },
                                items: invC.keteranganIMB.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: invC.keteranganIMB.indexOf(item) == 0 ? "1": "2",
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
                      value: "2",
                      groupValue: invC.choosePemerintah,
                      onChanged: (value) {
                        setState(() {
                          invC.choosePemerintah = value.toString();
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
                            value: invC.statusPempus,
                            onChanged: (String? newValue) {
                              setState(() {
                                invC.statusPempus = newValue ?? invC.statusPempus;
                              });
                            },
                            dropdownStyleData: DropdownStyleData(maxHeight: 300),
                            items: [
                              DropdownMenuItem<String>(
                                value: "3",
                                child: Text("Pilih"),
                              ),
                              ...invC.keteranganPempus.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: invC.keteranganPempus.indexOf(item) == 0
                                        ? "1"
                                        : "0",
                                    child: Text(item),
                                  );
                                }).toList(),
                            ],
                          ),
                        ),
                        if(invC.statusPempus == "1")
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
                        if(invC.statusPempus == "0")
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
                      value: "3",
                      groupValue: invC.choosePemerintah,
                      onChanged: (value) {
                        setState(() {
                          invC.choosePemerintah = value.toString();
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
                            value: invC.statusPdl,
                            onChanged: (String? newValue) {
                              setState(() {
                                invC.statusPdl = newValue ?? invC.statusPdl;
                              });
                            },
                            dropdownStyleData: DropdownStyleData(maxHeight: 300),
                            items: [
                              DropdownMenuItem<String>(
                                value: "3",
                                child: Text("Pilih"),
                              ),
                              ...invC.keteranganPdl.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: invC.keteranganPdl.indexOf(item) == 0
                                        ? "1"
                                        : "0",
                                    child: Text(item),
                                  );
                                }).toList(),
                            ],
                          ),
                        ),
                        if(invC.statusPdl == "1")
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
                        if(invC.statusPdl == "0")
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
                      value: "4",
                      groupValue: invC.choosePemerintah,
                      onChanged: (value) {
                        setState(() {
                          invC.choosePemerintah = value.toString();
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
                            value: invC.statusPl,
                            onChanged: (String? newValue) {
                              setState(() {
                                invC.statusPl = newValue ?? invC.statusPl;
                              });
                            },
                            dropdownStyleData: DropdownStyleData(maxHeight: 300),
                            items: [
                              DropdownMenuItem<String>(
                                value: "3",
                                child: Text("Pilih"),
                              ),
                              ...invC.keteranganPl.map((String item) {
                                  return DropdownMenuItem<String>(
                                    value: invC.keteranganPl.indexOf(item) == 0
                                        ? "1"
                                        : "0",
                                    child: Text(item),
                                  );
                                }).toList(),
                            ],
                          ),
                        ),
                        if(invC.statusPl == "1")
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
                        if(invC.statusPl == "0")
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
                        value: invC.statusGanda,
                        onChanged: (String? newValue) {
                          setState(() {
                            invC.statusGanda = newValue ?? invC.statusGanda;
                          });
                        },
                        items: invC.keteranganGanda.map((String item) {
                          return DropdownMenuItem<String>(
                            value: invC.keteranganGanda.indexOf(item) == 0
                                  ? "1"
                                  : "2",
                            child: Text(item),
                          );
                        }).toList(),
                      ),
                    ),
                    invC.statusGanda == "1"
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
                        value: invC.dropdownAtasNama.keys
                                .contains(invC.statusAtasNama)
                            ? invC.statusAtasNama
                            : null,
                        onChanged: (String? newValue) {
                          setState(() {
                            invC.statusAtasNama =
                                newValue ?? invC.statusAtasNama;
                          });
                        },
                        items: invC.dropdownAtasNama.keys.map((String item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(invC.dropdownAtasNama[item]!),
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
                          controller: editController.petugas,
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
                      Get.back();
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
