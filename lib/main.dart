import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:techblog/component/my_colors.dart';
import 'package:techblog/view/registerintro.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    // SystemUiOverlayStyle.light

    const SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var texttheme = Theme.of(context).textTheme;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Localizations Sample App',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        // Locale('fa'), // farsi
        Locale('en'), // english
      ],
      theme: ThemeData(
        fontFamily: 'B-ROYA',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
              fontFamily: 'BROYABD',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: SolidColors.lightTextcolor),
          titleMedium: TextStyle(
              fontFamily: 'BROYA',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: SolidColors.textTitelcolor),
          titleSmall: TextStyle(
              fontFamily: 'BROYA',
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: SolidColors.colorTitel),
          bodyMedium: TextStyle(
              fontFamily: 'BROYA',
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: SolidColors.textTitelcolor),
          bodyLarge: TextStyle(
            fontFamily: 'BROYA',
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: SolidColors.lightTextcolor,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(width: 2),
            ),
            filled: true,
            fillColor: Colors.white),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return texttheme.bodyMedium;
              }
              return texttheme.titleMedium;
            }),
            backgroundColor: MaterialStateColor.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return SolidColors.primeryColor;
              }
              return Colors.amber;
            }),
          ),
        ),
      ),

      // home: SplashScreen(),
      home: const RegisterIntro(),
    );
  }
}
