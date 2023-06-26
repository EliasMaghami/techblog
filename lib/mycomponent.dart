// ignore_for_file: unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../gen/assets.gen.dart';
import '../models/fake_data.dart';
import '../my_colors.dart';

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
              tagList[index].title,
              style: textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
