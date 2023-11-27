class ApiEndPoints {
  // static final String baseurl         = 'http://172.20.10.6:5000/';
  static final String baseurl         = 'https://simasda.server-uing.my.id/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String logout           = 'logout';
  final String getDepartemen    = 'departements';
  final String getKategori      = 'kategori/';
  final String getSatuan        = 'satuan';
  final String getRuangan       = 'ruang/';
  final String getKecamatan     = 'kecamatan';
  final String getKelurahan     = 'kelurahan';
  final String getPenetapan     = 'penetapan/';
  final String getPenetapanById = 'penetapan/inventaris/';
  final String putInventaris    = 'inventaris/';
}
