abstract class ChangePasswordState {}

class ChangePasswordInitialState implements ChangePasswordState {
  const ChangePasswordInitialState();
}

class ChangePasswordLoadingState implements ChangePasswordState {
  const ChangePasswordLoadingState();
}

class ChangePasswordSucessState implements ChangePasswordState {
  const ChangePasswordSucessState();
}

class ChangePasswordErrorState implements ChangePasswordState {
  final String message;

  const ChangePasswordErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ChangePasswordErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
