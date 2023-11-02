class ApiEndPoints {
  static final String baseurl = 'https://simasda.server-uing.my.id/';
  // static final String baseurl = 'http://172.20.10.6:5000/';
  static _AuthEndPoints authEndPoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String login = 'login';
  final String logout = 'logout';
  final String getDepartemen = 'departements';
  final String getPenetapan = 'penetapan/';
  final String getPenetapanById = 'penetapan/';
}
