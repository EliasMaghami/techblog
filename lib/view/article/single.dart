import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:techblog/constant/my_colors.dart';
import 'package:techblog/component/mycomponent.dart';
import 'package:techblog/controller/article/list_article__controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/view/article/articel_list_screen.dart';
import '../../controller/article/single_article__controller.dart';

// ignore: must_be_immutable
class Single extends StatelessWidget {
  Single({super.key});
  var singleArticleController = Get.find<SingleArticleController>();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => singleArticleController.articleInfoModel.value.title == null
              ? SizedBox(height: Get.height, child: const loading())
              : Column(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: singleArticleController
                              .articleInfoModel.value.image!,
                          imageBuilder: (context, imageProvider) =>
                              Image(image: imageProvider),
                          placeholder: (context, url) => const loading(),
                          errorWidget: (context, url, error) => Image(
                              image: Assets.image.fullstack.image().image),
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
                                  const Icon(
                                    Icons.bookmark_border_outlined,
                                    color: Colors.orange,
                                    size: 24,
                                  ),
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
                      child: Text(
                        singleArticleController.articleInfoModel.value.title!,
                        maxLines: 2,
                        style: textTheme.bodyMedium,
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
                            singleArticleController
                                .articleInfoModel.value.author!,
                            style: textTheme.bodyMedium,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Text(
                            singleArticleController
                                .articleInfoModel.value.createdAt!,
                            style: textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: HtmlWidget(
                        singleArticleController.articleInfoModel.value.content!,
                        textStyle: textTheme.bodyMedium,
                        enableCaching: true,
                        onLoadingBuilder: (context, element, loadingProgress) =>
                            const loading(),
                      ),
                    ),
                    tags(textTheme),
                  ],
                ),
        ),
      ),
    );
  }

  Widget tags(textTheme) {
    return SizedBox(
      height: 35,
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: singleArticleController.tagList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                var tagId = singleArticleController.tagList[index].id!;
                await Get.find<ListArticleController>()
                    .getArticleListWithTagsId(tagId);
                Get.to(ArticleListScreen());
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 30,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(24)),
                      color: Colors.grey),
                  child: Text(
                    singleArticleController.tagList[index].title!,
                    style: textTheme.bodyMedium,
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget similar(textThem) {
    return SizedBox(
      height: Get.height / 3.5,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: singleArticleController.relatedList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: (() {
                singleArticleController.getArticleInfo(
                    singleArticleController.relatedList[index].id!);
              }),
              child: Padding(
                padding:
                    EdgeInsets.only(right: index == 0 ? Get.width / 15 : 15),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: SizedBox(
                        height: Get.height / 5.3,
                        width: Get.width / 2.4,
                        child: Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: singleArticleController
                                  .articleInfoModel.value.image!,
                              imageBuilder: ((context, imageProvider) => Image(
                                  image: imageProvider, fit: BoxFit.cover)),
                              placeholder: (context, url) => const loading(),
                              errorWidget: (context, url, error) => const Icon(
                                Icons.image_not_supported_outlined,
                                size: 55,
                                color: Colors.deepOrange,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
