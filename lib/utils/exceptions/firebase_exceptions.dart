class KFirebaseException implements Exception {
  final String code;
  KFirebaseException(this.code);

  String get message {
    switch(code){
      case 'email-already-in-use':
        return 'The email address is already registered. Please ...';
      default:
        return 'An unexpected ....';
    }
  }
}