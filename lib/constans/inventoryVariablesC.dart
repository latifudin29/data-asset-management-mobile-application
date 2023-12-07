class InventoryVariablesC {
  String statusInventaris       = "";
  String statusNoRegister       = "";
  String statusBarang           = "";
  String statusNamaBarang       = "";
  String statusLuasLantai       = "";
  String statusPerolehan        = "";
  String statusNilaiPerolehan   = "";
  String statusAlamat           = "";
  String statusLuasBangunan     = "";
  String statusLuasTanah        = "";
  String statusKondisi          = "";
  String statusAsalUsul         = "";
  String statusAtribusi         = "";
  String statusKeberadaanBarang = "";
  String statusPenggunaanStatus = "";
  String statusAtasNama         = "";
  String statusNamaPemakai      = "";
  String statusBast             = "";
  String statusSIP              = "";
  String statusIMB              = "";
  String statusPempus           = "";
  String statusPdl              = "";
  String statusPl               = "";
  String statusGanda            = "";
  String statusBertingkat       = "";
  String statusBeton            = "";
  String statusSatuanBangunan   = "";
  String statusSatuanTanah      = "";

  String chooseAtribusi             = "";
  String choosePemerintahDaerah     = "";
  String choosePemerintahPusat      = "";
  String choosePemerintahDaerahLain = "";
  String choosePihakLain            = "";

  String selectedKategori    = "";
  String selectedSatuan      = "";
  String selectedPerolehan   = "";
  String selectedKecamatan   = "";
  String selectedKelurahan   = "";
  String selectedKondisi     = "";
  String selectedStatusTanah = "";

  List<String> keteranganNoRegister       = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganBarang           = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNamaBarang       = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganLuasLantai       = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganPerolehan        = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNilaiPerolehan   = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganAlamat           = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganLuasBangunan     = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganLuasTanah        = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganKondisi          = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganAsalUsul         = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNamaPemakai      = ["Sesuai", "Tidak Sesuai"];

  List<String> dropdownKondisi            = ["B", "RR", "RB", "TGR", "AK", "KB"];
  List<String> keteranganAtribusi         = ["Ya", "Bukan"];
  List<String> keteranganBast             = ["Ada", "Tidak"];
  List<String> keteranganSIP              = ["Ada", "Tidak"];
  List<String> keteranganIMB              = ["Ada", "Tidak"];
  List<String> keteranganKeberadaanBarang = ["Ada", "Tidak ada, tidak ditemukan"];
  List<String> keteranganStatus           = ["Sedang digunakan", "Tidak digunakan"];
  List<String> keteranganGanda            = ["Ya", "Tidak"];
  List<String> keteranganPempus           = ["Ada", "Tidak"];
  List<String> keteranganPdl              = ["Ada", "Tidak"];
  List<String> keteranganPl               = ["Ada", "Tidak"];
  List<String> keteranganBertingkat       = ["Bertingkat", "Tidak Bertingkat"];
  List<String> keteranganBeton            = ["Beton", "Tidak Beton"];
  List<String> keteranganSatuanTanah      = ["KM", "M", "M2"];

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
