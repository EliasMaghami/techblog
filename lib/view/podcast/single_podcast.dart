// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:techblog/component/decrations.dart';
import 'package:techblog/component/dimens.dart';
import 'package:techblog/component/mycomponent.dart';
import 'package:techblog/constant/my_colors.dart';
import 'package:techblog/controller/podcast/single_podcast_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/models/podcast_model.dart';

class PodcastSingle extends StatelessWidget {
  late SinglePodcastController singlePodcastController;
  late PodcastModel podcastModel;
  // ignore: use_key_in_widget_constructors
  PodcastSingle() {
    podcastModel = Get.arguments;
    singlePodcastController =
        Get.put(SinglePodcastController(id: podcastModel.id));
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
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          podcastModel.title!,
                          maxLines: 2,
                          style: textTheme.bodyMedium,
                        ),
                      ),
                    ),
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
                            style: textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Obx(
                        () => ListView.builder(
                            itemCount:
                                singlePodcastController.podcastFileList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        ImageIcon(
                                          Assets.icons.micIcon.image().image,
                                          color:
                                              SolidColors.selectedPodCastColor,
                                        ),
                                        SizedBox(
                                          width: Get.width / 1.5,
                                          child: Text(
                                            singlePodcastController
                                                .podcastFileList[index].title!,
                                            style: textTheme.bodyMedium,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                        "${singlePodcastController.podcastFileList[index].length!}:00")
                                  ],
                                ),
                              );
                            }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                      LinearPercentIndicator(
                        percent: 1.0,
                        backgroundColor: Colors.white,
                        progressColor: Colors.amber,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(
                            Icons.skip_next,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.play_circle_fill_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                          Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                          ),
                          SizedBox(),
                          Icon(
                            Icons.repeat,
                            color: Colors.white,
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
