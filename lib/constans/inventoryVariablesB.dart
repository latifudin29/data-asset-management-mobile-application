class InventoryVariablesB {
  String statusNoRegister     = "";
  String statusBarang         = "";
  String statusNamaBarang     = "";
  String statusPerolehan      = "";
  String statusNilaiPerolehan = "";
  String statusAlamat         = "";
  String statusKondisi        = "";
  String statusAsalUsul       = "";
  String statusMerk           = "";
  String statusCC             = "";
  String statusNoPolisi       = "";
  String statusNoRangka       = "";
  String statusNoMesin        = "";
  String statusNoBPKB         = "";
  String statusBahan          = "";
  String statusNoPabrik       = "";
  String statusKartuRuangan   = "";

  String selectedKategori     = "";
  String selectedSatuan       = "";
  String selectedPerolehan    = "";
  String selectedKartuRuangan = "";
  String selectedKecamatan    = "";
  String selectedKelurahan    = "";
  String selectedKondisi      = "";

  List<String> keteranganNoRegister     = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganBarang         = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNamaBarang     = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganPerolehan      = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNilaiPerolehan = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganAlamat         = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganMerk           = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganCC             = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoPolisi       = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoRangka       = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoMesin        = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoBPKB         = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganBahan          = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoPabrik       = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganKartuRuangan   = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganKondisi        = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganAsalUsul       = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNamaPemakai    = ["Sesuai", "Tidak Sesuai"];

  Map<String, String> dropdownPerolehan = {
    "1": "Pembelian",
    "2": "Hibah",
    "3": "Barang & Jasa",
    "4": "Hasil Inventarisasi",
  };

  Map<String, String> dropdownAtasNama = {
    "1": "Pemerintah Daerah",
    "2": "Pemerintah Daerah Lainnya",
    "3": "Pemerintah Pusat",
    "4": "Pihak Lain"
  };
  
  List<String> barcodeBarang              = ["Ada", "Tidak"];
  List<String> barcodeRuang               = ["Ada", "Tidak"];
  List<String> keteranganBast             = ["Ada", "Tidak"];
  List<String> dropdownKondisi            = ["B", "RR", "RB", "TGR", "AK", "KB"];
  List<String> keteranganAtribusi         = ["Ya", "Bukan"];
  List<String> keteranganKeberadaanBarang = ["Ada", "Tidak"];
  List<String> keteranganStatus           = ["Sedang digunakan", "Tidak digunakan"];
  List<String> keteranganGanda            = ["Ya", "Tidak"];
  List<String> keteranganPempus           = ["Ada", "Tidak"];
  List<String> keteranganPdl              = ["Ada", "Tidak"];
  List<String> keteranganPl               = ["Ada", "Tidak"];

  String statusAtribusi         = "";
  String statusKeberadaanBarang = "";
  String statusStatus           = "";
  String statusGanda            = "";
  String statusAtasNama         = "";
  String statusQRBarang         = "";
  String statusQRRuangan        = "";
  String statusNamaPemakai      = "";
  String statusBast             = "";
  String statusPempus           = "";
  String statusPdl              = "";
  String statusPl               = "";
  String chooseAtribusi         = "";
  String choosePemerintah       = "";

}