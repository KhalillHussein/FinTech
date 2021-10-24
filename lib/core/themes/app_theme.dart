import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';

class AppTheme {
  static final _pageTransitionsTheme = PageTransitionsTheme(
    builders: const {
      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    },
  );

  static final lightTheme = ThemeData(
      primaryColor: AppColors.colorWhite,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.colorGray,
        elevation: 0,
      ),
      colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: AppColors.colorRed,
        secondaryVariant: AppColors.colorGray,
        primary: AppColors.colorBlack,
      ),
      unselectedWidgetColor: AppColors.colorGraphite_2,
      scaffoldBackgroundColor: AppColors.colorGray,
      canvasColor: AppColors.colorWhite,
      pageTransitionsTheme: _pageTransitionsTheme,
      textTheme: GoogleFonts.rubikTextTheme(
        ThemeData.light().textTheme.copyWith(
              headline2: TextStyle(
                color: AppColors.colorGraphite_1,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
              headline1: TextStyle(
                color: AppColors.colorGraphite_1,
                fontSize: 24.sp,
                fontWeight: FontWeight.w500,
              ),
              bodyText1: TextStyle(
                color: AppColors.colorGraphite_1,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              bodyText2: TextStyle(
                color: AppColors.colorGraphite_1,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              caption: TextStyle(
                color: AppColors.colorGraphite_2,
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
              subtitle1: TextStyle(
                color: AppColors.colorGraphite_1,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
      ));

  static void setStatusBarColor() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
  }

  static void setDeviceOrientation() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

extension CustomColorsX on ThemeData {
  Color get successColor => AppColors.colorGreen;
}
