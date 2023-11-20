class ApiEndPoints {
  static final String baseurl = 'https://simasda.server-uing.my.id/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String login = 'login';
  final String logout = 'logout';
  final String getDepartemen = 'departements';
  final String getKategori = 'kategori/';
  final String getSatuan = 'satuan';
  final String getPenetapan = 'penetapan/';
  final String getPenetapanById = 'penetapan/';
}
