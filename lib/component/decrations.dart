import 'package:flutter/widgets.dart';
import 'package:techblog/constant/my_colors.dart';

class MyDecorations {
  MyDecorations._();

  static BoxDecoration mainGradient = const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    gradient: LinearGradient(
      colors: GradientColors.battenNavigation,
      begin: Alignment.bottomLeft,
      end: Alignment.bottomRight,
    ),
  );
}
