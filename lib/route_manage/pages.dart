import 'package:get/get.dart';
import 'package:techblog/route_manage/binding.dart';
import 'package:techblog/route_manage/names.dart';
import 'package:techblog/view/article/manage_article.dart';
import 'package:techblog/view/article/single%20_manage_article.dart';
import 'package:techblog/view/article/single.dart';
import 'package:techblog/view/main_screen.dart';
import 'package:techblog/view/podcast/single_podcast.dart';
import 'package:techblog/view/splash_screen.dart';

class Pages {
  Pages._();
  static List<GetPage<dynamic>> pages = [
    GetPage(
        name: NamedRoute.routMainSCreen,
        page: () => MainScreen(),
        binding: RegisterBinding()),
    GetPage(
      name: NamedRoute.initialRoute,
      page: () => SplashScreen(),
    ),
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
  ];
}
