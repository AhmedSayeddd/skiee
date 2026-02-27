import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skiee/core/app_colors.dart';

class AppStyle {
  static TextStyle titleStyle = GoogleFonts.inter(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: const Color(AppColors.black),
  );

  static  TextStyle subtitleStyle = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: const Color(AppColors.hintText),
  );

   static TextStyle buttonTextStyle = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: const Color(AppColors.white),
  );

  static TextStyle loginwith = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: const Color(AppColors.black),
  );
}