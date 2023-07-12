// ignore_for_file: unnecessary_import, camel_case_types

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:techblog/controller/home_screen_controller.dart';
import 'package:techblog/component/mycomponent.dart';
import 'package:techblog/controller/article/single_article__controller.dart';
import 'package:techblog/main.dart';
import 'package:techblog/view/article/articel_list_screen.dart';
import '../models/fake_data.dart';
import 'package:techblog/constant/my_colors.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({
    super.key,
    required this.size,
    required this.texttheme,
    required this.bodyMargin,
  });

  final Size size;
  final TextTheme texttheme;
  final double bodyMargin;

  HomeScreenController homeScreenController = Get.put(HomeScreenController());
  SingleArticleController singleArticleController =
      Get.put(SingleArticleController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(
        () => Padding(
          padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
          child: homeScreenController.value == false
              ? Column(
                  children: [
                    //postr
                    poster(),
                    const SizedBox(
                      height: 20,
                    ),
                    //tagList
                    tags(),
                    const SizedBox(
                      height: 20,
                    ),

                    //seemore: hamon titre balay posts & podcast
                    GestureDetector(
                        onTap: () => Get.to(ArticleListScreen()),
                        child: SeeMoreBlog(
                          bodyMargin: bodyMargin,
                          textTheme: texttheme,
                          title: 'Show me title',
                        )),
                    //blog List
                    topVsited(),
                    const SizedBox(
                      height: 20,
                    ),

                    //padcastlist
                    //niyaz be eslah va icon microphon darad.
                    topPodcast(),
                    const SizedBox(
                      height: 60,
                    )
                  ],
                )
              : const loading(),
        ),
      ),
    );
  }

  Widget topVsited() {
    return SizedBox(
      height: size.height / 3.5,
      child: Obx(
        () => ListView.builder(
            itemCount: homeScreenController.topVisitedList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              //lastest post
              //pading wrap ba column ta neveshte zir image gharar begireh.
              return GestureDetector(
                onTap: () => Get.find<SingleArticleController>().getArticleInfo(
                    HomeScreenController().topVisitedList[index].id),
                child: Padding(
                  padding: EdgeInsets.only(left: bodyMargin),
                  child: Column(
                    children: [
                      CachedNetworkImage(
                        imageUrl:
                            homeScreenController.topPodcasts[index].poster!,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16)),
                            image: DecorationImage(
                                image: imageProvider, fit: BoxFit.cover),
                          ),
                        ),
                        placeholder: (context, url) => const loading(),
                        errorWidget: (context, url, error) => const Icon(
                          Icons.image_not_supported_outlined,
                          size: 50,
                          color: Colors.amber,
                        ),
                      ),
                      SizedBox(
                        height: size.height / 5.3,
                        width: size.width / 2.4,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                //inja image bayad az Url bevasile NetworkImage initializ shavad.
                                // image: DecorationImage(image: NetworkImage(blogList[index].imageUr),
                                // fit: BoxFit.cover,

                                //image besorat dasti vared shode va eshtebah ast.
                                image: DecorationImage(
                                  image: NetworkImage(homeScreenController
                                      .topVisitedList[index].image!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              foregroundDecoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15)),
                                  gradient: LinearGradient(
                                    colors: GradientColors.battenNavigation,
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topLeft,
                                  )),
                            ),
                            Positioned(
                              bottom: 8,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    //bad az dastresi be Url in code faal shavad
                                    // blogList[index].writer

                                    HomePagePosterMap["writer"] +
                                        " - " +
                                        HomePagePosterMap["view"],
                                    //bad az dastresi be Url in code faal shavad
                                    //blogList[index].views,
                                    style: texttheme.bodyLarge,
                                  ),
                                  const Icon(
                                    Icons.remove_red_eye_sharp,
                                    color: Colors.white,
                                    size: 14,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Url to do
                      // Text(blogList[index].title),
                      SizedBox(
                        //saizbox bayad bezarim va weidth bedim.
                        width: size.width / 2.4,
                        child: Text(
                          homeScreenController.tagsList[index].author!,
                          style: texttheme.bodyMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget topPodcast() {
    return SizedBox(
      height: size.height / 3.5,
      child: Obx(
        () => ListView.builder(
            itemCount: HomeScreenController().topPodcasts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(
                    NamedRoute.singlePodcast,
                    arguments: homeScreenController.topPodcasts[index].poster,
                  );
                },
                child: Padding(
                  padding: EdgeInsets.only(right: index == 0 ? bodyMargin : 15),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: size.height / 5.3,
                          width: size.width / 2.4,
                          child: CachedNetworkImage(
                            imageUrl:
                                homeScreenController.topPodcasts[index].poster!,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(16)),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.cover),
                              ),
                            ),
                            placeholder: (context, url) => const loading(),
                            errorWidget: (context, url, error) => const Icon(
                              Icons.image_not_supported_outlined,
                              size: 50,
                              color: Colors.amber,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width / 2.4,
                        child: Text(
                          homeScreenController.topPodcasts[index].title!,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget poster() {
    return Stack(
      children: [
        Container(
          width: size.width / 1.12,
          height: size.height / 4.5,
          // ignore: sort_child_properties_last
          child: CachedNetworkImage(
            imageUrl: homeScreenController.poster.value.image!,
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            placeholder: (context, url) => const loading(),
            errorWidget: (context, url, error) => const Icon(
              Icons.image_not_supported_outlined,
              size: 50,
              color: Colors.red,
            ),
          ),
          //foregroundDecoration bejay tekrar container estefade mikonim
          foregroundDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              colors: GradientColors.homePosterColorGradient,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    homeScreenController.poster.value.title!,
                    style: texttheme.bodyLarge,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Icon(
                    Icons.remove_red_eye_sharp,
                    color: Colors.white,
                    size: 14,
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget tags() {
    return Padding(
      padding: EdgeInsets.only(left: bodyMargin, right: bodyMargin),
      child: SizedBox(
        height: 60,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tagList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    EdgeInsets.fromLTRB(5, 5, index == 0 ? bodyMargin : 15, 0),
                child: MainTags(textTheme: texttheme, index: index),
              );
            }),
      ),
    );
  }
}
