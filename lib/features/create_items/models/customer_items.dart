import '../../../core/models/models.dart';
import '../../../core/services/put_file/put_file.dart';
import '../../../core/services/services.dart';

typedef CustomersItemsList = List<CustomersItem>;

class CustomersItem {
  final String id;
  final String? name;
  final PutFileImage? file;

  const CustomersItem({
    required this.id,
    required this.name,
    required this.file,
  });

  CreateItem toApi() {
    return CreateItem(
      name: name,
      media: file!,
      description: null,
    );
  }

  CustomersItem copyWith({
    String? name,
    PutFileImage? file,
  }) {
    return CustomersItem(
      id: id,
      file: file ?? this.file,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomersItem &&
        other.id == id &&
        other.name == name &&
        other.file == file;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ file.hashCode;

  @override
  String toString() => 'CustomersItems(id: $id, name: $name, file: $file)';
}
