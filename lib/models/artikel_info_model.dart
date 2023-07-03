import 'package:techblog/component/api_constant.dart';

class ArtikelInfoModle {
  String? id;
  String? title;
  String? content;
  String? image;
  String? catId;
  String? catName;
  String? author;
  String? view;
  String? status;
  String? createdAt;
  bool? isFavorite;

  ArtikelInfoModle();
  ArtikelInfoModle.fromJson(Map<String, dynamic> element) {
    var info = element['info'];
    id = info['id'];
    title = info['title'];
    content = info['content'];
    image = ApiConstant.hastDlUrl + info['image'];
    catId = info['catId'];
    catName = info['catName'];
    author = info['author'];
    view = info['view'];
    status = info['status'];
    createdAt = info['createdAt'];
    isFavorite = element['isFavorite'];
  }
}
