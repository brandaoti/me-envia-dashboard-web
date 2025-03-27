import '../../helpers/extensions.dart';

class MariaInformation {
  final String id;
  final String title;
  final String subtitle;
  final String text;
  final String? media;

  const MariaInformation({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.text,
    required this.media,
  });

  factory MariaInformation.fromJson(Map json) {
    final picture = json['picture'] as String?;

    return MariaInformation(
      id: json['id'],
      text: json['text'],
      title: json['title'],
      subtitle: json['subtitle'],
      media: picture?.normalizePictureUrl,
    );
  }

  Map toMap() {
    return {
      'id': id,
      'text': text,
      'title': title,
      'subtitle': subtitle,
    };
  }

  @override
  String toString() {
    return 'MariaInformation(id: $id, title: $title, subtitle: $subtitle, text: $text, media: $media)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MariaInformation &&
        other.id == id &&
        other.title == title &&
        other.subtitle == subtitle &&
        other.text == text &&
        other.media == media;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        subtitle.hashCode ^
        text.hashCode ^
        media.hashCode;
  }
}
