import '../../../core/core.dart';

abstract class LoadPackageItensState {}

class LoadPackageItensLoadingState implements LoadPackageItensState {
  const LoadPackageItensLoadingState();
}

class LoadPackageItensSuccessState implements LoadPackageItensState {
  final BoxList boxList;

  const LoadPackageItensSuccessState({
    required this.boxList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadPackageItensSuccessState && other.boxList == boxList;
  }

  @override
  int get hashCode => boxList.hashCode;
}

class LoadPackageItensErrorState implements LoadPackageItensState {
  final String? message;

  const LoadPackageItensErrorState({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadPackageItensErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
