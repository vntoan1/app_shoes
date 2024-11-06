class KPlatformException implements Exception {
  final String code;
  KPlatformException(this.code);

  String get message {
    switch(code){
      case 'INVALID_LOGIN_CREDENTIALS':
        return 'Invalid login credentials. Please ...';
      default:
        return 'An unexpected ....';
    }
  }
}