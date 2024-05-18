import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SharedTheme {
  static const Color whiteColor = Color(0xFFFFFFFF);

  static final _primaryTextStyle = GoogleFonts.josefinSans().fontFamily;
  static final _secondaryTextStyle = GoogleFonts.openSans().fontFamily;

  static const thin = FontWeight.w100;
  static const extraLight = FontWeight.w200;
  static const light = FontWeight.w300;
  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;
  static const extraBold = FontWeight.w800;
  static const black = FontWeight.w900;

  static const _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff3c6090),
    surfaceTint: Color(0xff3c6090),
    onPrimary: Color(0xffffffff),
    primaryContainer: Color(0xffd4e3ff),
    onPrimaryContainer: Color(0xff001c3a),
    secondary: Color(0xff545f71),
    onSecondary: Color(0xffffffff),
    secondaryContainer: Color(0xffd8e3f8),
    onSecondaryContainer: Color(0xff111c2b),
    tertiary: Color(0xff6d5676),
    onTertiary: Color(0xffffffff),
    tertiaryContainer: Color(0xfff7d8ff),
    onTertiaryContainer: Color(0xff271430),
    error: Color(0xffba1a1a),
    onError: Color(0xffffffff),
    errorContainer: Color(0xffffdad6),
    onErrorContainer: Color(0xff410002),
    background: Color(0xfff9f9ff),
    onBackground: Color(0xff191c20),
    surface: Color(0xfff9f9ff),
    onSurface: Color(0xff191c20),
    surfaceVariant: Color(0xffe0e2ec),
    onSurfaceVariant: Color(0xff43474e),
    outline: Color(0xff74777f),
    outlineVariant: Color(0xffc3c6cf),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xff2e3035),
    onInverseSurface: Color(0xfff0f0f7),
    inversePrimary: Color(0xffa5c8ff),
  );

  static const _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xffa5c8ff),
    surfaceTint: Color(0xffa5c8ff),
    onPrimary: Color(0xff00315e),
    primaryContainer: Color(0xff224876),
    onPrimaryContainer: Color(0xffd4e3ff),
    secondary: Color(0xffbcc7dc),
    onSecondary: Color(0xff263141),
    secondaryContainer: Color(0xff3d4758),
    onSecondaryContainer: Color(0xffd8e3f8),
    tertiary: Color(0xffdabde2),
    onTertiary: Color(0xff3d2946),
    tertiaryContainer: Color(0xff553f5e),
    onTertiaryContainer: Color(0xfff7d8ff),
    error: Color(0xffffb4ab),
    onError: Color(0xff690005),
    errorContainer: Color(0xff93000a),
    onErrorContainer: Color(0xffffdad6),
    background: Color(0xff111318),
    onBackground: Color(0xffe1e2e9),
    surface: Color(0xff111318),
    onSurface: Color(0xffe1e2e9),
    surfaceVariant: Color(0xff43474e),
    onSurfaceVariant: Color(0xffc3c6cf),
    outline: Color(0xff8d9199),
    outlineVariant: Color(0xff43474e),
    shadow: Color(0xff000000),
    scrim: Color(0xff000000),
    inverseSurface: Color(0xffe1e2e9),
    onInverseSurface: Color(0xff2e3035),
    inversePrimary: Color(0xff3c6090),
  );

  static const successColor = Color(0xFF249689);
  static const errorColor = Color(0xFFFF5963);
  static const warningColor = Color(0xFFF9CF58);
  static const infoColor = Color(0xFF1307B2);

  static const accent1Color = Color.fromARGB(30, 75, 57, 239);
  static const accent2Color = Color.fromARGB(30, 57, 210, 192);
  static const accent3Color = Color.fromARGB(30, 238, 139, 96);

  static final _textThemeStyle = TextTheme(
    bodyLarge: TextStyle(fontFamily: _secondaryTextStyle),
    bodyMedium: TextStyle(fontFamily: _secondaryTextStyle),
    bodySmall: TextStyle(fontFamily: _secondaryTextStyle),
  );

  static final lightTheme = ThemeData(
    colorScheme: _lightColorScheme,
    fontFamily: _primaryTextStyle,
    textTheme: _textThemeStyle,
  );

  static final darkTheme = ThemeData(
    colorScheme: _darkColorScheme,
    fontFamily: _primaryTextStyle,
    textTheme: _textThemeStyle,
  );
}
