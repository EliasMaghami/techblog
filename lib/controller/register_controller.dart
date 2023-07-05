// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog/component/api_constant.dart';
import 'package:techblog/component/storage_const.dart';
import 'package:techblog/services.dart/dio_service.dart';
import 'package:techblog/view/main_screen.dart';
import 'package:techblog/view/register/register_intro.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activeCodeTextEditingController =
      TextEditingController();

  var email = '';
  var userId = '';
  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register'
    };

    var response = await DioSevice().postMethod(map, ApiConstant.postRsgtister);
    email = emailTextEditingController.text;
    userId = response.data['userId'];
    debugPrint(response);
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': 'sasansafari@gmail.com',
      'userId': 6,
      'code': activeCodeTextEditingController,
      'command': 'verify'
    };
    debugPrint(map.toString());
    var response = await DioSevice().postMethod(map, ApiConstant.postRsgtister);
    debugPrint(response.data);
    var status = response.data['responsse'];

    switch (status) {
      case 'varifide':
        var box = GetStorage();
        box.write(token, response.data['token']);
        box.write(userID, response.data['userID']);
        debugPrint("read:::" + box.read(token));
        debugPrint("read:::" + box.read(userID));

        Get.offAll(MainScreen());
        break;
      case 'incorrect_code':
        Get.snackbar('erroe', 'this code is falt');
        break;
      case 'expired':
        Get.snackbar('erroe', 'this code is expired');
        break;
    }
  }

  toggleLogin() {
    if (GetStorage().read(token) == null) {
      Get.to(RegisterIntro());
    } else {
      debugPrint('post screen');
    }
  }
}
