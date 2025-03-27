abstract class ForgotPasswordState {}

class ForgotPasswordInitialState implements ForgotPasswordState {
  const ForgotPasswordInitialState();
}

class ForgotPasswordLoadingState implements ForgotPasswordState {
  const ForgotPasswordLoadingState();
}

class ForgotPasswordSucessState implements ForgotPasswordState {
  const ForgotPasswordSucessState();
}

class ForgotPasswordErrorState implements ForgotPasswordState {
  final String message;

  const ForgotPasswordErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ForgotPasswordErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
