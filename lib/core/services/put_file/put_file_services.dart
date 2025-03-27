import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:image/image.dart' as compresss;
import 'package:file_saver/file_saver.dart';
import 'package:path/path.dart';

import '../../core.dart';

abstract class PutFileService {
  Future<File?> compressFile(PutFile putFile);
  Future<PutFile> getFile({PutFileType? ignore});

  Future<void> saveProoOfPaymentInExternalPath({
    required String urlFile,
    required Uint8List bytes,
  });
}

class PutFileServiceImpl implements PutFileService {
  final double maxSizeFile = 9 * 1024 * 1024;
  final List<PutFileType> defaultAllowedExtensions = [
    PutFileType.pdf,
    PutFileType.jpg,
    PutFileType.png,
  ];

  @override
  Future<PutFile> getFile({PutFileType? ignore}) async {
    final allowedExtensions = getAllowedExtensions(ignore: ignore);

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result == null) {
      throw InvalidFile(
        message: Strings.addMoreOneFile,
      );
    }

    if (result.files.first.size > maxSizeFile.toInt()) {
      throw InvalidFile(
        message: Strings.errorFileMaxSize,
      );
    }

    return PutFileImage(filePicker: result);
  }

  List<String> getAllowedExtensions({PutFileType? ignore}) {
    if (ignore == null) {
      return defaultAllowedExtensions.map((it) => it.value).toList();
    }

    final copyExtensionsList =
        defaultAllowedExtensions.where((it) => it != ignore).toList();
    return copyExtensionsList.map((it) => it.value).toList();
  }

  @override
  Future<File?> compressFile(PutFile putFile) async {
    final image = compresss.decodeImage(
      (putFile as PutFileImage).file!.readAsBytesSync(),
    );
    if (image == null) return null;

    final smallerImage = compresss.copyResize(image, width: 400, height: 400);

    final encodeJpg = compresss.encodeJpg(smallerImage, quality: 85);
    return putFile.file!..writeAsBytesSync(encodeJpg);
  }

  @override
  Future<void> saveProoOfPaymentInExternalPath({
    required String urlFile,
    required Uint8List bytes,
  }) async {
    final now = DateTime.now();
    final fileExtension = basename(urlFile).split('.').last;
    final fileName = '${now.millisecondsSinceEpoch}.$fileExtension';

    // if (Platform.isIOS) {
    await FileSaver.instance.saveFile(fileName, bytes, fileExtension);
    // }

    // final savePath = await getProoOfPaymentSavePath();
    // await File('$savePath/$fileName').writeAsBytes(bytes);
  }
}
