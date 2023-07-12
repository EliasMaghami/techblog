// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:techblog/constant/api_constant.dart';
import 'package:techblog/constant/storage_const.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/main.dart';
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

    var response =
        await DioService().postMethod(map, ApiUrlConstant.postRsgtister);
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
    var response =
        await DioService().postMethod(map, ApiUrlConstant.postRsgtister);
    debugPrint(response.data);
    var status = response.data['responsse'];

    switch (status) {
      case 'varifide':
        var box = GetStorage();
        box.write(StorageKey.token, response.data['token']);
        box.write(StorageKey.userID, response.data['userID']);
        debugPrint("read:::" + box.read(StorageKey.token));
        debugPrint("read:::" + box.read(StorageKey.userID));

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
    if (GetStorage().read(StorageKey.token) == null) {
      Get.to(RegisterIntro());
    } else {
      debugPrint('post screen');
    }
  }

  routToWriteBottomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height / 3,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  Assets.image.fox.path,
                  height: 40,
                ),
                const SizedBox(
                  width: 8,
                ),
                const Text("write your any things you know")
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const Text("""you can do it . just stay 
            on way . dont give back"""),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () {
                    debugPrint("write article");
                    Get.toNamed(NamedRoute.manageArticle);
                  },
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          Assets.image.fox.path,
                          height: 20,
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        const Text("NotesManager"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    debugPrint("get podcast");
                  },
                  child: Container(
                    color: Colors.white,
                    child: Row(
                      children: [
                        Image.asset(
                          Assets.icons.micIcon.path,
                          height: 20,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text("PadcastManager"),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
