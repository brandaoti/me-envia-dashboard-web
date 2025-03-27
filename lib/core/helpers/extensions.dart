import 'package:cubos_extensions/cubos_extensions.dart';
import 'package:flutter/material.dart';
import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:intl/intl.dart';
import '../core.dart';

extension ContextExtensions on BuildContext {
  /// Returns screen's height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Returns screen's width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Returns screen [Size], containing width and height
  Size get screenSize => MediaQuery.of(this).size;

  // Returns true, if the device is mobile
  bool get isMobile => screenWidth < 840;
}

extension StringExtension on String? {
  String get normalizePictureUrl {
    const String file = 'file:///';
    const String protocol = 'https://';

    if (this != null && this!.contains(file)) {
      final pictureNormalizedUrl = this!.replaceAll(file, '');
      return '$protocol$pictureNormalizedUrl';
    }

    if (!this!.contains(protocol)) {
      return '$protocol$this';
    }

    return '';
  }

  String? get formatCPF {
    if (this == null) {
      return null;
    }

    return CPF.format(this!);
  }

  String? get formatPhone {
    if (this!.length < 11) {
      return this ?? '';
    }

    final phone = this!.cleanPhone.trim();

    final firstDigits = phone.substring(0, 2);
    final secondDigits = phone.substring(2, 7);
    final lastDigits = phone.substring(7);

    return '($firstDigits) $secondDigits-$lastDigits';
  }

  String? get formatterCep {
    if (this == null) {
      return '';
    }

    if (this!.length < 8) {
      return this!;
    }

    final cep = this!.replaceAll('.', '').replaceAll('-', '').trim();

    final firstDigits = cep.substring(0, 2);
    final secondDigits = cep.substring(2, 5);
    final thirdDigits = cep.substring(5, 8);

    return '$firstDigits.$secondDigits-$thirdDigits';
  }
}

extension DateTimeExtension on DateTime {
  String get toMonthAndDay {
    final month = toMonthStr;
    final day = this.day.toString().padLeft(2, '0');

    return '$day de $month';
  }

  String get toHourAbbreStr {
    final hour = this.hour.toString().padLeft(2, '0');
    final min = minute.toString().padLeft(2, '0');

    return '${hour}h$min';
  }

  String get toMonthAbbreStr {
    final month = this.month;
    final day = this.day.toString().padLeft(2, '0');

    return '$day ${Strings.brazilianMonthAbreviation[month] ?? ''}';
  }

  String get toDateAbbreStr {
    final dateTime = this;
    final year = dateTime.year.toString().padLeft(4, '0');
    final month = dateTime.month.toString().padLeft(2, '0');
    final day = dateTime.day.toString().padLeft(2, '0');
    return '$day/$month/${year.substring(2)}';
  }
}

extension UserExtension on User? {
  String get getCpfWithMaks {
    if (this != null) {
      return '${Strings.cpfInputLabelText} ${this!.cpf.formatCPF}';
    }

    return '';
  }

  String get getPhoneWithMaks {
    if (this != null) {
      return '${Strings.phoneInputLabelText} ${this!.phoneNumber.formatPhone}';
    }

    return '';
  }

  String get getZipCodeWithMaks {
    if (this == null) return '';

    final address = this!.address.zipcode.formatterCep;
    return '${Strings.zipCodeInputLabelText} $address';
  }

  String get getFullLocation {
    if (this == null) return '';

    final address = this!.address;
    return '${address.city}, ${address.state}, ${address.country}';
  }
}

extension NuNumberExtension on num {
  String get formatterMoney {
    return NumberFormat.currency(
      symbol: 'U\$',
      locale: 'en_US',
    ).format(this);
  }

  String get formatterMoneyToBrasilian {
    return NumberFormat.currency(
      symbol: 'R\$',
      locale: 'pt_BR',
    ).format(this);
  }

  String get formatterMoneyNoSimbol {
    return NumberFormat.currency(
      symbol: '',
      decimalDigits: 0,
      locale: 'pt_BR',
    ).format(this);
  }
}

extension DeclarationExtension on Declaration {
  String get formatterUnityValue {
    return unitaryValue.formatterMoney;
  }

  String get formatterTotalValue {
    return totalValue.formatterMoney;
  }
}

extension DeclarationListExtension on DeclarationList {
  double get totalValue {
    if (length > 1) {
      return fold<double>(0, (a, b) => a + b.totalValue);
    }

    return isNotEmpty ? first.totalValue : 0;
  }
}

extension DoubleListExtension on num {
  int byCents() {
    return (this * 100).truncate();
  }

  double byRealToPrecision() {
    return (this / 100).toPrecision(2);
  }

  double byReal() {
    return (this / 100);
  }
}

extension UserPackageListExtension on UserPackageList {
  UserPackageList packageWithStatus(bool isPending) {
    return where((it) {
      final status = it.status ?? PackageStatusType.awaitingPayment;
      return isPending
          ? status != PackageStatusType.paymentSubjectToConfirmation
          : status == PackageStatusType.paymentSubjectToConfirmation;
    }).toList();
  }

  List<UserPackage> get sortByStatus {
    if (isEmpty) {
      return [];
    }

    final listNotStatus = packageWithStatus(false);
    final listWithStatus = packageWithStatus(true)
      ..sort((a, b) => a.packageId.compareTo(b.packageId));

    return [...listNotStatus, ...listWithStatus];
  }

  UserPackageList packageWithTrackingCode(bool isTrackingCode) {
    return where(
      (it) =>
          isTrackingCode ? it.trackingCode != null : it.trackingCode == null,
    ).toList();
  }

  List<UserPackage> get sortByWithTrackingCode {
    if (isEmpty) {
      return [];
    }

    final listNotTrackingCode = packageWithTrackingCode(false);
    final listWithTrackingCode = packageWithTrackingCode(true)
      ..sort((a, b) => a.packageId.compareTo(b.packageId));

    return [...listNotTrackingCode, ...listWithTrackingCode];
  }

  double get paymentReceived {
    if (isNotEmpty) {
      final list =
          where((it) => it.paymentStatus == PaymentStatus.success).toList();
      return list.fold<double>(0, (a, b) => a + (b.shippingFee ?? 0));
    }

    return 0;
  }

  double get paymentToReceive {
    if (isNotEmpty) {
      final list = where((it) =>
          it.paymentStatus == null ||
          it.paymentStatus == PaymentStatus.notPaid).toList();
      return list.fold<double>(0, (a, b) => a + (b.shippingFee ?? 0));
    }

    return 0;
  }

  UserPackageList searchByName(String value) {
    return where((it) => it.name.toLowerCase().contains(
          value.toLowerCase(),
        )).toList();
  }
}

extension ReportStatusListExtensions on ReportStatusList {
  void get sortByStatus {
    if (isEmpty) return;
    sort((a, b) => a.status.index - b.status.index);
  }

  ReportStatus getCountValue(int status) {
    final count = where((it) => it.status.index == status)
        .fold<int>(0, (value, it) => value + it.count);

    final reportStatus = ReportStatusType.values[status];
    return ReportStatus(
      count: count,
      status: reportStatus,
      labelStatus: reportStatus.fromReportStatusMessage,
    );
  }

  ReportStatusList removeByStatus(int status) {
    removeWhere((it) => it.status.index == status);
    return this;
  }
}
