import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog/binding.dart';
import 'package:techblog/constant/my_colors.dart';
import 'package:techblog/view/article/manage_article.dart';
import 'package:techblog/view/article/single%20_manage_article.dart';
import 'package:techblog/view/main_screen.dart';
import 'package:techblog/view/article/single.dart';
import 'package:techblog/view/podcast/single_podcast.dart';
import 'package:techblog/view/splash_screen.dart';

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
    var texttheme = Theme.of(context).textTheme;

    return GetMaterialApp(
      initialBinding: RegisterBinding(),
      debugShowCheckedModeBanner: false,
      theme: ligthTheme(texttheme),
      locale: const Locale('en'), // english
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      getPages: [
        GetPage(
            name: NamedRoute.routMainSCreen,
            page: () => MainScreen(),
            binding: RegisterBinding()),
        GetPage(
            name: NamedRoute.routSingleArticle,
            page: () => Single(),
            binding: ArticleBinding()),
        GetPage(
            name: NamedRoute.manageArticle,
            page: () => ManageArticle(),
            binding: ArticleManagerBinding()),
        GetPage(
            name: NamedRoute.singleManageArticle,
            page: () => SingleManageArticle(),
            binding: ArticleManagerBinding()),
        GetPage(
          name: NamedRoute.singlePodcast,
          page: () => PodcastSingle(),
        ),
      ],

      home: SplashScreen(),
      //
    );
  }

  ThemeData ligthTheme(TextTheme texttheme) {
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
              return texttheme.bodyMedium;
            }
            return texttheme.titleMedium;
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

class NamedRoute {
  NamedRoute._();
  static String routMainSCreen = "/MainScreen";
  static String routSingleArticle = "/SingleArticle";
  static String manageArticle = "/ManageArticle";
  static String singleManageArticle = "/SingleManageArticle";
  static String singlePodcast = "/singlePodcast";
}
