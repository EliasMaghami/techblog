import 'package:techblog/component/api_constant.dart';

class ArticleModel {
  String? id;
  String? title;
  String? image;
  String? catId;
  String? catName;
  String? author;
  String? view;
  String? status;
  // String? isFavorite;
  String? creatAt;

  ArticleModel({
    required this.id,
    required this.title,
    required this.image,
    required this.catId,
    required this.catName,
    required this.author,
    required this.view,
    required this.status,
    required this.creatAt,
    // this.isFavorite,
  });

  ArticleModel.fromJson(Map<String, dynamic> element) {
    id = element["id"];
    title = element["title"];
    image = ApiConstant.hastDlUrl + element["image"];
    catId = element["cat_id"];
    catName = element["cat_name"];
    author = element["author"];
    view = element["view"];
    status = element["status"];
    // isFavorite = element["isFavorite"];
    creatAt = element["creat_at"];
  }
}
