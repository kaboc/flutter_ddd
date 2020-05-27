import 'package:meta/meta.dart';

class GenericException implements Exception {
  final ExceptionCode code;
  final dynamic info;

  GenericException({this.code = ExceptionCode.unknown, this.info});

  @override
  String toString() {
    return '$runtimeType: ${code.value}';
  }

  String get message {
    switch (runtimeType) {
      case NotFoundException:
        return '${code.value}: $info\nis not found.';
      case NotUniqueException:
        return '${code.value}: $info\nalready exists.';
      case NullEmptyException:
        return '${code.value}\nmust not be null or empty.';
      case LengthException:
        return '${code.value} must be $info letters or shorter.';
      case RemovalException:
        return code == ExceptionCode.category
            ? 'Cannot be removed;\nthis category contains notes.'
            : 'Cannot be removed';
      default:
        return 'Unknown error occurred.';
    }
  }
}

class NotFoundException extends GenericException {
  NotFoundException({@required ExceptionCode code, @required String target})
      : assert(code != null),
        assert(target != null && target.isNotEmpty),
        super(code: code, info: target);
}

class NotUniqueException extends GenericException {
  NotUniqueException({@required ExceptionCode code, @required String value})
      : assert(code != null),
        assert(value != null && value.isNotEmpty),
        super(code: code, info: value);
}

class NullEmptyException extends GenericException {
  NullEmptyException({@required ExceptionCode code})
      : assert(code != null),
        super(code: code);
}

class LengthException extends GenericException {
  LengthException({@required ExceptionCode code, @required int max})
      : assert(code != null),
        assert(max != null && max > 0),
        super(code: code, info: max);
}

class RemovalException extends GenericException {
  RemovalException({@required ExceptionCode code})
      : assert(code != null),
        super(code: code);
}

enum ExceptionCode {
  unknown,
  category,
  categoryId,
  categoryName,
  note,
  noteId,
  noteTitle,
}

extension ExceptionCodeValue on ExceptionCode {
  String get value {
    switch (this) {
      case ExceptionCode.category:
        return 'Category';
      case ExceptionCode.categoryId:
        return 'Category ID';
      case ExceptionCode.categoryName:
        return 'Category name';
      case ExceptionCode.note:
        return 'Note';
      case ExceptionCode.noteId:
        return 'Note ID';
      case ExceptionCode.noteTitle:
        return 'Note title';
      default:
        return 'Unknown';
    }
  }
}
