abstract class TrackingCodeState {}

class TrackingCodeInitialState implements TrackingCodeState {
  const TrackingCodeInitialState();
}

class TrackingCodeLoadingState implements TrackingCodeState {
  const TrackingCodeLoadingState();
}

class TrackingCodeSuccessState implements TrackingCodeState {
  final String trackingCode;

  const TrackingCodeSuccessState({
    required this.trackingCode,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrackingCodeSuccessState &&
        other.trackingCode == trackingCode;
  }

  @override
  int get hashCode => trackingCode.hashCode;

  @override
  String toString() => 'TrackingCodeSuccessState(trackingCode: $trackingCode)';
}

class TrackingCodeErrorState implements TrackingCodeState {
  final String? message;

  const TrackingCodeErrorState({
    this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TrackingCodeErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
