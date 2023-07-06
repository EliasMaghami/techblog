import 'package:get/get.dart';
import 'package:techblog/controller/list_article__controller.dart';
import 'package:techblog/controller/single_article__controller.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.put(ListArticleController());

    Get.lazyPut(() => SingleArticleController());
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.put(ListArticleController());

    Get.lazyPut(() => SingleArticleController());
  }
}
