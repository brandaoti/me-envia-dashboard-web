import '../../../core/models/models.dart';

abstract class CustomersItemsState {}

class CustomersItemsLoadingState implements CustomersItemsState {
  const CustomersItemsLoadingState();
}

class CustomesItemsSucessState implements CustomersItemsState {
  final UserItems userItems;

  const CustomesItemsSucessState({
    required this.userItems,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomesItemsSucessState && other.userItems == userItems;
  }

  @override
  int get hashCode => userItems.hashCode;

  @override
  String toString() => 'CustomesSucessState(customes: $userItems)';
}

class CustomesItemsErrorState implements CustomersItemsState {
  final String message;

  const CustomesItemsErrorState({
    required this.message,
  });

  @override
  String toString() => 'CustomesErrorState(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomesItemsErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
