// ignore_for_file: unnecessary_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/instance_manager.dart';
import 'package:techblog/component/my_colors.dart';
import 'package:techblog/component/text_style.dart';
import 'package:techblog/controller/home_screen_controller.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class teckDivider extends StatelessWidget {
  const teckDivider({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: SolidColors.dividorcolor,
      thickness: 1.5,
      indent: size.width / 6,
      endIndent: size.width / 6,
    );
  }
}

// ignore: must_be_immutable
class MainTags extends StatelessWidget {
  MainTags({
    super.key,
    required this.textTheme,
    required this.index,
  });

  final TextTheme textTheme;
  // ignore: prefer_typing_uninitialized_variables
  var index;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        gradient: LinearGradient(
            colors: GradiantColors.tags,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        child: Row(
          children: [
            //ImageIcon ba fluutergen be sorat zir neveshte mishe
            ImageIcon(
              Assets.icons.hashtagIcon.image().image,
              color: Colors.white,
              size: 16,
            ),

            Text(
              Get.find<HomeScreenController>().tagsList[index].title!,
              style: textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

myLunchUrl(String url) async {
  var uri = Uri.parse(url);
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(uri);
  } else {
    log("could not launch${uri.toString()}");
  }
}

// ignore: camel_case_types
class loading extends StatelessWidget {
  const loading({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SpinKitFadingCube(
      color: SolidColors.primeryColor,
      size: 32,
    );
  }
}

PreferredSize appBar(String title) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: Padding(
      padding: const EdgeInsets.all(12),
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Center(child: Text(title, style: appBarTextStyle)),
          ),
        ],
        leading: Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.orangeAccent.withBlue(100),
                shape: BoxShape.circle),
            child: const Icon(Icons.keyboard_arrow_left_rounded),
          ),
        ),
      ),
    ),
  );
}
