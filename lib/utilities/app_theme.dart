import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_converter/utilities/app_color.dart';
import 'package:json_converter/utilities/app_text.dart';

class AppTheme {
  static final set = ThemeData(
    scaffoldBackgroundColor: AppColor.colorBackground,
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: AppColor.colorPrimary),
      elevation: 0,
      color: AppColor.colorBackground,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: AppColor.colorPrimary,
          fontSize: 20,
          fontFamily: AppText.fontSemibold),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(
        fontFamily: AppText.fontRegular,
        color: AppColor.colorPrimary,
        fontSize: 15,
      ),
      titleLarge: TextStyle(
        fontFamily: AppText.fontSemibold,
        color: Colors.white,
        fontSize: 15,
      ),
      headlineLarge: TextStyle(
        fontFamily: AppText.fontSemibold,
        color: AppColor.colorPrimary,
        fontSize: 20,
      ),
    ),
  );
}
