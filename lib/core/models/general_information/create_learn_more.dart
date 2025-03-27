import '../../services/put_file/put_file.dart';

class CreateLearnMore {
  final String? subtitle;
  final String? text;
  final PutFileImage? media;

  const CreateLearnMore({
    this.text,
    this.media,
    this.subtitle,
  });

  bool _hasData(String? value) => value != null && value.isNotEmpty;

  Map<String, String> toMap() {
    final Map<String, String> data = {};

    if (_hasData(subtitle)) {
      data['subtitle'] = subtitle!;
    }
    if (_hasData(text)) {
      data['text'] = text!;
    }

    return data;
  }

  @override
  String toString() =>
      'CreateMariaInformation(subtitle: $subtitle, text: $text, media: $media)';
}
