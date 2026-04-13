import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'berserk_colors.dart';

class BerserkTypography {
  BerserkTypography._();

  // Font families
  static TextStyle get display =>
      GoogleFonts.poppins(fontWeight: FontWeight.w800);

  static TextStyle get body => GoogleFonts.dmSans();

  static TextStyle get mono => GoogleFonts.jetBrainsMono();

  // Text Styles
  static TextStyle get h1 => display.copyWith(
        fontSize: 32,
        color: BerserkColors.textPrimary,
      );

  static TextStyle get h2 => display.copyWith(
        fontSize: 22,
        color: BerserkColors.textPrimary,
      );

  static TextStyle get h3 => body.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: BerserkColors.textPrimary,
      );

  static TextStyle get bodyText => body.copyWith(
        fontSize: 14,
        color: BerserkColors.textSecondary,
      );

  static TextStyle get caption => body.copyWith(
        fontSize: 12,
        color: BerserkColors.textTertiary,
      );

  static TextStyle get statNumber => mono.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: BerserkColors.textPrimary,
      );

  static TextStyle get timerDisplay => mono.copyWith(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        color: BerserkColors.accent,
      );
}
