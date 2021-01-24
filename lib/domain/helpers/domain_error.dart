enum DomainError { unexpected, invalidCredentials }

extension DomainErrorExtension on DomainError {
  String get description {
    switch (this) {
      case DomainError.invalidCredentials:
        return 'invalid credentials';
      case DomainError.unexpected:
        return 'unexpectedError';
      default:
        return '';
    }
  }
}
