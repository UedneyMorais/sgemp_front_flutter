class Endpoints {
  //Server
  static const String _hostAddress = '192.168.77.36';
  //static const String _hostAddress = 'ulehome.ddns.net';
  String get hostAddress => _hostAddress;

  static const String _hostPort = '8081';
  String get hostPort => _hostPort;

  String _autorith = '';
  String get autorith => _autorith;

  static const String _apiVersion = '/api/v1';
  String get apiVersion => _apiVersion;

  Endpoints() {
    setAutority();
  }

  static const String _login = '/auth/authenticate';
  String get login => _login;

  static const String _findUserByEmail = '/user/email/{email}';
  String get findUserByEmail => _findUserByEmail;

  void setAutority() {
    _autorith = '$_hostAddress:$_hostPort';
  }

  String getUri({required String endpoint}) {
    return '$_apiVersion$endpoint';
  }
}
