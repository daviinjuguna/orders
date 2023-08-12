import 'package:flutter/material.dart';

class AppUi {
  const AppUi();
  ThemeData get theme => ThemeData.from(
        colorScheme: color,
        useMaterial3: true,
      ).copyWith(
        appBarTheme: const AppBarTheme(
          centerTitle: true,
        ),
        buttonTheme: ButtonThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.all(10),
        ),
      );

  ColorScheme get color => const ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xff556500),
        onPrimary: Color(0xffffffff),
        primaryContainer: Color(0xffdaeb8f),
        onPrimaryContainer: Color(0xff12140c),
        secondary: Color(0xff8c7519),
        onSecondary: Color(0xffffffff),
        secondaryContainer: Color(0xfffff0c7),
        onSecondaryContainer: Color(0xff141411),
        tertiary: Color(0xff00687b),
        onTertiary: Color(0xffffffff),
        tertiaryContainer: Color(0xffaeecff),
        onTertiaryContainer: Color(0xff0f1414),
        error: Color(0xffba1a1a),
        onError: Color(0xffffffff),
        errorContainer: Color(0xffffdad6),
        onErrorContainer: Color(0xff141212),
        background: Color(0xfffafaf8),
        onBackground: Color(0xff090909),
        surface: Color(0xfffafaf8),
        onSurface: Color(0xff090909),
        surfaceVariant: Color(0xffe5e6e0),
        onSurfaceVariant: Color(0xff111211),
        outline: Color(0xff7c7c7c),
        outlineVariant: Color(0xffc8c8c8),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xff121310),
        onInverseSurface: Color(0xfff5f5f5),
        inversePrimary: Color(0xffccd88c),
        surfaceTint: Color(0xff556500),
      );
}

class DarkAppUi extends AppUi {
  const DarkAppUi();
  @override
  ColorScheme get color => const ColorScheme(
        brightness: Brightness.dark,
        primary: Color(0xffbcd063),
        onPrimary: Color(0xff12140b),
        primaryContainer: Color(0xff3f4c00),
        onPrimaryContainer: Color(0xffe9ebdf),
        secondary: Color(0xffffe17b),
        onSecondary: Color(0xff14140d),
        secondaryContainer: Color(0xff3b2f00),
        onSecondaryContainer: Color(0xffe9e7df),
        tertiary: Color(0xff78d3ec),
        onTertiary: Color(0xff0d1414),
        tertiaryContainer: Color(0xff224e43),
        onTertiaryContainer: Color(0xffe5ecea),
        error: Color(0xffffb4ab),
        onError: Color(0xff141211),
        errorContainer: Color(0xff93000a),
        onErrorContainer: Color(0xfff6dfe1),
        background: Color(0xff191a15),
        onBackground: Color(0xffecedec),
        surface: Color(0xff191a15),
        onSurface: Color(0xffecedec),
        surfaceVariant: Color(0xff404236),
        onSurfaceVariant: Color(0xffe1e1df),
        outline: Color(0xff767d76),
        outlineVariant: Color(0xff2c2e2c),
        shadow: Color(0xff000000),
        scrim: Color(0xff000000),
        inverseSurface: Color(0xfffbfcf7),
        onInverseSurface: Color(0xff131313),
        inversePrimary: Color(0xff5f6839),
        surfaceTint: Color(0xffbcd063),
      );
}
