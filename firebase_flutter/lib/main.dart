import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'login.dart';

class AppTheme {
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),

    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF4F8FFF),
      secondary: Color(0xFF4F8FFF),
      surface: Color(0xFF1E1E1E),
      error: Color(0xFFFF6B6B),
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),

    // Use CardThemeData instead of CardTheme
    cardTheme: const CardThemeData(
      color: Color(0xFF1E1E1E),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF2A2A2A),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF4F8FFF),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF4F8FFF),
      foregroundColor: Colors.white,
    ),

    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Color(0xFFB0B0B0)),
    ),
  );
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      darkTheme: AppTheme.darkTheme,
      home: const LoginPage(),
    );
  }
}
