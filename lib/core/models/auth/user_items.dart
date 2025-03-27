import '../models.dart';

class UserItems {
  final User user;
  final BoxList items;

  const UserItems({
    required this.user,
    required this.items,
  });

  factory UserItems.fromJson(Map json) {
    final list = (json['items'] as List);

    return UserItems(
      user: User.fromJson(json),
      items: list.map((it) => Box.fromJson(it)).toList(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserItems && other.user == user && other.items == items;
  }

  @override
  int get hashCode => user.hashCode ^ items.hashCode;

  @override
  String toString() => 'UserItems(user: $user, items: $items)';
}
