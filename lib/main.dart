import 'package:crypyo_app/src/schemes/color_schemes.g.dart';
import 'package:flutter/material.dart';

import 'crypto_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Crypto App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: lightColorScheme,
        scaffoldBackgroundColor: lightColorScheme.background,
        appBarTheme: AppBarTheme(
            centerTitle: true, backgroundColor: lightColorScheme.primary),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: lightColorScheme.primary),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: darkColorScheme.background,
        colorScheme: darkColorScheme,
        appBarTheme: const AppBarTheme(
            centerTitle: true, backgroundColor: Colors.transparent),
      ),
      home: CryptoApp(),
    );
  }
}
