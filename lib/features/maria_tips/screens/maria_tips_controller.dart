import 'package:rxdart/subjects.dart';

import '../../../core/core.dart';
import '../maria_tips.dart';

abstract class MariaTipsController {
  Stream<MariaTipsState> get mariaTipsStateStream;

  Future<void> handleMariaTips();

  void init();
  void dispose();
}

class MariaTipsControllerImpl implements MariaTipsController {
  final AuthRepository repository;

  MariaTipsControllerImpl({
    required this.repository,
  });

  final _mariaTipsStateSubject = BehaviorSubject<MariaTipsState>.seeded(
    const MariaTipsLoadingState(),
  );

  @override
  Stream<MariaTipsState> get mariaTipsStateStream =>
      _mariaTipsStateSubject.stream.distinct();

  @override
  void init() async {
    await handleMariaTips();
  }

  void onChangeMariaTipsState(MariaTipsState newState) {
    if (!_mariaTipsStateSubject.isClosed) {
      _mariaTipsStateSubject.add(newState);
    }
  }

  @override
  Future<void> handleMariaTips() async {
    onChangeMariaTipsState(const MariaTipsLoadingState());

    try {
      final result = await repository.getMariaTips();
      onChangeMariaTipsState(MariaTipsSucessState(
        tips: result,
      ));
    } on ApiClientError catch (e) {
      onChangeMariaTipsState(MariaTipsErrorState(message: e.message ?? ''));
    }
  }

  @override
  void dispose() {
    _mariaTipsStateSubject.close();
  }
}
