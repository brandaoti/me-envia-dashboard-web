import 'package:rxdart/rxdart.dart';

import '../../../core/core.dart';
import '../states/create_learn_more_state.dart';

abstract class SectionEditController {
  Stream<OpenPhotoFileState> get openFileStateStream;
  Stream<CreateLearnMoreState> get createInformationStateStream;

  Future<void> handleOpenFile();

  Future<void> handleUpdateOurService(String description);

  Future<void> handleUpdateWhoIsMaria(String description);

  Future<void> handleUpdateServiceFees({
    required String feesDescription,
    required String volumeDescription,
  });

  Future<void> hangleCreateNewFaq({
    required String? faqId,
    required String question,
    required String answer,
  });

  void init({MariaInformation? information});
  void dispose();
}

class SectionEditControllerImpl implements SectionEditController {
  final PutFileService service;
  final AuthRepository repository;

  SectionEditControllerImpl({
    required this.service,
    required this.repository,
  });

  MariaInformation? _editMariaInformation;

  PutFileImage? _putFile;

  final _createInformationSuject = BehaviorSubject<CreateLearnMoreState>();

  final _openFileSuject = BehaviorSubject<OpenPhotoFileState>.seeded(
    const OpenPhotoFileInitalState(),
  );

  @override
  Stream<CreateLearnMoreState> get createInformationStateStream =>
      _createInformationSuject.distinct();

  @override
  Stream<OpenPhotoFileState> get openFileStateStream =>
      _openFileSuject.distinct();

  @override
  void init({MariaInformation? information}) {
    _editMariaInformation = information;

    if (_editMariaInformation == null) return;

    final media = _editMariaInformation!.media;

    if (media != null) {
      onChangeOpenFileState(OpenPhotoFileSucessState(
        isNetworkImage: true,
        putFile: PutNetworkImage(source: media),
      ));
    }
  }

  @override
  Future<void> handleOpenFile() async {
    try {
      _putFile = await service.getFile(
        ignore: PutFileType.pdf,
      ) as PutFileImage;

      onChangeOpenFileState(OpenPhotoFileSucessState(
        putFile: _putFile!,
      ));
    } on ApiClientError catch (e) {
      onChangeOpenFileState(OpenPhotoFileErrorState(
        message: e.message ?? '',
      ));
    }
  }

  void onChangeOpenFileState(OpenPhotoFileState newState) {
    if (!_openFileSuject.isClosed) {
      _openFileSuject.add(newState);
    }
  }

  void onChangeCreateInformationState(CreateLearnMoreState newState) {
    if (!_createInformationSuject.isClosed) {
      _createInformationSuject.add(newState);
    }
  }

  @override
  Future<void> handleUpdateWhoIsMaria(
    String description,
  ) async {
    onChangeCreateInformationState(const CreateLearnMoreLoadingState());

    try {
      final newInformation = CreateLearnMore(
        media: _putFile,
        text: description,
      );
      await repository.updateLearnMore(
        updateLearnMore: newInformation,
        options: MariaInformationParams.whoIsMaria,
      );

      onChangeCreateInformationState(const CreateLearnMoreSucessState());
    } on ApiClientError catch (error) {
      onChangeCreateInformationState(CreateLearnMoreErrorState(
        message: error.message ?? '',
      ));
    }
  }

  @override
  Future<void> handleUpdateOurService(String description) async {
    onChangeCreateInformationState(const CreateLearnMoreLoadingState());

    try {
      final newInformation = CreateLearnMore(text: description);

      await repository.updateLearnMore(
        updateLearnMore: newInformation,
        options: MariaInformationParams.ourService,
      );
      onChangeCreateInformationState(const CreateLearnMoreSucessState());
    } on ApiClientError catch (error) {
      onChangeCreateInformationState(CreateLearnMoreErrorState(
        message: error.message ?? '',
      ));
    }
  }

  @override
  Future<void> handleUpdateServiceFees({
    required String feesDescription,
    required String volumeDescription,
  }) async {
    onChangeCreateInformationState(const CreateLearnMoreLoadingState());

    try {
      final newDescription = CreateLearnMore(
        text: volumeDescription,
        subtitle: feesDescription,
      );

      await repository.updateLearnMore(
        updateLearnMore: newDescription,
        options: MariaInformationParams.serviceFees,
      );
      onChangeCreateInformationState(const CreateLearnMoreSucessState());
    } on ApiClientError catch (error) {
      onChangeCreateInformationState(CreateLearnMoreErrorState(
        message: error.message ?? '',
      ));
    }
  }

  @override
  Future<void> hangleCreateNewFaq({
    required String? faqId,
    required String question,
    required String answer,
  }) async {
    onChangeCreateInformationState(const CreateLearnMoreLoadingState());

    try {
      await repository.createFaq(
        faqId: faqId,
        createFaq: CreateNewFaq(
          question: question,
          answer: answer,
        ),
      );

      onChangeCreateInformationState(const CreateLearnMoreSucessState());
    } on ApiClientError catch (e) {
      onChangeCreateInformationState(CreateLearnMoreErrorState(
        message: e.message ?? '',
      ));
    }
  }

  @override
  void dispose() {
    _openFileSuject.close();
    _createInformationSuject.close();
  }
}
