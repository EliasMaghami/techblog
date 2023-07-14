import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog/route_manage/binding.dart';
import 'package:techblog/constant/my_colors.dart';
import 'package:techblog/route_manage/names.dart';
import 'package:techblog/route_manage/pages.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    // SystemUiOverlayStyle.light

    const SystemUiOverlayStyle(
      statusBarColor: SolidColors.statusBarColor,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: SolidColors.systemNavigationBarColor,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  await GetStorage.init();
  runApp(const MyApp());
}

// ignore: duplicate_ignore
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return GetMaterialApp(
      initialRoute: NamedRoute.initialRoute,
      initialBinding: RegisterBinding(),
      debugShowCheckedModeBanner: false,
      theme: lightTheme(textTheme),
      locale: const Locale('en'), // english
      // localizationsDelegates: const [
      // GlobalMaterialLocalizations.delegate,
      // GlobalWidgetsLocalizations.delegate,
      // GlobalCupertinoLocalizations.delegate,
      // ],
      getPages: Pages.pages,
    );
  }

  ThemeData lightTheme(TextTheme textTheme) {
    return ThemeData(
      fontFamily: 'B-ROYA',
      textTheme: const TextTheme(
        titleLarge: TextStyle(
            fontFamily: 'BROYABD',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: SolidColors.lightTextColor),
        titleMedium: TextStyle(
            fontFamily: 'BROYA',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: SolidColors.textTitleColor),
        titleSmall: TextStyle(
            fontFamily: 'BROYA',
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: SolidColors.colorTitle),
        bodyMedium: TextStyle(
            fontFamily: 'BROYA',
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: SolidColors.textTitleColor),
        bodyLarge: TextStyle(
          fontFamily: 'BROYA',
          fontSize: 14,
          fontWeight: FontWeight.w300,
          color: SolidColors.lightTextColor,
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
              return textTheme.bodyMedium;
            }
            return textTheme.titleMedium;
          }),
          backgroundColor: MaterialStateColor.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return SolidColors.primaryColor;
            }
            return Colors.amber;
          }),
        ),
      ),
    );
  }
}
