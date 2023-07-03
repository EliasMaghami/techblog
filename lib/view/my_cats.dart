import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:techblog/gen/assets.gen.dart';
import 'package:techblog/models/data_models.dart';
import 'package:techblog/models/fake_data.dart';
import 'package:techblog/component/my_string.dart';
import 'package:techblog/component/mycomponent.dart';
import '../component/my_colors.dart';

class MyCats extends StatefulWidget {
  const MyCats({super.key});

  @override
  State<MyCats> createState() => _MyCatsState();

  static void add(HashTagModel hashTagModel) {}
}

class _MyCatsState extends State<MyCats> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var size = MediaQuery.of(context).size;
    double bodyMargin = size.width / 10;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(left: bodyMargin, right: bodyMargin),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 32,
                  ),
                  Assets.image.fullstack.image(),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    myString.successFullRegistrion,
                    style: textTheme.titleSmall,
                  ),
                  TextField(
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      hintText: "Name",
                      hintStyle: textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    myString.chooseCats,
                    style: textTheme.bodyMedium,
                  ),
                  SizedBox(
                    // categoryies********
                    height: 100,
                    width: double.infinity,
                    child: GridView.builder(
                      physics: const ClampingScrollPhysics(),
                      itemCount: tagList.length,
                      shrinkWrap: true,
                      // scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisSpacing: 6,
                        crossAxisCount: 2,
                        mainAxisSpacing: 6,
                        childAspectRatio: 0.4,
                      ),
                      itemBuilder: ((context, index) {
                        return Container(
                          // height: 100,
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                              color: SolidColors.primeryColor),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                //ImageIcon ba fluutergen be sorat zir neveshte mishe

                                Text(
                                  tagList[index].title,
                                  style: textTheme.bodyLarge,
                                ),

                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectedTags.removeAt(index);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
//////////////////
                  ///
                  Padding(
                    padding:
                        EdgeInsets.only(left: bodyMargin, right: bodyMargin),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                            width: double.infinity,
                            child: GridView.builder(
                              physics: const ClampingScrollPhysics(),
                              itemCount: tagList.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 5,
                                crossAxisCount: 1,
                                mainAxisSpacing: 5,
                                childAspectRatio: 0.1,
                              ),
                              itemBuilder: ((context, index) {
                                return InkWell(
                                  onTap: (() {
                                    setState(() {
                                      if (!selectedTags
                                          .contains(tagList[index])) {
                                        selectedTags.add(tagList[index]);
                                      } else {
                                        ("${tagList[index].title}exist");
                                      }
                                    });
                                  }),
                                  child: MainTags(
                                    textTheme: textTheme,
                                    index: index,
                                  ),
                                );
                              }),
                            ),
                          ),
                          const Icon(
                            CupertinoIcons.delete,
                            color: Colors.green,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 35,
                  ),
                  Assets.icons.paar.image(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
