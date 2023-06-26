// ignore_for_file: unnecessary_import, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/my_colors.dart';
import 'package:techblog/component/my_string.dart';

import '../mycomponent.dart';

class profileScreen extends StatelessWidget {
  const profileScreen({
    super.key,
    required this.size,
    required this.texttheme,
    required this.bodyMargin,
  });

  final Size size;
  final TextTheme texttheme;
  final double bodyMargin;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.only(top: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              size: 120,
              color: Color.fromARGB(255, 144, 143, 141),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageIcon(
                  Assets.icons.pen.image().image,
                  color: SolidColors.colorTitel,
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "Image porofile edit",
                  style: texttheme.titleSmall,
                ),
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Text(
              "FatmaAmiri",
              style: texttheme.titleMedium,
            ),
            Text(
              "email : fatma.amiri@gmail.com",
              style: texttheme.titleMedium,
            ),
            const SizedBox(
              height: 40,
            ),
            teckDivider(size: size),
            InkWell(
              onTap: (() {}),
              splashColor: SolidColors.primeryColor,
              child: SizedBox(
                height: 45,
                child: Text(
                  myString.myFaveritText,
                  style: texttheme.titleSmall,
                ),
              ),
            ),
            teckDivider(size: size),
            InkWell(
              onTap: (() {}),
              splashColor: SolidColors.primeryColor,
              child: SizedBox(
                height: 45,
                child: Text(
                  myString.myFaveritPodcast,
                  style: texttheme.titleSmall,
                ),
              ),
            ),
            teckDivider(size: size),
            InkWell(
              onTap: (() {}),
              splashColor: SolidColors.primeryColor,
              child: SizedBox(
                height: 45,
                child: Text(
                  myString.logOut,
                  style: texttheme.titleSmall,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
          ],
        ),
      ),
    );
  }
}
