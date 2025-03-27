abstract class CreateLearnMoreState {}

class CreateLearnMoreLoadingState implements CreateLearnMoreState {
  const CreateLearnMoreLoadingState();
}

class CreateLearnMoreSucessState implements CreateLearnMoreState {
  const CreateLearnMoreSucessState();
}

class CreateLearnMoreErrorState implements CreateLearnMoreState {
  final String message;

  const CreateLearnMoreErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateLearnMoreErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
