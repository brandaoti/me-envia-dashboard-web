import '../states/package_edit_section.dart';

class PackageDetailsParams {
  final String packageID;
  final PackageEditSection packageEditSection;

  const PackageDetailsParams({
    required this.packageID,
    required this.packageEditSection,
  });
}
