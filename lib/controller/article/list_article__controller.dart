import 'package:get/get.dart';
import 'package:techblog/constant/api_constant.dart';
import 'package:techblog/models/artikel_model.dart';
import 'package:techblog/services.dart/dio_service.dart';

class ListArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList();
  RxBool loading = false.obs;

  @override
  onInit() {
    super.onInit();
    getList();
  }

  getList() async {
    var response = await DioService().getMethod(ApiUrlConstant.getArticleList);
    loading.value = true;

    //TODO:get user from getStorage Api Constant.getArticleList+userid

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }

  getArticleListWithTagsId(String tagId) async {
    articleList.clear();
    var response = await DioService().getMethod(ApiUrlConstant.getArticleList);
    loading.value = true;

    //TODO:get user from getStorage Api Constant.getArticleList+userid

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }
}
