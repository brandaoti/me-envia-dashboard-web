abstract class ApiClientError implements Exception {
  String? get message;
}

class Failure extends ApiClientError {
  @override
  final String? message;

  Failure({
    this.message,
  });

  @override
  String toString() => 'Failure(message: $message)';
}

class ConnectionFailure implements ApiClientError {
  @override
  final String? message;

  ConnectionFailure({
    this.message,
  });

  @override
  String toString() => 'ConnectionFailure(message: $message)';
}

class AlreadyRegisteredUser extends ApiClientError {
  @override
  final String? message;

  AlreadyRegisteredUser({
    this.message,
  });

  @override
  String toString() => 'AlreadyRegisteredUser(message: $message)';
}

class AdminSecurityCodeInvalid extends ApiClientError {
  @override
  final String? message;

  AdminSecurityCodeInvalid({
    this.message,
  });

  @override
  String toString() => 'AdminSecurityCodeInvalid(message: $message)';
}

class NotFoundUser extends ApiClientError {
  @override
  final String? message;

  NotFoundUser({
    this.message,
  });

  @override
  String toString() => 'NotFoundUser(message: $message)';
}

class InvalidArgument extends ApiClientError {
  @override
  final String? message;
  InvalidArgument({this.message});

  @override
  String toString() => 'InvalidArgument(message: $message)';
}

class EmailNotVerified extends ApiClientError {
  @override
  final String? message;
  EmailNotVerified({this.message});

  @override
  String toString() => 'EmailNotVerified(message: $message)';
}

class InvalidCredentials extends ApiClientError {
  @override
  final String? message;

  InvalidCredentials({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is InvalidCredentials && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'InvalidCredentials(message: $message)';
}

class InvalidFile extends ApiClientError {
  @override
  final String? message;

  InvalidFile({this.message});

  @override
  String toString() => 'InvalidFile(message: $message)';
}

class UnauthorizedPackage extends ApiClientError {
  @override
  final String? message;
  UnauthorizedPackage({this.message});

  @override
  String toString() => 'UnauthorizedPackage(message: $message)';
}
