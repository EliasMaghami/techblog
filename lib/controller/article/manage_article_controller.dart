import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog/constant/api_constant.dart';
import 'package:techblog/constant/command.dart';
import 'package:techblog/constant/storage_const.dart';
import 'package:techblog/controller/file_controller.dart';
import 'package:techblog/models/artikel_info_model.dart';
import 'package:techblog/models/artikel_model.dart';
import 'package:techblog/models/tags_model.dart';
import 'package:techblog/services.dart/dio_service.dart';

class ManageArticleController extends GetxController {
  RxList<ArticleModel> articleList = RxList.empty();
  RxList<TagsModel> tagList = RxList.empty();
  // ignore: non_constant_identifier_names
  RxBool loading = false.obs;

  TextEditingController titleTextEditingController = TextEditingController();
  Rx<ArtikelInfoModle> articleInfoModle = ArtikelInfoModle(
          "here is your article",
          """
big article you writing here for your fans !!!!""",
          "")
      .obs;
  @override
  onInit() {
    super.onInit();
    getManagedArticle();
  }

  getManagedArticle() async {
    loading.value = true;
    var response = await DioSevice().getMethod(
        ApiUrlConstant.publishByMe + GetStorage().read(StorageKey.userID));

    //TODO:get user from getStorage Api Constant.getArticleList+userid

    if (response.statusCode == 200) {
      response.data.forEach((element) {
        articleList.add(ArticleModel.fromJson(element));
      });
      loading.value = false;
    }
  }

  upDataTitle() {
    articleInfoModle.update((val) {
      val!.title = titleTextEditingController.text;
    });
  }

  storeArticle() async {
    var fileController = Get.find<FilePickerController>();
    loading.value = true;
    Map<String, dynamic> map = {
      ApiArticleKeyConstant.title: articleInfoModle.value.title,
      ApiArticleKeyConstant.content: articleInfoModle.value.content,
      ApiArticleKeyConstant.catId: articleInfoModle.value.catId,
      ApiArticleKeyConstant.userId: GetStorage().read(StorageKey.userID),
      ApiArticleKeyConstant.iamge:
          await dio.MultipartFile.fromFile(fileController.file.value.path!),
      ApiArticleKeyConstant.command: Commands.store,
      ApiArticleKeyConstant.tagList: "[]",
    };
    var response =
        await DioSevice().postMethod(map, ApiUrlConstant.articlePost);
    log(response.data.toString());
    loading.value = false;
  }
}
