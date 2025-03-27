// ignore_for_file: constant_identifier_names

import '../../values/values.dart';

abstract class Validators {
  static const int MIN_TITLE_LENGTH = 3;

  /// Returns null if [value] is not null or blank.
  ///
  /// Returns an error String otherwise.
  static String? required(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.errorEmptyField;
    } else {
      return null;
    }
  }

  /// Returns if [email] follows the example@example.example pattern.
  ///
  /// Returns an error String if the pattern is invalid or the [email] is null or blank.
  static String? email(String? email) {
    if (email == null || email.isEmpty) {
      return Strings.errorEmailEmpty;
    } else {
      final isValid = RegExps.email.hasMatch(email);
      return isValid ? null : Strings.errorEmailInvalid;
    }
  }

  /// Returns null if [password] is not null or blank.
  ///
  /// Returns an error String otherwise.
  static String? password(String? password) {
    if (password == null || password.isEmpty) {
      return Strings.errorPasswordEmpty;
    } else {
      final bool isValid = password.length >= 6;
      return isValid ? null : Strings.errorPasswordTooShort;
    }
  }

  /// Returns null if [confirmPassword] is not null or blank or not equals.
  ///
  /// Returns an error String otherwise.
  static String? confirmPassword(String? newPassword, String? retryPassword) {
    final errorPassword = password(newPassword);
    final errorConfirmPassword = password(retryPassword);

    if (errorPassword != null) {
      return errorPassword;
    } else if (errorConfirmPassword != null) {
      return errorConfirmPassword;
    } else {
      final isEquals = newPassword!.compareTo(retryPassword!) == 0;
      return isEquals ? null : Strings.errorConfirmPassword;
    }
  }

  /// Returns null if [name] is not null or blank.
  ///
  /// Returns an error String otherwise.
  static String? name(String? name) {
    if (name == null || name.isEmpty) {
      return Strings.errorEmptyField;
    }
    return null;
  }

  /// Returns if [money] for a valid value.
  ///
  /// Returns an error String if the pattern is invalid or the [money] is null or blank.
  static String? money(double? money) {
    if (money == null) {
      return Strings.errorEmptyField;
    } else {
      return money > 0 ? null : Strings.errorMoneyInvalid;
    }
  }

  /// Returns null if [link] is not null or blank.
  ///
  /// Returns an error String otherwise.
  static String? link(String? link) {
    if (link == null || link.isEmpty) {
      return Strings.errorEmptyField;
    } else {
      final isValid = Uri.parse(link).isAbsolute;
      return isValid ? null : Strings.errorLinkInvalid;
    }
  }

  /// Returns null if [link] is not null or blank.
  ///
  /// Returns an error String otherwise.
  static String? tipTitle(String? value) {
    if (value == null || value.isEmpty) {
      return Strings.errorEmptyField;
    } else {
      final isValid = value.length >= MIN_TITLE_LENGTH;
      return isValid ? null : Strings.errorTipTitleInvalid;
    }
  }
}
