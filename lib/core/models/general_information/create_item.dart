import '../../services/put_file/put_file.dart';

class CreateItem {
  final PutFile media;
  final String? name;
  final String? description;

  const CreateItem({
    required this.name,
    required this.media,
    required this.description,
  });

  Map toMap() {
    return {
      'name': name,
      'media': media.path,
      'description': description,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CreateItem && other.name == name && other.media == media;
  }

  @override
  int get hashCode => name.hashCode ^ media.hashCode;

  @override
  String toString() => 'CreateItem(name: $name, media: $media)';
}
