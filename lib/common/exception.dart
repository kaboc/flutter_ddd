class GenericException implements Exception {
  final String message;

  GenericException(this.message) : assert(message != null);

  @override
  String toString() => message;
}

class NotFoundException extends GenericException {
  NotFoundException(String info)
      : assert(info != null),
        super((info.isEmpty ? '' : info + '\n') + 'is not found.');
}

class NotUniqueException extends GenericException {
  NotUniqueException(String info)
      : assert(info != null),
        super((info.isEmpty ? '' : info + '\n') + 'already exists.');
}

class NullEmptyException extends GenericException {
  NullEmptyException(String info)
      : assert(info != null),
        super((info.isEmpty ? '' : info + '\n') + 'must not be null or empty.');
}
