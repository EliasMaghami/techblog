// ignore_for_file: unnecessary_import, sort_child_properties_last, must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:techblog/component/mycomponent.dart';
import 'package:techblog/controller/article/manage_article_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/constant/my_string.dart';
import 'package:techblog/main.dart';

class ManageArticle extends StatelessWidget {
  ManageArticle({super.key});

  var articleManageController = Get.find<ManageArticleController>();
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    // ignore: unused_local_variable
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: appBar("Articale Manager"),
        body: Obx(
          () => articleManageController.loading.value
              ? const loading()
              : articleManageController.articleList.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: articleManageController.articleList.length,
                      itemBuilder: ((context, index) {
                        return GestureDetector(
                          onTap: (() async {
                            //rout to SingleManage
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
                                    imageUrl: articleManageController
                                        .articleList[index].image!,
                                    imageBuilder: (context, imageProvider) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(16)),
                                            image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.cover)),
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
                                        articleManageController
                                            .articleList[index].title!,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          articleManageController
                                              .articleList[index].author!,
                                          style: textTheme.bodyMedium,
                                        ),
                                        const SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          '${articleManageController.articleList[index].view!}view',
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
                    ) //loading();

                  : articleEmptyState(textTheme),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.only(top: 32),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              style: ButtonStyle(
                  fixedSize:
                      MaterialStateProperty.all(Size(Get.width / 3, 56))),
              onPressed: () {
                Get.toNamed(NamedRoute.singleManageArticle);
              },
              child: const Text("Lets Go Write an Entertaining Article!"),
            ),
          ),
        ),
      ),
    );
  }

  Widget articleEmptyState(TextTheme texttheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            Assets.image.fox.path,
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: myString.ArticleEmpty, style: texttheme.titleMedium)),
          ),
        ],
      ),
    );
  }
}
