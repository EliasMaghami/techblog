// ignore_for_file: must_be_immutable

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:techblog/component/decrations.dart';
import 'package:techblog/component/dimens.dart';
import 'package:techblog/component/mycomponent.dart';
import 'package:techblog/constant/my_colors.dart';
import 'package:techblog/controller/podcast/single_podcast_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/models/podcast_model.dart';

class PodcastSingle extends StatelessWidget {
  late SinglePodcastController controller;
  late PodcastModel podcastModel;
  // ignore: use_key_in_widget_constructors
  PodcastSingle() {
    podcastModel = Get.arguments;
    controller = Get.put(SinglePodcastController(id: podcastModel.id));
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(
                          height: Get.height / 3,
                          width: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl: podcastModel.poster!,
                            imageBuilder: (context, imageProvider) =>
                                Image(image: imageProvider),
                            placeholder: (context, url) => const loading(),
                            errorWidget: (context, url, error) => Image(
                                image: Assets.image.fullstack.image().image),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: GradientColors.singleAppBar,
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  const Icon(
                                    Icons.share,
                                    color: Colors.orange,
                                    size: 24,
                                  ),
                                  const Expanded(child: SizedBox()),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () => Get.back(),
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.orange,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                ]),
                          ),
                        )
                      ],
                    ),
                    //title
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          podcastModel.title!,
                          maxLines: 2,
                          style: textTheme.titleMedium,
                        ),
                      ),
                    ),
                    //writer
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 50,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            podcastModel.publisher!,
                            style: textTheme.titleMedium,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                    //file List
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => ListView.builder(
                            itemCount: controller.podcastFileList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () async {
                                  await controller.player
                                      .seek(Duration.zero, index: index);
                                  controller.currentFileIndex.value =
                                      controller.player.currentIndex!;

                                  controller.timerCheck();
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          ImageIcon(
                                            Assets.icons.micIcon.image().image,
                                            color: SolidColors
                                                .selectedPodCastColor,
                                          ),
                                          SizedBox(
                                            width: Get.width / 1.5,
                                            child: Obx(
                                              () => Text(
                                                controller
                                                    .podcastFileList[index]
                                                    .title!,
                                                style: controller
                                                            .currentFileIndex
                                                            .value ==
                                                        index
                                                    ? textTheme.titleSmall
                                                    : textTheme.titleMedium,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                          "${controller.podcastFileList[index].length!}:00")
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            //player manager
            Positioned(
              bottom: 8,
              left: Dimens.bodyMargin,
              right: Dimens.bodyMargin,
              child: Container(
                height: Get.height / 7,
                decoration: MyDecorations.mainGradient,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Obx(
                        () => ProgressBar(
                          timeLabelTextStyle:
                              const TextStyle(color: Colors.white),
                          thumbColor: Colors.amber,
                          baseBarColor: Colors.white,
                          progressBarColor: Colors.orange,
                          buffered: controller.bufferedValue.value,
                          progress: controller.progressValue.value,
                          total: controller.player.duration ??
                              const Duration(seconds: 0),
                          onSeek: (Position) async {
                            controller.player.seek(Position);

                            if (controller.player.playing) {
                              controller.startProgress();
                            } else if (Position <= const Duration(seconds: 0)) {
                              await controller.player.seekToNext();
                              controller.currentFileIndex.value =
                                  controller.player.currentIndex!;
                              controller.timerCheck();
                            }
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await controller.player.seekToNext();
                              controller.currentFileIndex.value =
                                  controller.player.currentIndex!;
                              controller.timerCheck();
                            },
                            child: const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.player.playing
                                  ? controller.timer!.cancel()
                                  : controller.startProgress();

                              controller.player.playing
                                  ? controller.player.pause()
                                  : controller.player.play();

                              controller.playState.value =
                                  controller.player.playing;

                              controller.currentFileIndex.value =
                                  controller.player.currentIndex!;
                            },
                            child: Obx(
                              () => Icon(
                                controller.playState.value
                                    ? Icons.pause_circle_filled
                                    : Icons.play_circle_filled,
                                color: Colors.white,
                                size: 35,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await controller.player.seekToPrevious();
                              controller.currentFileIndex.value =
                                  controller.player.currentIndex!;
                              controller.timerCheck();
                            },
                            child: const Icon(
                              Icons.skip_previous,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(),
                          Obx(
                            () => GestureDetector(
                              onTap: () async {
                                //   await controller.player.setLoopMode(LoopMode.one);
                                //   controller.currentFileIndex.value =
                                //       controller.player.currentIndex!;
                              },
                              child: Icon(
                                Icons.repeat,
                                color: controller.isLoopAll.value
                                    ? Colors.blue
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
