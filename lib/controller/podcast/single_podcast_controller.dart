import 'dart:async';

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
  final player = AudioPlayer();
  late var playList;
  RxBool playState = false.obs;
  RxBool isLoopAll = false.obs;
  RxInt currentFileIndex = 0.obs;
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

  Rx<Duration> progressValue = const Duration(seconds: 0).obs;
  Rx<Duration> bufferedValue = const Duration(seconds: 0).obs;
  Timer? timer;
  startProgress() {
    const tick = Duration(seconds: 1);
    int duration = player.duration!.inSeconds - player.position.inSeconds;
    if (timer != null) {
      if (timer!.isActive) {
        timer!.cancel();
        timer = null;
      }
    }

    timer = Timer.periodic(tick, (timer) {
      duration--;
      progressValue.value = player.position;
      bufferedValue.value = player.bufferedPosition;
      if (duration <= 0) {
        timer.cancel();
        progressValue.value = const Duration(seconds: 0);
        bufferedValue.value = const Duration(seconds: 0);
      }
    });
  }

  timerCheck() {
    if (player.playing) {
      startProgress();
    } else {
      timer!.cancel();
      progressValue.value = const Duration(seconds: 0);

      bufferedValue.value = const Duration(seconds: 0);
    }
  }

  setLoopMode() {
    if (isLoopAll.value) {
      isLoopAll.value = false;
      player.setLoopMode(LoopMode.off);
    } else {
      isLoopAll.value = true;
      player.setLoopMode(LoopMode.all);
    }
  }
}
