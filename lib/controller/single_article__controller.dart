// ignore_for_file: unused_local_variable

import 'package:get/get.dart';
import 'package:techblog/component/api_constant.dart';
import 'package:techblog/models/artikel_info_model.dart';
import 'package:techblog/models/artikel_model.dart';
import 'package:techblog/models/tags_model.dart';
import 'package:techblog/services.dart/dio_service.dart';

import '../view/single.dart';

class SingleArticleController extends GetxController {
  RxBool loading = false.obs;
  RxInt id = RxInt(0);
  Rx<ArtikelInfoModle> articleInfoModle = ArtikelInfoModle().obs;
  RxList<TagsModel> tagList = RxList();
  RxList<ArticleModel> releatedList = RxList();
  @override
  onInit() {
    super.onInit();
    getArticleInfo();
  }

  getArticleInfo([String? id]) async {
    articleInfoModle = ArtikelInfoModle().obs;
    //TODO user id is hard code
    var userId = '';
    var response = await DioSevice().getMethod(
        '${ApiConstant.baseUrl}article/get.php?command=info&id=1&user_id=1');
    loading.value = true;
//https:techblog.sasansafari.com/techblog/api/article/get.php?command=info&id=1&user_id=1

    if (response.statusCode == 200) {
      articleInfoModle.value = ArtikelInfoModle.fromJson(response.data);
      loading.value = false;
    }

    tagList.clear();
    response.data['tags'].forEach((element) {
      tagList.add(TagsModel.fromJson(element));
    });

    releatedList.clear();
    response.data['tags'].forEach((element) {
      releatedList.add(ArticleModel.fromJson(element));
    });

    Get.to(Single());
  }
}
