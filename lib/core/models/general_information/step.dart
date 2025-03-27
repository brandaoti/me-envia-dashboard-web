import '../../types/types.dart';

typedef PackageStatusList = List<PackageStatus>;

class PackageStatus {
  final PackageStep? step;
  final PackageType? type;

  PackageStatus({
    required this.step,
    required this.type,
  });

  factory PackageStatus.fromJson(Map json) {
    return PackageStatus(
      step: (json['step'] as String?).fromApiStep,
      type: (json['type'] as String?).fromApiType,
    );
  }

  @override
  String toString() => 'Step(step: $step, type: $type)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PackageStatus && other.step == step && other.type == type;
  }

  @override
  int get hashCode => step.hashCode ^ type.hashCode;
}
