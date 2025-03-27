import '../../../core/models/general_information/customers_package.dart';

abstract class GetPackageState {}

class GetPackageLoadingState implements GetPackageState {
  const GetPackageLoadingState();
}

class GetPackageSuccessState implements GetPackageState {
  final CustomersPackage package;

  GetPackageSuccessState({
    required this.package,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetPackageSuccessState && other.package == package;
  }

  @override
  int get hashCode => package.hashCode;
}

class GetPackageErrorState implements GetPackageState {
  final String? message;

  const GetPackageErrorState({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GetPackageErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
