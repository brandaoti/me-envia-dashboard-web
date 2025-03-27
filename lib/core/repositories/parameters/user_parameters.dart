enum UserParameters { created, paid, sent }

extension UserParametersExtension on UserParameters {
  String get value {
    switch (this) {
      case UserParameters.created:
        return 'created';
      case UserParameters.paid:
        return 'paid';
      case UserParameters.sent:
        return 'sent';
      default:
        return 'created';
    }
  }

  String get fromApi {
    return '?section=$value';
  }
}

extension JsonUserParametersExtension on String {
  UserParameters get fromParams {
    if (this == UserParameters.created.value) {
      return UserParameters.created;
    } else if (this == UserParameters.paid.value) {
      return UserParameters.paid;
    } else if (this == UserParameters.sent.value) {
      return UserParameters.sent;
    } else {
      return UserParameters.created;
    }
  }
}
