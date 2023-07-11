// ignore_for_file: file_names

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:techblog/component/dimens.dart';
import 'package:techblog/constant/my_colors.dart';
import 'package:techblog/component/mycomponent.dart';
import 'package:techblog/controller/article/article_content_editor.dart';
import 'package:techblog/controller/article/manage_article_controller.dart';
import 'package:techblog/controller/file_controller.dart';
import 'package:techblog/controller/home_screen_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/services.dart/picke_file.dart';

// ignore: must_be_immutable
class SingleManageArticle extends StatelessWidget {
  SingleManageArticle({super.key});
  var manageArticleController = Get.find<ManageArticleController>();
  FilePickerController filePickerController = Get.put(FilePickerController());

  getTitle() {
    Get.defaultDialog(
      title: "Title",
      titleStyle: const TextStyle(color: SolidColors.scaffoldBGcolor),
      content: TextField(
        controller: manageArticleController.titleTextEditingController,
        keyboardType: TextInputType.text,
        style: const TextStyle(color: SolidColors.colorTitel),
        decoration: const InputDecoration(hintText: 'write here'),
      ),
      backgroundColor: SolidColors.primeryColor,
      radius: 8,
      confirm: ElevatedButton(
          onPressed: (() {
            manageArticleController.upDataTitle();
            Get.back();
          }),
          child: const Text('Saved')),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return SafeArea(
      child: Scaffold(
        body: Obx(
          () => Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    child: filePickerController.file.value.name == 'nothing'
                        ? CachedNetworkImage(
                            imageUrl: manageArticleController
                                .articleInfoModle.value.image!,
                            imageBuilder: (context, imageProvider) =>
                                Image(image: imageProvider),
                            placeholder: (context, url) => const loading(),
                            errorWidget: (context, url, error) => Image(
                              image: Assets.image.fullstack.image().image,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.file(
                            File(filePickerController.file.value.path!),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 60,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: GradiantColors.singelAppBar,
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
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: const Icon(
                                Icons.arrow_back,
                                color: Colors.orange,
                                size: 24,
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                          ]),
                    ),
                  ),
                  seeMoreBlog(
                    bodyMargin: Dimens.bodyMargin,
                    texttheme: textTheme,
                    title: 'Show me title',
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () => pickeFile(),
                        child: Container(
                          height: 30,
                          width: Get.width / 3,
                          decoration: const BoxDecoration(
                              color: SolidColors.primeryColor,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(13),
                                  topRight: Radius.circular(13))),
                          child: Row(
                            children: [
                              Text(
                                "put your image",
                                style: textTheme.bodyLarge,
                              ),
                              const Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () => getTitle(),
                child: seeMoreBlog(
                  bodyMargin: Dimens.bodyMargin,
                  texttheme: textTheme,
                  title: 'Edit Note',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Dimens.halfBodyMargin),
                child: Text(
                  manageArticleController.articleInfoModle.value.title!,
                  maxLines: 2,
                  style: textTheme.bodyMedium,
                ),
              ),
              GestureDetector(
                onTap: () => Get.to(() => ArticleContentEditor()),
                child: seeMoreBlog(
                  bodyMargin: Dimens.bodyMargin,
                  texttheme: textTheme,
                  title: 'Edit Original of Article',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: HtmlWidget(
                  manageArticleController.articleInfoModle.value.content!,
                  textStyle: textTheme.bodyMedium,
                  enableCaching: true,
                  onLoadingBuilder: (context, element, loadingProgress) =>
                      const loading(),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              GestureDetector(
                onTap: () {
                  choseCatsBottomSheet(textTheme);
                },
                child: seeMoreBlog(
                  bodyMargin: Dimens.bodyMargin,
                  texttheme: textTheme,
                  title: 'Chose your Type Of Article',
                ),
              ),
              Padding(
                padding: EdgeInsets.all(Dimens.halfBodyMargin),
                child: Text(
                  manageArticleController.articleInfoModle.value.catName == null
                      ? "No things had chose"
                      : manageArticleController.articleInfoModle.value.catName!,
                  maxLines: 2,
                  style: textTheme.bodyMedium,
                ),
              ),
              ElevatedButton(
                onPressed: (() async =>
                    await manageArticleController.storeArticle()),
                child: Text(
                    manageArticleController.loading.value ? "wath" : "upload"),
              ),
              // cats(textTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget cats(textTheme) {
    var homeScreenController = Get.find<HomeScreenController>();
    return SizedBox(
      height: Get.height / 1.7,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: homeScreenController.tagsList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () async {
              manageArticleController.articleInfoModle.update((val) {
                val?.catId = homeScreenController.tagsList[index].id!;
                val?.catName = homeScreenController.tagsList[index].title!;
              });
              Get.back();
            },
            child: Padding(
              padding: EdgeInsets.all(Dimens.halfBodyMargin),
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(24)),
                    color: SolidColors.primeryColor),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 8, 8, 8.0),
                  child: Center(
                    child: Text(
                      homeScreenController.tagsList[index].title!,
                      style: textTheme.bodyMedium,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }

  choseCatsBottomSheet(TextTheme textTheme) {
    Get.bottomSheet(
      Container(
        height: Get.height / 1.5,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            )),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text("chose tayp"),
              const SizedBox(
                height: 8,
              ),
              cats(textTheme),
            ],
          ),
        ),
      ),
      isScrollControlled: true,
      persistent: true,
    );
  }
}
