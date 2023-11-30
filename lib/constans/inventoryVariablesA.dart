class InventoryVariablesA {
  String statusInventaris           = "";
  String statusNoRegister           = "";
  String statusBarang               = "";
  String statusNamaBarang           = "";
  String statusJumlah               = "";
  String statusLuas                 = "";
  String statusPerolehan            = "";
  String statusNilaiPerolehan       = "";
  String statusAlamat               = "";
  String statusHakTanah             = "";
  String statusNoSertifikat         = "";
  String statusTglSertifikat        = "";
  String statusKondisi              = "";
  String statusAsalUsul             = "";
  String statusAtribusi             = "";
  String statusKeberadaanBarang     = "";
  String statusStatus               = "";
  String statusAtasNama             = "";
  String statusNamaPemakai          = "";
  String statusPempus               = "";
  String statusPdl                  = "";
  String statusPl                   = "";
  String statusGanda                = "";
  
  String chooseAtribusi             = "";
  String choosePemerintahDaerah     = "";
  String choosePemerintahPusat      = "";
  String choosePemerintahDaerahLain = "";
  String choosePihakLain            = "";

  String selectedKategori  = "";
  String selectedSatuan    = "";
  String selectedPerolehan = "";
  String selectedKecamatan = "";
  String selectedKelurahan = "";
  String selectedKondisi   = "";

  List<String> keteranganNoRegister     = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganBarang         = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNamaBarang     = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganJumlah         = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganLuas           = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganPerolehan      = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNilaiPerolehan = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganAlamat         = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganHakTanah       = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganNoSertifikat   = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganTglSertifikat  = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganKondisi        = ["Sesuai", "Tidak Sesuai"];
  List<String> keteranganAsalUsul       = ["Sesuai", "Tidak Sesuai"];

  List<String> dropdownKondisi            = ["B", "RR", "RB", "TGR", "AK", "KB"];
  List<String> keteranganAtribusi         = ["Ya", "Bukan"];
  List<String> keteranganKeberadaanBarang = ["Ada", "Tidak ada/Tidak ditemukan"];
  List<String> keteranganStatus           = ["Sedang digunakan", "Tidak digunakan"];
  List<String> keteranganGanda            = ["Ya", "Tidak"];
  List<String> keteranganPempus           = ["Ada", "Tidak"];
  List<String> keteranganPdl              = ["Ada", "Tidak"];
  List<String> keteranganPl               = ["Ada", "Tidak"];

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
