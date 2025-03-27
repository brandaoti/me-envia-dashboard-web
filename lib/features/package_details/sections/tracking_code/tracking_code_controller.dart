import 'package:rxdart/rxdart.dart';

import '../../../../core/client/client.dart';
import '../../../../core/models/models.dart';
import '../../../../core/repositories/repositories.dart';
import '../../../../core/values/values.dart';
import '../../states/tracking_code_state.dart';

abstract class TrackingCodeController {
  Stream<TrackingCodeState> get trackingCodeStateStream;

  String? getTrackingCodeValue();

  void onChangeTrackingCode(String value);

  Future<void> updateTrackingCodeValue({
    required String packageId,
  });

  void init({String? trackingCode});
  void dispose();
}

class TrackingCodeControllerImpl implements TrackingCodeController {
  final AuthRepository repository;

  TrackingCodeControllerImpl({
    required this.repository,
  });

  String? trackingCodeValue;

  final _trackingCodeStateSubject = BehaviorSubject<TrackingCodeState>.seeded(
    const TrackingCodeInitialState(),
  );

  @override
  Stream<TrackingCodeState> get trackingCodeStateStream =>
      _trackingCodeStateSubject.stream.distinct();

  @override
  void init({String? trackingCode}) {
    if (trackingCode != null) {
      trackingCodeValue = trackingCode;

      onChangeTrackingCodeState(TrackingCodeSuccessState(
        trackingCode: trackingCodeValue!,
      ));
    }
  }

  void onChangeTrackingCodeState(TrackingCodeState newState) {
    if (!_trackingCodeStateSubject.isClosed) {
      _trackingCodeStateSubject.add(newState);
    }
  }

  @override
  String? getTrackingCodeValue() {
    return trackingCodeValue;
  }

  @override
  void onChangeTrackingCode(String value) {
    trackingCodeValue = value;
  }

  @override
  Future<void> updateTrackingCodeValue({required String packageId}) async {
    onChangeTrackingCodeState(const TrackingCodeLoadingState());

    try {
      final result = await repository.updatePackage(
        packageId: packageId,
        update: UpdatePackage(trackingCode: trackingCodeValue),
      );

      onChangeTrackingCodeState(TrackingCodeSuccessState(
        trackingCode: result.trackingCode ?? '',
      ));
    } on ApiClientError catch (error) {
      onChangeTrackingCodeState(TrackingCodeErrorState(
        message: error.message ?? '',
      ));
    } catch (error) {
      onChangeTrackingCodeState(const TrackingCodeErrorState(
        message: Strings.errorUnknownInApi,
      ));
    }
  }

  @override
  void dispose() {
    _trackingCodeStateSubject.close();
  }
}
