// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:techblog/component/my_colors.dart';
import 'package:techblog/view/main_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (BuildContext context) => MainScreen()),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.image.splash.image(height: 75),
              const SizedBox(
                height: 45,
              ),
              const SpinKitRing(
                color: SolidColors.primeryColor,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
