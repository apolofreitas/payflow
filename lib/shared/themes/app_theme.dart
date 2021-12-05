import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    colorScheme: const ColorScheme.light().copyWith(
      background: AppColors.background,
      onBackground: AppColors.grey,
      brightness: Brightness.light,
      error: AppColors.delete,
      onError: AppColors.background,
      primary: AppColors.primary,
      onPrimary: AppColors.background,
      primaryVariant: AppColors.primary,
      secondary: AppColors.primary,
      onSecondary: AppColors.background,
      secondaryVariant: AppColors.primary,
      surface: AppColors.shape,
      onSurface: AppColors.grey,
    ),
  );
}
