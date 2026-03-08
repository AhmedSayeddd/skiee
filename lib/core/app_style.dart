import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skiee/core/app_colors.dart';

class AppStyle {
  static TextStyle titleStyle = GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );

  static TextStyle subtitleStyle = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textHint,
  );

  static TextStyle buttonTextStyle = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static TextStyle loginwith = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}
