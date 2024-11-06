import 'package:flutter/material.dart';
import 'package:sport_shoes_store/utils/theme/custom_themes/appbar_theme.dart';
import 'package:sport_shoes_store/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:sport_shoes_store/utils/theme/custom_themes/button_theme.dart';
import 'package:sport_shoes_store/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:sport_shoes_store/common/widgets/chips/chip_theme.dart';
import 'package:sport_shoes_store/utils/theme/custom_themes/text_field_theme.dart';
import 'package:sport_shoes_store/utils/theme/custom_themes/text_theme.dart';

class KAppTheme {
  KAppTheme._();
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppíns',
      brightness: Brightness.light,
      primaryColor: Colors.blue,
      textTheme: KTextTheme.lightTextTheme,
      chipTheme: KChipTheme.lightChipTheme,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: KAppBarTheme.lightAppBarTheme,
      checkboxTheme: KCheckboxTheme.lightCheckboxThemeData,
      bottomSheetTheme: KBottomSheetTheme.lightBottomSheetThemeData,
      elevatedButtonTheme: KButtonTheme.lightButtonTheme,
      inputDecorationTheme: KTextFormFieldTheme.lightInputDecorationTheme);
  
  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      fontFamily: 'Poppíns',
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      textTheme: KTextTheme.darkTextTheme,
      chipTheme: KChipTheme.darkChipTheme,
      scaffoldBackgroundColor: Colors.black,
      appBarTheme: KAppBarTheme.darkAppBarTheme,
      checkboxTheme: KCheckboxTheme.darkCheckboxThemeData,
      bottomSheetTheme: KBottomSheetTheme.darkBottomSheetThemeData,
      elevatedButtonTheme: KButtonTheme.darkButtonTheme,
      inputDecorationTheme: KTextFormFieldTheme.darkInputDecorationTheme);
}
