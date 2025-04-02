import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primarySwatch: Colors.teal,
  scaffoldBackgroundColor: Colors.grey[50],
  cardColor: Colors.white,
  appBarTheme: const AppBarTheme(elevation: 0),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);

final darkTheme = ThemeData(
  primarySwatch: Colors.teal,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.grey[900],
  cardColor: Colors.grey[800],
  appBarTheme: const AppBarTheme(elevation: 0),
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
