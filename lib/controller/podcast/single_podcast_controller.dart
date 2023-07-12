import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:techblog/constant/api_constant.dart';
import 'package:techblog/services.dart/dio_service.dart';

import '../../models/podcast_file__model.dart';

class SinglePodcastController extends GetxController {
  // ignore: prefer_typing_uninitialized_variables
  var id;

  SinglePodcastController({this.id});
  RxBool loading = false.obs;

  RxList<PodcastFileModel> podcastFileList = RxList();

  late var playList;
  @override
  onInit() {
    super.onInit();
    playList = ConcatenatingAudioSource(useLazyPreparation: true, children: []);
    podcastFile();
  }

  podcastFile() async {
    loading.value = true;
    var response =
        await DioService().getMethod(ApiUrlConstant.PodcastFile + id);

    if (response.statusCode == 200) {
      for (var element in response.data["file"]) {
        podcastFileList.add(
          PodcastFileModel.fromJson(element),
        );

        playList.add(
          AudioSource.uri(
            Uri.parse(PodcastFileModel.fromJson(element).file!),
          ),
        );
      }
    }
    loading.value = false;
  }
}
