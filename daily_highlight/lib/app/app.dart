import 'package:daily_highlight/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:daily_highlight/services/storage_service.dart';

import 'package:daily_highlight/app/theme.dart';

class DailyHighlightApp extends StatelessWidget {
  const DailyHighlightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => StorageService())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Daily Highlight',
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.system, // Auto light/dark mode
        home: const HomeScreen(),
      ),
    );
  }
}
