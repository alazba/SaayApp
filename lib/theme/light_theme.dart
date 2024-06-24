import 'package:enjaz_user/utill/app_constants.dart';
import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: AppConstants.fontFamily,
  primaryColor: Color.fromARGB(255, 0, 0, 0),
  secondaryHeaderColor: const Color(0xFFEFE6FE),
  brightness: Brightness.light,
  cardColor: const Color.fromARGB(255, 255, 255, 255),
  focusColor: const Color.fromARGB(255, 255, 255, 255),
  hintColor: const Color(0xFF52575C),
  canvasColor: const Color(0xFFFCFCFC),
  shadowColor: Colors.grey[300],
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Color(0xFF002349))),
  popupMenuTheme: const PopupMenuThemeData(
      color: Colors.white, surfaceTintColor: Colors.white),
  dialogTheme: const DialogTheme(surfaceTintColor: Colors.white),
  colorScheme: ColorScheme(
    background: const Color(0xFFFCFCFC),
    brightness: Brightness.light,
    primary: const Color.fromARGB(255, 174, 181, 196),
    onPrimary: const Color.fromARGB(255, 174, 181, 196),
    secondary: const Color(0xFFEFE6FE),
    onSecondary: const Color(0xFFEFE6FE),
    error: Colors.redAccent,
    onError: Colors.redAccent,
    onBackground: const Color(0xFFC3CAD9),
    surface: Colors.white,
    onSurface: const Color(0xFF002349),
    shadow: Colors.grey[300],
  ),
);
