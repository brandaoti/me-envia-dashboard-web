import '../../../core/models/models.dart';

abstract class GeneralInformationState {}

class GeneralInformationLoadingState implements GeneralInformationState {
  const GeneralInformationLoadingState();
}

class GeneralInformationSucessState implements GeneralInformationState {
  final List<Faq> faq;
  final MariaInformation whoIsMaria;
  final MariaInformation ourService;
  final MariaInformation serviceFees;

  const GeneralInformationSucessState({
    required this.whoIsMaria,
    required this.ourService,
    required this.serviceFees,
    required this.faq,
  });

  GeneralInformationSucessState copyWith({
    MariaInformation? whoIsMaria,
    MariaInformation? ourService,
    MariaInformation? serviceFees,
    List<Faq>? faq,
  }) {
    return GeneralInformationSucessState(
      whoIsMaria: whoIsMaria ?? this.whoIsMaria,
      ourService: ourService ?? this.ourService,
      serviceFees: serviceFees ?? this.serviceFees,
      faq: faq ?? this.faq,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeneralInformationSucessState &&
        other.whoIsMaria == whoIsMaria &&
        other.ourService == ourService &&
        other.serviceFees == serviceFees;
  }

  @override
  int get hashCode =>
      whoIsMaria.hashCode ^ ourService.hashCode ^ serviceFees.hashCode;
}

class GeneralInformationErrorState implements GeneralInformationState {
  final String message;

  const GeneralInformationErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is GeneralInformationErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
