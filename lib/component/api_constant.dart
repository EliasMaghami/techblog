class ApiConstant {
  static const baseUrl = "// https://api.coindesk.com/v1/bpi/currentprice.json";
  static const hastDlUrl = "// https://api.coindesk.com";
  static const getHomeItem = "${baseUrl}home/?command=index";
  static const getArticleList =
      "${baseUrl}article/get.php?command=new&user_id=1";
  static const getArticleListWithTagsId =
      "${baseUrl}https://techblog.sasansafari.com/Techblog/api/article/get.php?command=get_articles_with_tag_id&tag_id=1&user_id=1";
}
