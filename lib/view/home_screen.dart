// ignore_for_file: unnecessary_import, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:techblog/component/my_string.dart';
import 'package:techblog/mycomponent.dart';
import '../gen/assets.gen.dart';
import '../models/fake_data.dart';
import 'package:techblog/component/my_colors.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({
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
        padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
        child: Column(
          children: [
            //postr
            homePagePoster(size: size, texttheme: texttheme),
            const SizedBox(
              height: 20,
            ),
            //tagList
            homePageTagList(bodyMargin: bodyMargin, texttheme: texttheme),
            const SizedBox(
              height: 20,
            ),
            //seemore: hamon titre balay posts & podcast
            seeMoreBlog(bodyMargin: bodyMargin, texttheme: texttheme),
            //blog List
            homePageBlogList(
                bodyMargin: bodyMargin, size: size, texttheme: texttheme),

            const SizedBox(
              height: 20,
            ),
            seeMorePodcast(bodyMargin: bodyMargin, texttheme: texttheme),

            //padcastlist
            //niyaz be eslah va icon microphon darad.
            homePagePodcast(
                bodyMargin: bodyMargin, size: size, texttheme: texttheme),

            const SizedBox(
              height: 60,
            )
          ],
        ),
      ),
    );
  }
}

class homePagePodcast extends StatelessWidget {
  const homePagePodcast({
    super.key,
    required this.bodyMargin,
    required this.size,
    required this.texttheme,
  });

  final double bodyMargin;
  final Size size;
  final TextTheme texttheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: bodyMargin, right: bodyMargin),
      child: SizedBox(
        height: size.height / 4.1,
        child: ListView.builder(
            itemCount: tagList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              //lastest post
              //pading wrap ba column ta neveshte zir image gharar begireh.
              return Padding(
                padding: EdgeInsets.only(left: bodyMargin),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 5.3,
                      width: size.width / 2.4,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              //inja image bayad az Url bevasile NetworkImage initializ shavad.
                              // image: DecorationImage(image: NetworkImage(blogList[index].imageUr),
                              // fit: BoxFit.cover,

                              //image besorat dasti vared shode va eshtebah ast.
                              image: DecorationImage(
                                image: Assets.image.fullstack.image().image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            foregroundDecoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                gradient: LinearGradient(
                                  colors: GradiantColors.bottenNavigation,
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topLeft,
                                )),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  //bad az dastresi be Url in code faal shavad
                                  // blogList[index].writer

                                  HomePagePosterMap["writer"] +
                                      " - " +
                                      HomePagePosterMap["view"],
                                  //bad az dastresi be Url in code faal shavad
                                  //blogList[index].views,
                                  style: texttheme.bodyLarge,
                                ),
                                const Icon(
                                  Icons.remove_red_eye_sharp,
                                  color: Colors.white,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Url to do
                    // Text(blogList[index].title),
                    SizedBox(
                      // saizbox bayad bezarim va weidth bedim.
                      width: size.width / 2.4,
                      child: Text(
                        "note",
                        style: texttheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class seeMorePodcast extends StatelessWidget {
  const seeMorePodcast({
    super.key,
    required this.bodyMargin,
    required this.texttheme,
  });

  final double bodyMargin;
  final TextTheme texttheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: bodyMargin, bottom: 15),
      child: Row(
        children: [
          ImageIcon(
            Assets.icons.micIcon.image().image,
            color: SolidColors.colorTitel,
          ),
          Text(
            "Podcast",
            style: texttheme.titleSmall,
          )
        ],
      ),
    );
  }
}

class homePageBlogList extends StatelessWidget {
  const homePageBlogList({
    super.key,
    required this.bodyMargin,
    required this.size,
    required this.texttheme,
  });

  final double bodyMargin;
  final Size size;
  final TextTheme texttheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: bodyMargin, right: bodyMargin),
      child: SizedBox(
        height: size.height / 4.1,
        child: ListView.builder(
            itemCount: tagList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              //lastest post
              //pading wrap ba column ta neveshte zir image gharar begireh.
              return Padding(
                padding: EdgeInsets.only(left: bodyMargin),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height / 5.3,
                      width: size.width / 2.4,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              //inja image bayad az Url bevasile NetworkImage initializ shavad.
                              // image: DecorationImage(image: NetworkImage(blogList[index].imageUr),
                              // fit: BoxFit.cover,

                              //image besorat dasti vared shode va eshtebah ast.
                              image: DecorationImage(
                                image: Assets.image.fullstack.image().image,
                                fit: BoxFit.cover,
                              ),
                            ),
                            foregroundDecoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15)),
                                gradient: LinearGradient(
                                  colors: GradiantColors.bottenNavigation,
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topLeft,
                                )),
                          ),
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  //bad az dastresi be Url in code faal shavad
                                  // blogList[index].writer

                                  HomePagePosterMap["writer"] +
                                      " - " +
                                      HomePagePosterMap["view"],
                                  //bad az dastresi be Url in code faal shavad
                                  //blogList[index].views,
                                  style: texttheme.bodyLarge,
                                ),
                                const Icon(
                                  Icons.remove_red_eye_sharp,
                                  color: Colors.white,
                                  size: 14,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Url to do
                    // Text(blogList[index].title),
                    SizedBox(
                      //saizbox bayad bezarim va weidth bedim.
                      width: size.width / 2.4,
                      child: Text(
                        "title: ba yad url tarif va  to do haye farsi va englisi jaygozin shavand",
                        style: texttheme.bodyMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

class seeMoreBlog extends StatelessWidget {
  const seeMoreBlog({
    super.key,
    required this.bodyMargin,
    required this.texttheme,
  });

  final double bodyMargin;
  final TextTheme texttheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: bodyMargin, bottom: 15),
      child: Row(
        children: [
          ImageIcon(
            Assets.icons.pen.image().image,
            color: SolidColors.colorTitel,
            size: 20,
          ),
          Text(
            myString.viewRecentBlog,
            style: texttheme.titleSmall,
          )
        ],
      ),
    );
  }
}

class homePageTagList extends StatelessWidget {
  const homePageTagList({
    super.key,
    required this.bodyMargin,
    required this.texttheme,
  });

  final double bodyMargin;
  final TextTheme texttheme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: bodyMargin, right: bodyMargin),
      child: SizedBox(
        height: 60,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: tagList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    EdgeInsets.fromLTRB(5, 5, index == 0 ? bodyMargin : 15, 0),
                child: MainTags(textTheme: texttheme, index: index),
              );
            }),
      ),
    );
  }
}

class homePagePoster extends StatelessWidget {
  const homePagePoster({
    super.key,
    required this.size,
    required this.texttheme,
  });

  final Size size;
  final TextTheme texttheme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: size.width / 1.12,
          height: size.height / 4.5,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(15)),
            image: DecorationImage(
              image: AssetImage(HomePagePosterMap["imageAsset"]),
              fit: BoxFit.cover,
            ),
          ),
          //foregroundDecoration bejay tekrar container estefade mikonim
          foregroundDecoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            gradient: LinearGradient(
              colors: GradiantColors.homePosterColorGradiant,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          left: 0,
          right: 0,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    HomePagePosterMap["writer"] +
                        " - " +
                        HomePagePosterMap["date"],
                    style: texttheme.bodyLarge,
                  ),
                  Row(
                    children: [
                      Text(
                        HomePagePosterMap["view"],
                        style: texttheme.bodyLarge,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      const Icon(
                        Icons.remove_red_eye_sharp,
                        color: Colors.white,
                        size: 14,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    HomePagePosterMap["title"],
                    style: texttheme.titleLarge,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
