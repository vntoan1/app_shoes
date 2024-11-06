class KFormatException implements Exception {
  final String message;
  const KFormatException([this.message = 'An unexpected format error occurred']);

  factory KFormatException.fromMessage(String message){
    return KFormatException(message);
  }
  String get formattedMessage => message;
  factory KFormatException.fromCode(String code){
    switch(code){
      case 'invalid-email-format':
        return const KFormatException('The email address is already registered. Please ...');
      default:
        return const KFormatException('An unexpected ....');
    }
  }
}