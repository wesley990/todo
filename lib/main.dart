import 'package:flutter/material.dart';
import 'package:todo/home/home.dart';
import 'package:todo/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    } catch (e) {
      debugPrint('Failed to initialize Firebase: $e');
      rethrow; // This will allow the error to be caught in the FutureBuilder
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error initializing Firebase: ${snapshot.error}'),
              ),
            ),
          );
        }
        return MaterialApp(
          title: 'Todo App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          home: const HomeScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}


// Here's an analysis of the changes and the minor improvements I've added:

// Async Initialization: Your approach of using FutureBuilder to handle the asynchronous initialization of Firebase is excellent. It ensures that the app doesn't proceed until Firebase is ready, and it handles loading and error states appropriately.
// Error Handling: I've enhanced the error handling in the _initializeFirebase method. Now it catches any exceptions, logs them, and rethrows them. This allows the error to be caught and displayed in the FutureBuilder.
// Error Display: In the error case of the FutureBuilder, I've modified it to display the actual error message. This can be helpful for debugging.
// App Title: I've added a title to the MaterialApp widget, which is a good practice.
// Debug Banner: I've disabled the debug banner with debugShowCheckedModeBanner: false. This is often preferred for production apps.

// Additional suggestions:

// Localization: If you plan to support multiple languages, consider setting up localization.
// Routes: As your app grows, you might want to implement named routes for better navigation management.
// State Management: For more complex apps, consider using a state management solution like Provider, Riverpod, or BLoC.
// Error Handling Strategy: Depending on your app's requirements, you might want to implement a more sophisticated error handling strategy, possibly with custom error pages or error reporting to a backend service.
// Theming: Your use of light and dark themes is good. Consider expanding on this by creating a comprehensive theme that covers all aspects of your app's design.

// This version of your code is well-structured and follows many Flutter best practices, especially in terms of handling asynchronous initialization and error states. It provides a solid foundation for building out the rest of your app.