import 'package:maria_me_envia_mobile_admin_web/core/services/put_file/put_file.dart';
import '../../services/services.dart';

abstract class OpenPhotoFileState {}

class OpenPhotoFileInitalState implements OpenPhotoFileState {
  const OpenPhotoFileInitalState();
}

class OpenPhotoFileSucessState implements OpenPhotoFileState {
  final PutFile putFile;
  final bool isNetworkImage;

  const OpenPhotoFileSucessState({
    required this.putFile,
    this.isNetworkImage = false,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenPhotoFileSucessState &&
        other.putFile == putFile &&
        other.isNetworkImage == isNetworkImage;
  }

  @override
  int get hashCode => putFile.hashCode ^ isNetworkImage.hashCode;

  @override
  String toString() =>
      'OpenPhotoFileSucessState(putFile: $putFile, isNetworkImage: $isNetworkImage)';
}

class OpenPhotoFileErrorState implements OpenPhotoFileState {
  final String message;

  const OpenPhotoFileErrorState({
    required this.message,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OpenPhotoFileErrorState && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'OpenPhotoFileErrorState(message: $message)';
}
