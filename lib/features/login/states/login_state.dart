abstract class LoginState {}

class LoginInitialState implements LoginState {
  const LoginInitialState();
}

class LoginLoadingState implements LoginState {
  const LoginLoadingState();
}

class LoginSucessState implements LoginState {
  const LoginSucessState();
}

class LoginErrorState implements LoginState {
  final String message;

  const LoginErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoginErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
