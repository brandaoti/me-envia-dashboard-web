import '../../states/create_tips_state.dart';
import 'package:rxdart/subjects.dart';

import '../../../../../core/repositories/repositories.dart';
import '../../../../core/components/components.dart';
import '../../../../core/services/services.dart';
import '../../../../core/models/models.dart';
import '../../../../core/client/client.dart';
import '../../../../core/values/values.dart';
import '../../model/create_tips.dart';

enum CreateFormType {
  title,
  link,
  description,
}

abstract class CreateNewTipsController {
  Stream<OpenPhotoFileState> get openFileStateStream;
  Stream<CreateTipsState> get createTipsStateStream;

  Future<void> handleOpenFile();
  void onFormChane(CreateFormType type, String? value);

  Future<void> handleCreateNewTips();
  Future<void> handleRemoveTips();

  void init({MariaTips? tips});
  void dispose();
}

class CreateNewTipsControllerImpl implements CreateNewTipsController {
  final PutFileService service;
  final AuthRepository repository;

  CreateNewTipsControllerImpl({
    required this.repository,
    required this.service,
  });

  MariaTips? _editMariaTips;

  final CreateTips _createTips = CreateTips();

  final _openFileSuject = BehaviorSubject<OpenPhotoFileState>.seeded(
    const OpenPhotoFileInitalState(),
  );

  final _createTipsSuject = BehaviorSubject<CreateTipsState>();

  @override
  Stream<OpenPhotoFileState> get openFileStateStream =>
      _openFileSuject.stream.distinct();

  @override
  Stream<CreateTipsState> get createTipsStateStream =>
      _createTipsSuject.stream.distinct();

  @override
  void init({MariaTips? tips}) {
    _editMariaTips = tips;

    if (_editMariaTips != null) {
      onChangeOpenFileState(OpenPhotoFileSucessState(
        isNetworkImage: true,
        putFile: PutNetworkImage(source: _editMariaTips!.media),
      ));
    }
  }

  void onChangeOpenFileState(OpenPhotoFileState newState) {
    if (!_openFileSuject.isClosed) {
      _openFileSuject.add(newState);
    }
  }

  @override
  Future<void> handleOpenFile() async {
    try {
      final putFile = await service.getFile(ignore: PutFileType.pdf);
      _createTips.putFile = putFile;
      onChangeOpenFileState(OpenPhotoFileSucessState(
        putFile: putFile,
      ));
    } on ApiClientError catch (e) {
      onChangeOpenFileState(OpenPhotoFileErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void onFormChane(CreateFormType type, String? value) {
    switch (type) {
      case CreateFormType.title:
        _createTips.title = value;
        break;
      case CreateFormType.link:
        _createTips.link = value;
        break;
      case CreateFormType.description:
        _createTips.description = value;
        break;
    }
  }

  void onChangeCreateTipsState(CreateTipsState newState) {
    if (!_createTipsSuject.isClosed) {
      _createTipsSuject.add(newState);
    }
  }

  @override
  Future<void> handleCreateNewTips() async {
    if (_editMariaTips == null) {
      await _createNewTips();
    } else {
      await _editTips();
    }
  }

  Future<void> _createNewTips() async {
    onChangeCreateTipsState(const CreateTipsLoadingState());

    if (_createTips.mediaNoContaisData) {
      onChangeCreateTipsState(const CreateTipsErrorState(
        message: Strings.addMoreOneFile,
      ));

      return;
    }

    try {
      await repository.createHint(
        createHints: CreateHints(
          link: _createTips.link,
          title: _createTips.title,
          putFile: _createTips.putFile,
          description: _createTips.description,
        ),
      );

      onChangeCreateTipsState(const CreateTipsSucessState());
    } on ApiClientError catch (e) {
      onChangeCreateTipsState(CreateTipsErrorState(
        message: e.message ?? '',
      ));
    }
  }

  Future<void> _editTips() async {
    onChangeCreateTipsState(const CreateTipsLoadingState());

    if (_createTips.isEmptyFields) {
      onChangeCreateTipsState(const CreateTipsErrorState(
        message: Strings.errorEditTipsMessage,
      ));

      return;
    }

    try {
      await repository.createHint(
        hintId: _editMariaTips!.id,
        createHints: CreateHints(
          link: _createTips.link,
          title: _createTips.title,
          putFile: _createTips.putFile,
          description: _createTips.description,
        ),
      );

      onChangeCreateTipsState(const CreateTipsSucessState(section: 1));
    } on ApiClientError catch (e) {
      onChangeCreateTipsState(CreateTipsErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  Future<void> handleRemoveTips() async {
    onChangeCreateTipsState(const CreateTipsLoadingState());

    try {
      await repository.deleteHint(tipsId: _editMariaTips!.id);

      onChangeCreateTipsState(const CreateTipsSucessState(section: 2));
    } on ApiClientError catch (e) {
      onChangeCreateTipsState(CreateTipsErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void dispose() {
    _openFileSuject.close();
    _createTipsSuject.close();
  }
}
