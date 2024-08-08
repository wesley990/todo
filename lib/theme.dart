import 'dart:ui';

import 'package:flutter/material.dart';

/// AppTheme provides a centralized theme configuration for the application.
/// It follows modern Flutter theming capabilities and best practices for theme management.
///
/// Key features:
/// - Singleton pattern to ensure a single instance of the theme
/// - Factory method for creating theme data
/// - Extension methods for custom theming
/// - Static access to theme properties for easy use throughout the app
/// - Null safety
/// - Separation of concerns
///
/// Usage:
/// - In main.dart:
///   ```
///   MaterialApp(
///     theme: AppTheme.lightTheme,
///     darkTheme: AppTheme.darkTheme,
///   )
///   ```
/// - Accessing theme properties:
///   ```
///   Color primaryColor = AppTheme.colorScheme.primary;
///   TextStyle headlineStyle = AppTheme.textTheme.headlineMedium!;
///   ```
class AppTheme {
  // Private constructor to prevent instantiation
  AppTheme._();

  // Seed colors for light and dark themes
  static const Color _lightSeedColor = Colors.blue;
  static const Color _darkSeedColor = Colors.indigo;

  /// Creates a ThemeData object based on the given brightness and seed color
  ///
  /// This factory method encapsulates the theme creation logic, promoting DRY principle
  static ThemeData _createTheme(Brightness brightness, Color seedColor) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        brightness: brightness,
      ),
      textTheme: _textTheme,
      appBarTheme: _appBarTheme,
      extensions: const [_containerTheme],
    );
  }

  /// Light theme configuration
  static final ThemeData lightTheme =
      _createTheme(Brightness.light, _lightSeedColor);

  /// Dark theme configuration
  static final ThemeData darkTheme =
      _createTheme(Brightness.dark, _darkSeedColor);

  /// Static text theme for consistent typography across the app
  static const TextTheme _textTheme = TextTheme(
    displayLarge: TextStyle(fontSize: 96, fontWeight: FontWeight.w300),
    displayMedium: TextStyle(fontSize: 60, fontWeight: FontWeight.w400),
    displaySmall: TextStyle(fontSize: 48, fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(fontSize: 40, fontWeight: FontWeight.w400),
    headlineMedium: TextStyle(fontSize: 34, fontWeight: FontWeight.w400),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
    titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
    titleMedium: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
    bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
    bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
    labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
  );

  /// AppBar theme configuration
  static const AppBarTheme _appBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: _lightSeedColor,
  );

  /// Custom container theme
  static const ContainerTheme _containerTheme = ContainerTheme(
    defaultPadding: EdgeInsets.all(16.0),
    defaultBorderRadius: BorderRadius.all(Radius.circular(8.0)),
  );

  /// Simplified access to color scheme
  ///
  /// Usage: `Color primaryColor = AppTheme.colorScheme.primary;`
  static ColorScheme get colorScheme => _brightness == Brightness.light
      ? lightTheme.colorScheme
      : darkTheme.colorScheme;

  /// Simplified access to text theme
  ///
  /// Usage: `TextStyle bodyStyle = AppTheme.textTheme.bodyLarge!;`
  static TextTheme get textTheme => _textTheme;

  /// Determine the current brightness
  static Brightness get _brightness =>
      PlatformDispatcher.instance.platformBrightness;
}

/// Custom theme extension for Container widget
///
/// This demonstrates the use of ThemeExtension for custom theming
class ContainerTheme extends ThemeExtension<ContainerTheme> {
  final EdgeInsets defaultPadding;
  final BorderRadius defaultBorderRadius;

  const ContainerTheme({
    required this.defaultPadding,
    required this.defaultBorderRadius,
  });

  @override
  ThemeExtension<ContainerTheme> copyWith({
    EdgeInsets? defaultPadding,
    BorderRadius? defaultBorderRadius,
  }) {
    return ContainerTheme(
      defaultPadding: defaultPadding ?? this.defaultPadding,
      defaultBorderRadius: defaultBorderRadius ?? this.defaultBorderRadius,
    );
  }

  @override
  ThemeExtension<ContainerTheme> lerp(
      ThemeExtension<ContainerTheme>? other, double t) {
    if (other is! ContainerTheme) {
      return this;
    }
    return ContainerTheme(
      defaultPadding: EdgeInsets.lerp(defaultPadding, other.defaultPadding, t)!,
      defaultBorderRadius:
          BorderRadius.lerp(defaultBorderRadius, other.defaultBorderRadius, t)!,
    );
  }
}

/// A custom Container widget that uses the ContainerTheme
///
/// This demonstrates how to create custom, themed components
/// that respect the app's theme
class ThemedContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final Color? color;

  const ThemedContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final containerTheme = Theme.of(context).extension<ContainerTheme>()!;
    return Container(
      padding: padding ?? containerTheme.defaultPadding,
      decoration: BoxDecoration(
        color: color ?? AppTheme.colorScheme.surface,
        borderRadius: borderRadius ?? containerTheme.defaultBorderRadius,
      ),
      child: child,
    );
  }
}

// Singleton Pattern: The AppTheme class uses a private constructor to prevent instantiation, effectively making it a singleton.單例模式：AppTheme
// Factory Method: The _createTheme method acts as a factory for creating ThemeData objects, allowing for easy customization and extension.
// Extension Methods: The ContainerTheme is implemented as a ThemeExtension, demonstrating how to add custom theme properties.
// Immutability: All theme properties are declared as final, promoting immutability and preventing accidental modifications.
// Separation of Concerns: The theme logic is encapsulated within the AppTheme class, separating it from the rest of the application code.
// Null Safety: The code fully embraces Dart's null safety features, using non-nullable types where appropriate.
// Static Access: Theme properties are accessible as static members, simplifying usage throughout the app.
// Custom Widgets: The ThemedContainer widget demonstrates how to create custom, themed components that respect the app's theme.
// DRY Principle: The use of the _createTheme method reduces code duplication between light and dark themes.
// SOLID Principles: The design adheres to Single Responsibility (each class has a single purpose) and Open/Closed (the theme can be extended without modifying existing code) principles.

// import 'package:flutter/material.dart';
// import 'path_to_your_theme_file/app_theme.dart';

// void main() {
//   runApp(MyApp());
// }

// Example:
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Your App Name',
//       theme: AppTheme.lightTheme,
//       darkTheme: AppTheme.darkTheme,
//       themeMode: ThemeMode.system, // Use system theme by default
//       home: YourHomePage(),
//     );
//   }
// }

// Example:
// class MyWidget extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Text(
//           'Headline',
//           style: AppTheme.textTheme.headlineMedium?.copyWith(
//             color: AppTheme.colorScheme.primary,
//           ),
//         ),
//         ThemedContainer(
//           child: Text('This is a themed container'),
//         ),
//         ElevatedButton(
//           child: Text('Click me'),
//           style: ElevatedButton.styleFrom(
//             primary: AppTheme.colorScheme.secondary,
//           ),
//           onPressed: () {},
//         ),
//       ],
//     );
//   }
// }
