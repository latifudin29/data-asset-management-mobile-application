class InventoryVariablesD {
  String statusNoRegister     = "";
  String statusBarang         = "";
  String statusNamaBarang     = "";
  String statusPerolehan      = "";
  String statusNilaiPerolehan = "";
  String statusAlamat         = "";
  String statusKondisi        = "";
  String statusAsalUsul       = "";

  String statusAtribusi         = "";
  String statusKeberadaanBarang = "";
  String statusStatus           = "";
  String statusAtasNama         = "";
  String statusPempus           = "";
  String statusPdl              = "";
  String statusPl               = "";
  String statusGanda            = "";

  String statusPengkerasanJalan = "";
  String statusBahanJembatan     = "";
  String statusNoRuasJalan       = "";
  String statusNoJaringanIrigasi = "";
  String statusKonstruksi        = "";
  String statusPanjang           = "";
  String statusLebar             = "";
  String statusLuas              = "";

  String chooseAtribusi         = "";
  String choosePemerintah       = "";

  String selectedKategori    = "";
  String selectedSatuan      = "";
  String selectedPerolehan   = "";
  String selectedKecamatan   = "";
  String selectedKelurahan   = "";
  String selectedKondisi     = "";
  String selectedStatusTanah = "";

  String selectedPanjang = "";
  String selectedLebar   = "";
  String selectedLuas    = "";

  List<String> keteranganNoRegister     = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganBarang         = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNamaBarang     = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganPerolehan      = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNilaiPerolehan = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganAlamat         = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganKondisi        = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganAsalUsul       = ["Sesuai", "Tidak Sesuai"];

  List<String> keteranganPengkerasanJalan    = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganBahanJembatan     = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoRuasJalan       = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoJaringanIrigasi = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganKonstruksi        = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganPanjang           = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganLebar             = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganLuas              = ["Sesuai", "Tidak Sesuai"];

  List<String> dropdownKondisi            = ["B", "RR", "RB", "TGR", "AK", "KB"];
  List<String> keteranganAtribusi         = ["Ya", "Bukan"];
  List<String> keteranganKeberadaanBarang = ["Ada", "Tidak ada/Tidak ditemukan"];
  List<String> keteranganStatus           = ["Sedang digunakan", "Tidak digunakan"];
  List<String> keteranganGanda            = ["Ya", "Tidak"];
  List<String> keteranganPempus           = ["Ada", "Tidak"];
  List<String> keteranganPdl              = ["Ada", "Tidak"];
  List<String> keteranganPl               = ["Ada", "Tidak"];
  List<String> keteranganSatuanPanjang    = ["KM", "M", "M2"];
  List<String> keteranganSatuanLebar      = ["KM", "M", "M2"];
  List<String> keteranganSatuanLuas       = ["KM", "M", "M2"];

  List<String> dropdownStatusTanah = [
    "Hak Milik",
    "Hak Guna Usaha",
    "Hak Guna Bangunan",
    "Hak Pakai",
    "Hak Sewa",
    "Hak Membuka Tanah",
    "Hak Memungut Hasil Hutan"
  ];

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
}
