import '../../../core/core.dart';

abstract class BoxSectionState {}

class BoxSectionLoadingState implements BoxSectionState {
  const BoxSectionLoadingState();
}

class BoxSectionSucessState implements BoxSectionState {
  final UserPackageList custList;

  const BoxSectionSucessState({
    required this.custList,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BoxSectionSucessState && other.custList == custList;
  }

  @override
  int get hashCode => custList.hashCode;

  @override
  String toString() => 'BoxSectionSucessState(custList: $custList)';
}

class BoxSectionErrorState implements BoxSectionState {
  final String message;

  const BoxSectionErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is BoxSectionErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'BoxSectionErrorState(message: $message)';
}
