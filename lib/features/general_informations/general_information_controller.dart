import 'package:rxdart/rxdart.dart';

import '../../core/core.dart';

import 'states/general_information_states.dart';

abstract class GeneralInformationController {
  Stream<GeneralInformationState> get generalInformationStateStream;

  Future<void> handleRemoveFaq(String faqId);

  Future<void> init();
  void dispose();
}

class GeneralInformationControllerImpl implements GeneralInformationController {
  final AuthRepository authRepository;

  GeneralInformationControllerImpl({
    required this.authRepository,
  });

  final _generalInformationSubject =
      BehaviorSubject<GeneralInformationState>.seeded(
    const GeneralInformationLoadingState(),
  );

  @override
  Stream<GeneralInformationState> get generalInformationStateStream =>
      _generalInformationSubject.distinct();

  @override
  Future<void> init() async {
    await loadAllInformation();
  }

  void onChangedState(GeneralInformationState newState) {
    if (!_generalInformationSubject.isClosed) {
      _generalInformationSubject.add(newState);
    }
  }

  Future<void> loadAllInformation() async {
    onChangedState(const GeneralInformationLoadingState());

    try {
      final futures = [
        Future.value(
          authRepository.getMariaInformation(),
        ),
        Future.value(
          authRepository.getMariaInformation(
            params: MariaInformationParams.ourService,
          ),
        ),
        Future.value(
          authRepository.getMariaInformation(
            params: MariaInformationParams.serviceFees,
          ),
        ),
        Future.value(
          authRepository.getAllFaq(),
        ),
      ];

      final result = await Future.wait(futures);

      onChangedState(GeneralInformationSucessState(
        whoIsMaria: result.first as MariaInformation,
        ourService: result[1] as MariaInformation,
        serviceFees: result[2] as MariaInformation,
        faq: (result.last as List<Faq>).reversed.toList(),
      ));
    } on ApiClientError catch (e) {
      onChangedState(GeneralInformationErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  Future<void> handleRemoveFaq(String faqId) async {
    try {
      _handleSucessDeleteFaq(faqId);
      await authRepository.deleteFaq(faqId: faqId);
    } on ApiClientError catch (e) {
      onChangedState(GeneralInformationErrorState(
        message: e.message ?? '',
      ));
    }
  }

  void _handleSucessDeleteFaq(String faqId) {
    final currentState = _generalInformationSubject.valueOrNull;

    if (currentState is GeneralInformationSucessState) {
      currentState.faq.removeWhere((it) => it.id.compareTo(faqId) == 0);

      onChangedState(const GeneralInformationLoadingState());

      onChangedState(GeneralInformationSucessState(
        faq: [...currentState.faq],
        whoIsMaria: currentState.whoIsMaria,
        ourService: currentState.ourService,
        serviceFees: currentState.serviceFees,
      ));
    }
  }

  @override
  void dispose() {
    _generalInformationSubject.close();
  }
}
