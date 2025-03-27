import '../../../core/models/models.dart';

abstract class CustomersListState {}

class CustomersListLoadingState implements CustomersListState {
  const CustomersListLoadingState();
}

class CustomersListSucessState implements CustomersListState {
  final CustomersList customes;

  const CustomersListSucessState({
    required this.customes,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomersListSucessState && other.customes == customes;
  }

  @override
  int get hashCode => customes.hashCode;

  @override
  String toString() => 'CustomersListSucessState(customes: $customes)';
}

class CustomersListErrorState implements CustomersListState {
  final String message;

  const CustomersListErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomersListErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'CustomersListErrorState(message: $message)';
}
