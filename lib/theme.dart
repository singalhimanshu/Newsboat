import 'package:flutter/material.dart';
import 'package:newsboat/colors.dart';

final ThemeData defaultTheme = _buildDefaultTheme();

ThemeData _buildDefaultTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: colorHackerBackground,
    accentColor: colorHackerBorder,
    fontFamily: 'roboto',
    primaryTextTheme: TextTheme(
      headline6: TextStyle(),
    ).apply(
      bodyColor: colorHackerHeading,
      displayColor: colorHackerHeading,
    ),
  );
}
