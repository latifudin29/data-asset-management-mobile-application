class InventoryVariablesB {
  String statusInventaris       = "";
  String statusNoRegister       = "";
  String statusBarang           = "";
  String statusNamaBarang       = "";
  String statusPerolehan        = "";
  String statusNilaiPerolehan   = "";
  String statusAlamat           = "";
  String statusMerk             = "";
  String statusCC               = "";
  String statusNoPolisi         = "";
  String statusNoRangka         = "";
  String statusNoMesin          = "";
  String statusNoBPKB           = "";
  String statusBahan            = "";
  String statusNoPabrik         = "";
  String statusKartuRuangan     = "";
  String statusKondisi          = "";
  String statusAsalUsul         = "";
  String statusAtribusi         = "";
  String statusKeberadaanBarang = "";
  String statusPenggunaanStatus = "";
  String statusGanda            = "";
  String statusAtasNama         = "";
  String statusQRBarang         = "";
  String statusQRRuangan        = "";
  String statusNamaPemakai      = "";
  String statusBast             = "";
  String statusPempus           = "";
  String statusPdl              = "";
  String statusPl               = "";

  String chooseAtribusi             = "";
  String choosePemerintahDaerah     = "";
  String choosePemerintahPusat      = "";
  String choosePemerintahDaerahLain = "";
  String choosePihakLain            = "";

  String selectedKategori         = "";
  String selectedSatuan           = "";
  String selectedPerolehan        = "";
  String selectedKecamatan        = "";
  String selectedKelurahan        = "";
  String selectedKondisi          = "";
  String selectedKeberadaanBarang = "";
  String selectedKartuRuangan     = "";

  List<String> keteranganNoRegister       = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganBarang           = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNamaBarang       = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganPerolehan        = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNilaiPerolehan   = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganAlamat           = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganMerk             = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganCC               = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoPolisi         = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoRangka         = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoMesin          = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoBPKB           = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganBahan            = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoPabrik         = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganKartuRuangan     = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganKondisi          = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganAsalUsul         = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNamaPemakai      = ["Sesuai", "Tidak Sesuai"];

  List<String> barcodeBarang              = ["Ada", "Tidak"];
  List<String> barcodeRuang               = ["Ada", "Tidak"];

  List<String> keteranganBast             = ["Ada", "Tidak"];
  List<String> keteranganAtribusi         = ["Ya", "Bukan"];
  List<String> keteranganKeberadaanBarang = ["Ada", "Tidak"];
  List<String> keteranganStatus           = ["Sedang digunakan", "Tidak digunakan"];
  List<String> keteranganGanda            = ["Ya", "Tidak"];
  List<String> keteranganPempus           = ["Ada", "Tidak"];
  List<String> keteranganPdl              = ["Ada", "Tidak"];
  List<String> keteranganPl               = ["Ada", "Tidak"];

  Map<String, String> dropdownKondisi = {
    "B"  : "B",
    "RR" : "RR",
    "RB" : "RB",
    "TGR": "TGR",
    "AK" : "AK",
    "KB" : "KB",
    "BJ" : "Barang dan Jasa"
  };

  Map<String, String> dropdownPerolehan = {
    "1": "Pembelian",
    "2": "Hibah",
    "3": "Barang & Jasa",
    "4": "Hasil Inventarisasi",
  };

  Map<String, String> dropdownKeberadaanBarang = {
    "1": "Pilih",
    "2": "Hilang",
    "3": "Tidak Ditemukan",
    "4": "Mutasi",
    "5": "Hibah",
    "6": "Penjualan",
    "7": "Penghapusan"
  };

  Map<String, String> dropdownAtasNama = {
    "1": "Pemerintah Daerah",
    "2": "Pemerintah Daerah Lainnya",
    "3": "Pemerintah Pusat",
    "4": "Pihak Lain"
  };
}