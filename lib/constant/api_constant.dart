class ApiUrlConstant {
  static const baseUrl = "// https://api.coindesk.com/v1/bpi/currentprice.json";
  static const hastDlUrl = "// https://api.coindesk.com";
  static const getHomeItem = "${baseUrl}home/?command=index";
  static const getArticleList =
      "${baseUrl}article/get.php?command=new&user_id=1";
  static const publishByMe =
      "${baseUrl}article/get.php?command=publish_by_me&user_id=";
  static const getArticleListWithTagsId =
      "${baseUrl}https://techblog.sasansafari.com/Techblog/api/article/get.php?command=get_articles_with_tag_id&tag_id=1&user_id=1";

  static const postRsgtister = "${baseUrl}register/action.php";

  static const articlePost = "${baseUrl}article/post.php";
}

class ApiArticleKeyConstant {
  static const title = "title";
  static const content = "content";
  static const catId = "cat_id";
  static const userId = "user_id";
  static const iamge = "iamge";
  static const command = "command";
  static const tagList = "tag_List";
}
