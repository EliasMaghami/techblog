// ignore_for_file: use_key_in_widget_constructors, unnecessary_import, unused_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:techblog/component/decrations.dart';
import 'package:techblog/component/dimens.dart';
import 'package:techblog/constant/api_constant.dart';
import 'package:techblog/controller/article/register_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/models/fake_data.dart';
import 'package:techblog/constant/my_colors.dart';
import 'package:techblog/constant/my_string.dart';
import 'package:techblog/component/mycomponent.dart';
import 'package:techblog/services.dart/dio_service.dart';
import 'package:techblog/view/home_screen.dart';
import 'package:techblog/view/profile_screen.dart';
import 'package:techblog/view/register/register_intro.dart';

final GlobalKey<ScaffoldState> _key = GlobalKey();

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  RxInt selectedPageIndex = 0.obs;

  @override
  Widget build(BuildContext context) {
    var texttheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        key: _key,
        drawer: Drawer(
          backgroundColor: Colors.pink,
          child: Padding(
            padding: EdgeInsets.only(
                left: Dimens.bodyMargin, right: Dimens.bodyMargin),
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(
                    child: Assets.image.fullstack.image(),
                  ),
                ),
                ListTile(
                  title: Text(
                    "Drawer injast",
                    style: texttheme.bodyMedium,
                  ),
                  onTap: () {},
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "Drawer injast",
                    style: texttheme.bodyMedium,
                  ),
                  onTap: () {},
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "Drawer injast",
                    style: texttheme.bodyMedium,
                  ),
                  onTap: () async {
                    await Share.share(myString.shareText);
                  },
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
                ListTile(
                  title: Text(
                    "Drawer injast",
                    style: texttheme.bodyMedium,
                  ),
                  onTap: () {
                    myLunchUrl(myString.techBlogUrl);
                  },
                ),
                const Divider(
                  color: SolidColors.dividerColor,
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          // automaticallyImplyLeading: false baray pak kardan back felesh.
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: SolidColors.scaffoldBGColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.search,
                color: Colors.black,
              ),
              Image(
                image: Assets.image.splash.image().image,
                height: size.height / 14,
              ),
              InkWell(
                onTap: () {
                  _key.currentState!.openDrawer();
                },
                child: const Icon(
                  Icons.menu,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Positioned.fill(
                child: Obx(() => IndexedStack(
                      index: selectedPageIndex.value,
                      children: [
                        HomeScreen(
                            size: size,
                            texttheme: texttheme,
                            bodyMargin: Dimens.bodyMargin), //0

                        profileScreen(
                            size: size,
                            texttheme: texttheme,
                            bodyMargin: Dimens.bodyMargin), //1
                      ],
                    ))),
            BottonNavigation(
              size: size,
              bodyMargin: Dimens.bodyMargin,
              changeScreen: (int value) {
                selectedPageIndex.value = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class BottonNavigation extends StatelessWidget {
  BottonNavigation({
    super.key,
    required this.size,
    required this.bodyMargin,
    required this.changeScreen,
  });

  final Size size;
  final double bodyMargin;
  final Function(int) changeScreen;

  RegisterController registerController =
      Get.put(RegisterController(), permanent: false);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 8,
      right: 8,
      child: Container(
        //shadow
        height: size.height / 10,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: GradientColors.btnNavigationBG,
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),

        child: Padding(
          padding: EdgeInsets.only(right: bodyMargin, left: bodyMargin),
          child: Container(
            height: size.height / 8,
            decoration: MyDecorations.mainGradient,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: (() => changeScreen(1)),
                  icon: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                    onPressed: (() {
                      Get.find<RegisterController>().toggleLogin();
                    }),
                    icon: ImageIcon(
                      Assets.icons.paar.image().image,
                      color: Colors.white,
                    )),
                IconButton(
                  onPressed: (() => changeScreen(0)),
                  icon: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
