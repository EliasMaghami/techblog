import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:techblog/component/mycomponent.dart';
import 'package:techblog/controller/list_article__controller.dart';
import 'package:techblog/controller/single_article__controller.dart';
import 'package:techblog/view/single.dart';

// ignore: must_be_immutable
class ArticleListScreen extends StatelessWidget {
  ArticleListScreen({super.key});

  ListArticleController listArticleController =
      Get.put(ListArticleController());

  SingleArticleController singleArticleController =
      Get.put(SingleArticleController());

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
        child: Scaffold(
      appBar: appBar("maghalat jadid"),
      body: SizedBox(
        child: Obx(
          () => ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: listArticleController.articleList.length,
            itemBuilder: ((context, index) {
              return GestureDetector(
                onTap: (() {
                  singleArticleController.id.value =
                      int.parse(listArticleController.articleList[index].id!);
                }),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width / 3,
                        height: Get.height / 6,
                        child: CachedNetworkImage(
                          imageUrl:
                              listArticleController.articleList[index].image!,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(16)),
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                            );
                          },
                          placeholder: (context, url) {
                            return const loading();
                          },
                          errorWidget: (context, url, error) {
                            return const Icon(
                              Icons.image_not_supported_outlined,
                              size: 55,
                              color: Colors.greenAccent,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: Get.width / 2,
                            child: Text(
                              listArticleController.articleList[index].title!,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                listArticleController
                                    .articleList[index].author!,
                                style: textTheme.bodyMedium,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Text(
                                '${listArticleController.articleList[index].view!}view',
                                style: textTheme.bodyMedium,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    ));
  }
}