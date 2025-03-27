import 'dart:typed_data';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

import '../../values/values.dart';
import 'put_file_type.dart';

abstract class PutFile {
  String? get path;
  String get filename;
  String get mediaType;
  PutFileType get fileType;
  String get randomFilename;
}

class PutFileImage implements PutFile {
  final FilePickerResult filePicker;

  PutFileImage({
    required this.filePicker,
  });

  @override
  String? get path => filePicker.paths.first;

  @override
  String get filename => basename(filePicker.paths.first ?? '');

  @override
  String get randomFilename {
    final now = DateTime.now();
    return '${Strings.photoFileUploadName}_${now.millisecondsSinceEpoch.toString()}.$fileExtension';
  }

  String get fileExtension {
    return filePicker.files.first.extension ?? '';
  }

  @override
  PutFileType get fileType {
    return fileExtension.replaceAll('.', '').trim().fromPutFileType;
  }

  @override
  String get mediaType {
    return fileType.toMediaType;
  }

  Uint8List? get bytes {
    final cachedFile = filePicker.files.first;
    return cachedFile.bytes;
  }

  File? get file {
    final cachedFile = filePicker.files.first;
    return File(cachedFile.path!);
  }
}

class PutNetworkImage implements PutFile {
  final String source;

  PutNetworkImage({
    required this.source,
  });

  @override
  PutFileType get fileType => PutFileType.jpg;

  @override
  String get filename => '';

  @override
  String get mediaType => '';

  @override
  String? get path => source;

  @override
  String get randomFilename => '';
}
