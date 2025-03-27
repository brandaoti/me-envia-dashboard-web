import '../models.dart';

class CustomersPackage {
  final User user;
  final int totalItems;
  final PackageStatusList stepList;
  final Package packageInfo;
  final BoxList packageItem;

  const CustomersPackage({
    required this.user,
    required this.totalItems,
    required this.stepList,
    required this.packageInfo,
    required this.packageItem,
  });

  factory CustomersPackage.fromJson(Map json) {
    final customersInfo = json['user'];
    final items = customersInfo['items'];

    final packageItem = (items['itemsOnPackage'] as List);
    final steps = (customersInfo['step'] as List);

    return CustomersPackage(
      totalItems: items['totalItems'],
      user: User.fromPackage(customersInfo),
      packageInfo: Package.fromJson(customersInfo['packageInfo']),
      stepList: steps.map((it) => PackageStatus.fromJson(it)).toList(),
      packageItem: packageItem.map((it) => Box.fromPackage(it)).toList(),
    );
  }

  @override
  String toString() {
    return 'CustomersPackage(user: $user, totalItems: $totalItems, stepList: $stepList, packageInfo: $packageInfo, packageItem: $packageItem)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CustomersPackage &&
        other.user == user &&
        other.totalItems == totalItems &&
        other.stepList == stepList &&
        other.packageInfo == packageInfo &&
        other.packageItem == packageItem;
  }

  @override
  int get hashCode {
    return user.hashCode ^
        totalItems.hashCode ^
        stepList.hashCode ^
        packageInfo.hashCode ^
        packageItem.hashCode;
  }
}
