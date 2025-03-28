import '../../helpers/extensions.dart';

typedef BoxList = List<Box>;

class Box {
  final String id;
  final String? name;
  final String? media;
  final String userId;
  final String? description;
  final DateTime? createdAt;

  const Box({
    required this.id,
    required this.createdAt,
    required this.media,
    required this.name,
    required this.userId,
    required this.description,
  });

  factory Box.fromJson(Map json) {
    final date = DateTime.tryParse(json['createdAt']) ?? DateTime.now();
    final String? imageUrl = (json['media'] as String?);

    return Box(
      id: json['id'] ?? '',
      createdAt: date,
      name: json['name'] ?? '',
      userId: json['userId'] ?? '',
      description: json['description'] ?? '',
      media: imageUrl.normalizePictureUrl,
    );
  }

  factory Box.fromPackage(Map json) {
    final String? imageUrl = (json['media'] as String?);

    return Box(
      id: '',
      userId: '',
      createdAt: null,
      description: '',
      name: json['name'] ?? '',
      media: imageUrl.normalizePictureUrl,
    );
  }

  Map toMap() {
    return {
      'id': id,
      'media': media,
      'name': name,
      'userId': userId,
      'description': description,
      'createdAt': createdAt.toString(),
    };
  }

  bool get nameIsEmpty => (name ?? '').isEmpty;

  bool get imageIsEmpty => (media ?? '').isEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Box &&
        other.id == id &&
        other.name == name &&
        other.media == media &&
        other.userId == userId &&
        other.description == description &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        media.hashCode ^
        userId.hashCode ^
        description.hashCode ^
        createdAt.hashCode;
  }

  @override
  String toString() {
    return 'Box(id: $id, name: $name, media: $media, userId: $userId, description: $description, createdAt: $createdAt)';
  }

  Box copyWith({
    String? id,
    String? name,
    String? media,
    String? userId,
    String? description,
    DateTime? createdAt,
  }) {
    return Box(
      id: id ?? this.id,
      name: name ?? this.name,
      media: media ?? this.media,
      userId: userId ?? this.userId,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
