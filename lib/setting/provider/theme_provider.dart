import 'dart:ui';

import 'package:flutter_deer_djzhang/routers/web_page_transitions.dart';
import 'package:sp_util/sp_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_deer_djzhang/res/constant.dart';
import 'package:flutter_deer_djzhang/res/resources.dart';

extension ThemeModeExtension on ThemeMode {
  String get value => <String>['System', 'Light', 'Dark'][index];
}

class ThemeProvider extends ChangeNotifier {
  void syncTheme() {
    final String theme = SpUtil.getString(Constant.theme) ?? '';
    if (theme.isNotEmpty && theme != ThemeMode.system.value) {
      notifyListeners();
    }
  }

  void setTheme(ThemeMode themeMode) {
    SpUtil.putString(Constant.theme, themeMode.value);
    notifyListeners();
  }

  ThemeMode getThemeMode() {
    final String theme = SpUtil.getString(Constant.theme) ?? '';
    switch (theme) {
      case 'Dark':
        return ThemeMode.dark;
      case 'Light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  ThemeData getTheme({bool isDarkMode = false}) {
    return ThemeData(
      errorColor: isDarkMode ? AppColors.dark_red : AppColors.red,
      brightness: isDarkMode ? Brightness.dark : Brightness.light,
      primaryColor: isDarkMode ? AppColors.dark_app_main : AppColors.app_main,
      accentColor: isDarkMode ? AppColors.dark_app_main : AppColors.app_main,
      // Tab指示器颜色
      indicatorColor: isDarkMode ? AppColors.dark_app_main : AppColors.app_main,
      // 页面背景色
      scaffoldBackgroundColor:
          isDarkMode ? AppColors.dark_bg_color : Colors.white,
      // 主要用于Material背景色
      canvasColor: isDarkMode ? AppColors.dark_material_bg : Colors.white,
      // 文字选择色（输入框选择文字等）
      // textSelectionColor: Colours.app_main.withAlpha(70),
      // textSelectionHandleColor: Colours.app_main,
      // 稳定版：1.23 变更(https://flutter.dev/docs/release/breaking-changes/text-selection-theme)
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: AppColors.app_main.withAlpha(70),
        selectionHandleColor: AppColors.app_main,
        cursorColor: AppColors.app_main,
      ),
      textTheme: TextTheme(
        // TextField输入文字颜色
        subtitle1: isDarkMode ? AppTextStyles.textDark : AppTextStyles.text,
        // Text文字样式
        bodyText2: isDarkMode ? AppTextStyles.textDark : AppTextStyles.text,
        subtitle2: isDarkMode
            ? AppTextStyles.textDarkGray12
            : AppTextStyles.textGray12,
      ),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: isDarkMode
            ? AppTextStyles.textHint14
            : AppTextStyles.textDarkGray14,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: isDarkMode ? AppColors.dark_bg_color : Colors.white,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      dividerTheme: DividerThemeData(
          color: isDarkMode ? AppColors.dark_line : AppColors.line,
          space: 0.6,
          thickness: 0.6),
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
      ),
      pageTransitionsTheme: NoTransitionsOnWeb(),
      visualDensity: VisualDensity
          .standard, // https://github.com/flutter/flutter/issues/77142
    );
  }
}
