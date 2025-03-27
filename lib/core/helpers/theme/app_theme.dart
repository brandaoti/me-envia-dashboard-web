// ignore_for_file: deprecated_member_use

import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import '../../values/values.dart';

abstract class AppTheme {
  static ThemeData theme(BuildContext context) {
    return ThemeData(
      fontFamily: 'Lato',
      accentColor: AppColors.secondary,
      appBarTheme: _appBarTheme(),
      primaryColor: AppColors.primary,
      highlightColor: AppColors.transparent,
      textSelectionTheme: _textSelectionTheme(),
      inputDecorationTheme: _inputDecorationTheme(),
      scaffoldBackgroundColor: AppColors.whiteDefault,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
    );
  }

  static AppBarTheme _appBarTheme() {
    return const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.whiteDefault,
    );
  }

  static InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      filled: true,
      hoverColor: AppColors.white,
      focusColor: AppColors.primary,
      labelStyle: TextStyles.labelStyle,
      border: Decorations.inputBorderForms,
      enabledBorder: Decorations.inputBorderForms,
      fillColor: AppColors.grey300.withOpacity(0.1),
      focusedBorder: Decorations.inputBorderFormFocused,
      disabledBorder: Decorations.inputBorderFormFocused,
    );
  }

  static TextSelectionThemeData _textSelectionTheme() {
    return const TextSelectionThemeData(
      cursorColor: AppColors.primary,
      selectionColor: AppColors.grey300,
    );
  }

  static ThemeData setDatePickerTheme() {
    return ThemeData.light().copyWith(
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        onError: AppColors.alertRedColor,
      ),
    );
  }

  static ThemeData scrollTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      scrollbarTheme: ScrollbarThemeData(
        crossAxisMargin: -12,
        thumbColor: MaterialStateProperty.all(AppColors.grey400),
      ),
    );
  }
}
