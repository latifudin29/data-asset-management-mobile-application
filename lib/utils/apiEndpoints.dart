class ApiEndPoints {
  // static final String baseurl         = 'http://10.8.59.26:5000/';
  static final String baseurl         = 'https://simasda.server-uing.my.id/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String logout           = 'logout';
  final String getDepartemen    = 'departements';
  final String getKategori      = 'kategori/';
  final String getSatuan        = 'satuan';
  final String getRuangan       = 'ruang/';
  final String getKuasa         = 'kuasa/';
  final String getKecamatan     = 'kecamatan';
  final String getKelurahan     = 'kelurahan';
  final String getPenetapan     = 'penetapan/';
  final String getPenetapanById = 'penetapan/inventaris/';
  final String postInventaris   = 'inventaris/add/';
  final String putInventaris    = 'inventaris/edit/';
}