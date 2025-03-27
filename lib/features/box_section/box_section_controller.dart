import 'package:rxdart/rxdart.dart';

import '../../core/core.dart';

import 'states/box_section_states.dart';

abstract class BoxSectionController {
  Stream<BoxSectionState> get boxSectionStateStream;

  void handleSearchCustomersList(String value);

  void init(UserParameters newSection);
  void dispose();
  Future<void> handleUserBoxes();
}

class BoxSectionControllerImpl implements BoxSectionController {
  final AuthRepository repository;

  BoxSectionControllerImpl({
    required this.repository,
  });

  late UserParameters section;
  UserPackageList cachedUserPackageList = [];

  final _boxSectionStateStream = BehaviorSubject<BoxSectionState>.seeded(
    const BoxSectionLoadingState(),
  );

  @override
  Stream<BoxSectionState> get boxSectionStateStream =>
      _boxSectionStateStream.stream.distinct();

  @override
  void init(UserParameters newSection) async {
    section = newSection;
    await handleUserBoxes();
  }

  void onChangeBoxSectionState(BoxSectionState newState) {
    if (!_boxSectionStateStream.isClosed) {
      _boxSectionStateStream.add(newState);
    }
  }

  @override
  Future<void> handleUserBoxes() async {
    onChangeBoxSectionState(const BoxSectionLoadingState());

    try {
      cachedUserPackageList = await repository.getUserPackage(section: section);

      onChangeBoxSectionState(BoxSectionSucessState(
        custList: cachedUserPackageList,
      ));
    } on ApiClientError catch (e) {
      onChangeBoxSectionState(BoxSectionErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void handleSearchCustomersList(String value) {
    if (value.isEmpty) {
      onChangeBoxSectionState(BoxSectionSucessState(
        custList: cachedUserPackageList,
      ));
      return;
    }

    final result = cachedUserPackageList.searchByName(value);
    onChangeBoxSectionState(
      BoxSectionSucessState(
        custList: result,
      ),
    );
  }

  @override
  void dispose() {
    _boxSectionStateStream.close();
  }
}
