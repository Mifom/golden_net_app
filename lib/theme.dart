import 'package:flutter/material.dart';

const Color _gold = Color(0xFFDCC69A);
const Color _gold_dark = Color(0xFFC48F2D);
const Color _blue_grey = Color(0xFF6B7B93);

final ColorScheme colorScheme = ColorScheme(
    primary: Colors.white,
    primaryVariant: Colors.white,
    secondary: _blue_grey,
    secondaryVariant: _blue_grey,
    surface: Colors.white,
    background: const Color(0xFFF7F7F7),
    error: Colors.red,
    onPrimary: Colors.black,
    onSecondary: Colors.white,
    onSurface: Colors.black,
    onBackground: Colors.black,
    onError: Colors.white,
    brightness: Brightness.light);
final TextTheme textTheme = TextTheme();
ThemeData get themeData {
  final base = ThemeData.light();
  return base.copyWith(
      visualDensity: VisualDensity.adaptivePlatformDensity,
      primaryColor: colorScheme.primary,
      primaryTextTheme:
          _buildTextTheme(base.primaryTextTheme, colorScheme.onPrimary),
      primaryIconTheme:
          base.primaryIconTheme.copyWith(color: colorScheme.onPrimary),
      primaryColorDark: colorScheme.primaryVariant,
      primaryColorLight: colorScheme.primaryVariant,
      accentColor: colorScheme.secondary,
      accentTextTheme:
          _buildTextTheme(base.accentTextTheme, colorScheme.onSecondary),
      accentIconTheme:
          base.accentIconTheme.copyWith(color: colorScheme.onSecondary),
      buttonColor: colorScheme.secondary,
      cardColor: Colors.white,
      textSelectionColor: colorScheme.secondary,
      errorColor: colorScheme.error,
      buttonTheme: base.buttonTheme.copyWith(
        textTheme: ButtonTextTheme.primary,
        buttonColor: colorScheme.secondary,
        hoverColor: colorScheme.secondaryVariant,
        focusColor: colorScheme.secondaryVariant,
      ),
      textSelectionHandleColor: colorScheme.secondary,
      textTheme: _buildTextTheme(base.textTheme, colorScheme.onSurface),
      colorScheme: colorScheme,
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
        },
      ));
}

TextTheme _buildTextTheme(TextTheme base, Color color) {
  return base.apply(
      fontFamily: "Museo", displayColor: color, bodyColor: color);
}
