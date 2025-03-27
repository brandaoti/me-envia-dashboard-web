abstract class DollarState {}

class DollarLoadingState implements DollarState {
  const DollarLoadingState();
}

class DollarSucessState implements DollarState {
  final double money;
  const DollarSucessState(this.money);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DollarSucessState && other.money == money;
  }

  @override
  int get hashCode => money.hashCode;

  @override
  String toString() => 'DollarSucessState(money: $money)';
}

class DollarErrorState implements DollarState {
  final String message;
  const DollarErrorState({required this.message});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DollarErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'DollarErrorState(message: $message)';
}
