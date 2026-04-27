import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

const String bold = 'MulishBold';
const String semiBold = 'MulishSemiBold';
const String medium = 'MulishMedium';
const String regular = 'MulishRegular';

class StyleHelper {


  static TextStyle customStyle(
      {String? family,
      Color? color,
      double? fontSize, wordSpacing,
      FontWeight?  fontWeight,
      TextDecoration? textDecoration, FontStyle? fontStyle}) {
    return TextStyle(
      fontFamily: family ?? AppFonts.poppins,
      color: color ?? AppColors.blackColor,
      fontSize: fontSize ?? 12.sp,
      decoration: textDecoration,
      fontWeight: fontWeight,
      fontStyle: fontStyle,
      wordSpacing: wordSpacing
    );
  }
}
