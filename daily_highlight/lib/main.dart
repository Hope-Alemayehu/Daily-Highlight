import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/theme.dart';
import 'services/storage_service.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => StorageService(),
      child: const DailyHighlightApp(),
    ),
  );
}

class DailyHighlightApp extends StatelessWidget {
  const DailyHighlightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Highlight',
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
    );
  }
}
