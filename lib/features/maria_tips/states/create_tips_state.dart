abstract class CreateTipsState {}

class CreateTipsLoadingState implements CreateTipsState {
  const CreateTipsLoadingState();
}

class CreateTipsSucessState implements CreateTipsState {
  final int section;

  const CreateTipsSucessState({
    this.section = 0,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateTipsSucessState && other.section == section;
  }

  @override
  int get hashCode => section.hashCode;

  @override
  String toString() => 'CreateTipsSucessState(section: $section)';
}

class CreateTipsErrorState implements CreateTipsState {
  final String message;

  const CreateTipsErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateTipsErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
