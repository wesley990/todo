import 'package:flutter/material.dart';
import 'package:todo/home/home.dart';
import 'package:todo/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'firebase_options.dart';

void main() async {
  try {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    await initializeApp();

    FlutterNativeSplash.remove();

    runApp(const MainApp());
  } catch (e, stackTrace) {
    debugPrint('Error in main: $e');
    debugPrint('Stack trace: $stackTrace');
    // In a production app, you might want to show an error screen here
    runApp(const ErrorApp());
  }
}

Future<void> initializeApp() async {
  try {
    debugPrint('Starting app initialization...');

    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    debugPrint('Firebase initialized successfully');

    // Add any other initialization logic here
    // await Future.delayed(
    //     const Duration(seconds: 2)); // Simulated delay, remove in production
    debugPrint('Initialization complete');
  } catch (e, stackTrace) {
    debugPrint('Failed to initialize app: $e');
    debugPrint('Stack trace: $stackTrace');
    // Rethrow the error to be caught in the main function
    rethrow;
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

class ErrorApp extends StatelessWidget {
  const ErrorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            'An error occurred during initialization. Please check the logs and restart the app.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.red[800], fontSize: 16),
          ),
        ),
      ),
    );
  }
}
