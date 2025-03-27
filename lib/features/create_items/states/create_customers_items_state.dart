abstract class CreateCustomersItemsState {}

class CreateCustomersItemsLoadingState implements CreateCustomersItemsState {
  const CreateCustomersItemsLoadingState();
}

class CreateCustomersItemsSucessState implements CreateCustomersItemsState {
  const CreateCustomersItemsSucessState();
}

class CreateCustomersItemsErrorState implements CreateCustomersItemsState {
  final String message;

  const CreateCustomersItemsErrorState({
    required this.message,
  });

  @override
  String toString() => 'CreateCustomersItemsErrorState(message: $message)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateCustomersItemsErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
