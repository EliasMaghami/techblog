import 'package:get/get.dart';
import 'package:techblog/constant/api_constant.dart';
import 'package:techblog/models/artikel_model.dart';
import 'package:techblog/models/podcast_model.dart';
import 'package:techblog/models/poster_model.dart';
import 'package:techblog/services.dart/dio_service.dart';

class HomeScreenController extends GetxController {
  late Rx<PosterModel> poster = PosterModel().obs;
  RxList tagsList = RxList();
  RxList<ArticleModel> topVisitedList = RxList();
  RxList<PodcastModel> topPodcasts = RxList();
  RxBool loading = false.obs;

  get value => null;

  @override
  onInit() {
    super.onInit();
    getHomeItem();
  }

  getHomeItem() async {
    var response = await DioService().getMethod(ApiUrlConstant.getHomeItem);
    loading.value = true;
    if (response.statusCode == 200) {
      response.data['top_visited'].forEach((element) {
        topVisitedList.add(ArticleModel.fromJson(element));
      });
      response.data['top_visited'].forEach((element) {
        topPodcasts.add(PodcastModel.fromJson(element));
      });

      response.data['tags'].forEach((element) {
        tagsList.add(PodcastModel.fromJson(element));
      });

      poster.value = PosterModel.fromJson(response.data['poster']);

      loading.value = false;
    }
  }
}
