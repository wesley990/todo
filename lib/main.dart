import 'package:flutter/material.dart';
import 'package:todo/home/home.dart';
import 'package:todo/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await initializeApp();

  FlutterNativeSplash.remove();

  runApp(const MainApp());
}

Future<void> initializeApp() async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    // Add any other initialization logic here
    // await Future.delayed(
    //     const Duration(seconds: 2)); // Simulated delay, remove in production
  } catch (e) {
    debugPrint('Failed to initialize app: $e');
    // Handle initialization error
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
