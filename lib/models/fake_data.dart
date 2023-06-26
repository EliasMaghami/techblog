import 'package:techblog/gen/assets.gen.dart';

import 'data_models.dart';

// ignore: non_constant_identifier_names
Map HomePagePosterMap = {
  "imageAsset": Assets.image.fullstack.path,
  "writer": "Melika Azizi",
  "date": "One day ago",
  "title": "Twelve steps of programming a course",
  "view": "251",
};

//blog fake data
List<HashTagModel> tagList = [
  HashTagModel(title: "Java"),
  HashTagModel(title: "Katlin"),
  HashTagModel(title: "IOT"),
  HashTagModel(title: "AI"),
  HashTagModel(title: "Dart"),
  HashTagModel(title: "go"),
];

List<BlogModel> blogList = [
  BlogModel(
      id: 1,
      imageUr: "",
      title: "title",
      writer: "writer",
      writerImageUrl: "writerImageUrl",
      date: "date",
      content: "content",
      views: "views")
];

class BlogModel {
  int id;
  String imageUr;
  String title;
  String writer;
  String writerImageUrl;
  String date;
  String content;
  String views = "255";

  BlogModel({
    required this.id,
    required this.imageUr,
    required this.title,
    required this.writer,
    required this.writerImageUrl,
    required this.date,
    required this.content,
    required this.views,
  });
}

List<HashTagModel> selectedTags = [];
