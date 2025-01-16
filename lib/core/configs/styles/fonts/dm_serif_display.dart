import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../app_colors.dart';

class DmSerifDisplayPalette {
  static const String dmSerifDisplayFamily = "DMSerifDisplay";

  /*<---15--->*/
  static TextStyle get fWhite_18_400 => TextStyle(
      fontSize: 18.sp, fontWeight: FontWeight.w400, color: AppColors.white);

  /*<---24--->*/
  static TextStyle get fWhite_24_400 => TextStyle(
      fontSize: 24.sp, fontWeight: FontWeight.w400, color: AppColors.white);

/*<---26--->*/
  static TextStyle get ffefefe_26_400 => TextStyle(
      fontSize: 26.sp, fontWeight: FontWeight.w400, color: AppColors.white);

  /*<---40--->*/
  static TextStyle get fWhite_60_400 => TextStyle(
      height: 1,
      fontSize: 60.sp,
      fontWeight: FontWeight.w400,
      color: AppColors.white);
}
