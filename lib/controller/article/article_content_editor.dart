import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:techblog/component/mycomponent.dart';
import 'package:techblog/controller/article/manage_article_controller.dart';

// ignore: must_be_immutable
class ArticleContentEditor extends StatelessWidget {
  ArticleContentEditor({super.key});

  final HtmlEditorController controller = HtmlEditorController();
  var manageArticleController = Get.put(ManageArticleController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.clearFocus(),
      child: Scaffold(
        appBar: appBar("Edit/Write Article"),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HtmlEditor(
                controller: controller,
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "you can write your article here ...",
                  shouldEnsureVisible: true,
                  initialText:
                      manageArticleController.articleInfoModle.value.content!,
                ),
                callbacks: Callbacks(
                  onChangeContent: ((p0) {
                    manageArticleController.articleInfoModle.update((val) {
                      val?.content = p0;
                    });
                    log(manageArticleController.articleInfoModle.value.content
                        .toString());
                  }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
