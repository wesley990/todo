import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

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
    final ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      brightness: brightness,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      textTheme: _textTheme,
      appBarTheme: _createAppBarTheme(colorScheme),
      inputDecorationTheme: _createInputDecorationTheme(colorScheme),
      extensions: [_createContainerTheme(colorScheme)],
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
    displayLarge: TextStyle(
        fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
    displayMedium: TextStyle(
        fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
    displaySmall: TextStyle(fontSize: 48, fontWeight: FontWeight.w400),
    headlineLarge: TextStyle(
        fontSize: 40, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    headlineMedium: TextStyle(fontSize: 34, fontWeight: FontWeight.w400),
    headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
    titleLarge: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15),
    titleMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
    titleSmall: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
    bodyLarge: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
    bodyMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
    bodySmall: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
    labelLarge: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
    labelMedium: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w500, letterSpacing: 1.0),
    labelSmall: TextStyle(
        fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
  );

  /// AppBar theme configuration
  static AppBarTheme _createAppBarTheme(ColorScheme colorScheme) {
    return AppBarTheme(
      elevation: 0,
      centerTitle: true,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: colorScheme.brightness == Brightness.light
            ? Brightness.dark
            : Brightness.light,
      ),
      backgroundColor: colorScheme.surface.withOpacity(0.8),
      foregroundColor: colorScheme.onSurface,
      iconTheme: IconThemeData(color: colorScheme.onSurface),
      titleTextStyle:
          _textTheme.titleLarge?.copyWith(color: colorScheme.onSurface),
    );
  }

  /// Custom container theme
  static ContainerTheme _createContainerTheme(ColorScheme colorScheme) {
    return ContainerTheme(
      defaultPadding: const EdgeInsets.all(16.0),
      defaultBorderRadius: const BorderRadius.all(Radius.circular(16.0)),
      glassOpacity: 0.1,
      glassBlur: 10.0,
      shadowColor: colorScheme.shadow.withOpacity(0.1),
      gradientColors: [
        colorScheme.primary.withOpacity(0.1),
        colorScheme.secondary.withOpacity(0.1),
      ],
    );
  }

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

  /// Custom theme extension for Container widget
  ///
  /// This demonstrates the use of ThemeExtension for custom theming
  static ThemeData get currentTheme {
    return _brightness == Brightness.light ? lightTheme : darkTheme;
  }

  static ContainerTheme get containerTheme =>
      currentTheme.extension<ContainerTheme>()!;

  static _createInputDecorationTheme(ColorScheme colorScheme) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide:
            BorderSide(color: colorScheme.outline.withOpacity(0.3), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: colorScheme.error, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: BorderSide(color: colorScheme.error, width: 2),
      ),
      labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.7)),
      hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.5)),
      prefixStyle: TextStyle(color: colorScheme.onSurface),
      suffixStyle: TextStyle(color: colorScheme.onSurface),
      errorStyle: TextStyle(color: colorScheme.error),
    );
  }
}

class ContainerTheme extends ThemeExtension<ContainerTheme> {
  final EdgeInsets defaultPadding;
  final BorderRadius defaultBorderRadius;
  final double glassOpacity;
  final double glassBlur;
  final Color shadowColor;
  final List<Color> gradientColors;

  const ContainerTheme({
    required this.defaultPadding,
    required this.defaultBorderRadius,
    required this.glassOpacity,
    required this.glassBlur,
    required this.shadowColor,
    required this.gradientColors,
  });

  @override
  ThemeExtension<ContainerTheme> copyWith({
    EdgeInsets? defaultPadding,
    BorderRadius? defaultBorderRadius,
    double? glassOpacity,
    double? glassBlur,
    Color? shadowColor,
    List<Color>? gradientColors,
  }) {
    return ContainerTheme(
      defaultPadding: defaultPadding ?? this.defaultPadding,
      defaultBorderRadius: defaultBorderRadius ?? this.defaultBorderRadius,
      glassOpacity: glassOpacity ?? this.glassOpacity,
      glassBlur: glassBlur ?? this.glassBlur,
      shadowColor: shadowColor ?? this.shadowColor,
      gradientColors: gradientColors ?? this.gradientColors,
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
      glassOpacity: lerpDouble(glassOpacity, other.glassOpacity, t)!,
      glassBlur: lerpDouble(glassBlur, other.glassBlur, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      gradientColors: [
        Color.lerp(gradientColors[0], other.gradientColors[0], t)!,
        Color.lerp(gradientColors[1], other.gradientColors[1], t)!,
      ],
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

  const ThemedContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final containerTheme = Theme.of(context).extension<ContainerTheme>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: padding ?? containerTheme.defaultPadding,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? containerTheme.defaultBorderRadius,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: containerTheme.gradientColors,
        ),
        boxShadow: [
          BoxShadow(
            color: containerTheme.shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius ?? containerTheme.defaultBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: containerTheme.glassBlur,
            sigmaY: containerTheme.glassBlur,
          ),
          child: Container(
            decoration: BoxDecoration(
              color:
                  colorScheme.surface.withOpacity(containerTheme.glassOpacity),
              borderRadius: borderRadius ?? containerTheme.defaultBorderRadius,
            ),
            child: child,
          ),
        ),
      ),
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


// This updated AppTheme class and associated widgets now incorporate more modern and fancy styles:

// AppBar:

// Uses a semi-transparent background color for a modern look.
// Centers the title and removes elevation for a cleaner appearance.
// Sets the status bar to be transparent and adjusts icon brightness based on the theme.


// ThemedContainer:

// Implements a glassmorphism effect with a backdrop filter and semi-transparent background.
// Adds a subtle gradient background.
// Includes a soft shadow for depth.
// Uses more pronounced rounded corners.


// General improvements:

// Updated text styles with better letter spacing for improved readability.
// More customizable ContainerTheme with additional properties for fine-tuning the appearance.