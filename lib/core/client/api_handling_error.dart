import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../core.dart';

abstract class ApiHandlingError {
  ApiClientError mappingErrors(dynamic error);

  ApiClientError mappingDioErrors(String endPoint, DioError error);
}

class RepositoryErrorHandling implements ApiHandlingError {
  const RepositoryErrorHandling();

  @override
  Failure mappingErrors(dynamic error) {
    return Failure(message: error.toString());
  }

  @override
  ApiClientError mappingDioErrors(String endPoint, DioError error) {
    if (endPoint == 'login') {
      _loginMappinErrors(error);
    }

    if (endPoint == 'createUser') {
      _createUserMappinErrors(error);
    }

    if (endPoint == 'getUser') {
      _getUserMappinErrors(error);
    }

    if (endPoint == 'forgotPassword') {
      _forgotPasswordMappinErrors(error);
    }

    if (endPoint == 'createPackage') {
      _createPackageMappinErrors(error);
    }

    if (endPoint == 'getPackageUser') {
      _getPackageUserMappinErrors(error);
    }

    if (endPoint == 'getReport') {
      _getReportMappinErrors(error);
    }

    if (error.response?.statusCode == 412) {
      _handleLogout();

      throw Failure(
        message: error.response?.data['error'] ?? error.message,
      );
    }

    if (error.response?.statusCode == 500) {
      throw NotFoundUser(
        message: error.response?.data['error'] ?? Strings.errorUnknownInApi,
      );
    }

    throw Failure(
      message: error.response?.data['error'] ?? error.message,
    );
  }

  void _handleLogout() async {
    await Modular.get<AuthController>().logout();
  }

  ApiClientError? _loginMappinErrors(DioError error) {
    if (error.response?.statusCode == 400) {
      throw EmailNotVerified(
        message: Strings.errorUserCreationFailed,
      );
    }

    if (error.response?.statusCode == 401) {
      throw InvalidCredentials(
        message: Strings.errorUserCreationFailed,
      );
    }
  }

  ApiClientError? _getUserMappinErrors(DioError error) {
    if (error.response?.statusCode == 404) {
      throw NotFoundUser(
        message: Strings.errorUserNotFound,
      );
    }
  }

  ApiClientError? _createUserMappinErrors(DioError error) {
    final String? errorMessage = error.response?.data['error'];

    if (error.response?.statusCode == 400) {
      throw InvalidArgument(
        message: errorMessage ?? error.message,
      );
    }

    if (error.response?.statusCode == 403) {
      final hasAdminSecurityCodeError = errorMessage?.contains(
        Strings.errorAdminSecurityCodeInvalid,
      );

      if (hasAdminSecurityCodeError ?? false) {
        throw AdminSecurityCodeInvalid(
          message: Strings.errorAdminSecurityCodeInvalid,
        );
      }

      throw AlreadyRegisteredUser(
        message: Strings.errorAlreadyRegisteredUser,
      );
    }
  }

  ApiClientError? _forgotPasswordMappinErrors(DioError error) {
    if (error.response?.statusCode == 400) {
      throw NotFoundUser(
        message: Strings.errorEmailNotExists,
      );
    }
  }

  ApiClientError? _createPackageMappinErrors(DioError error) {
    if (error.response?.statusCode == 400) {
      throw NotFoundUser(
        message: Strings.errorNotCreateItem,
      );
    }

    if (error.response?.statusCode == 403) {
      throw NotFoundUser(
        message: Strings.errorRequiredUserAdmin,
      );
    }

    if (error.response?.statusCode == 404) {
      throw NotFoundUser(
        message: Strings.errorAlreadyRegisteredUser,
      );
    }
  }

  ApiClientError? _getPackageUserMappinErrors(DioError error) {
    if (error.response?.statusCode == 403) {
      throw UnauthorizedPackage(
        message: Strings.errorUnauthorizedPackage,
      );
    }
    if (error.response?.statusCode == 404) {
      throw UnauthorizedPackage(
        message: Strings.errorNotFoundPackage,
      );
    }
  }

  ApiClientError? _getReportMappinErrors(DioError error) {
    if (error.response?.statusCode == 403) {
      throw UnauthorizedPackage(
        message: Strings.errorUnauthorizedPackage,
      );
    }
  }
}
