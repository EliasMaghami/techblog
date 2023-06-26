// ignore_for_file: unnecessary_import, sort_child_properties_last

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/component/my_string.dart';
import 'package:techblog/view/my_cats.dart';
import 'package:validators/validators.dart';

class RegisterIntro extends StatelessWidget {
  const RegisterIntro({super.key});
  @override
  Widget build(BuildContext context) {
    var texttheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Assets.image.splash.image(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: myString.welcomeNotePodcast,
                        style: texttheme.titleMedium)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: ElevatedButton(
                  onPressed: () {
                    _showEmailBottomSheet(context, size, texttheme);
                  },
                  child: const Text("Lets Go"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> _showEmailBottomSheet(
      BuildContext context, Size size, TextTheme texttheme) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: ((context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: size.height / 2,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    myString.insertYourEmail,
                    style: texttheme.bodyMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    child: TextField(
                      onChanged: (value) {
                        // ignore: avoid_print
                        print("${value}is email :${isEmail(value)}");
                      },
                      style: texttheme.bodyMedium,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "tech@yahoo.com",
                          hintStyle: texttheme.bodyMedium),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);

                      _activatCodeBottemSheet(context, size, texttheme);
                    },
                    child: const Text("go"),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  Future<dynamic> _activatCodeBottemSheet(
      BuildContext context, Size size, TextTheme texttheme) {
    return showModalBottomSheet(
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      context: context,
      builder: ((context) {
        return Padding(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: size.height / 2,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    myString.insertYourPasword,
                    style: texttheme.bodyMedium,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                    child: TextField(
                      onChanged: (value) {
                        // ignore: avoid_print
                        print(
                          isEmail("${value}is Email :${isEmail(value)}"),
                        );
                      },
                      style: texttheme.bodyMedium,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                          hintText: "******", hintStyle: texttheme.bodyMedium),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const MyCats()));
                    },
                    child: const Text("go"),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
