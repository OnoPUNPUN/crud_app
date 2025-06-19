class Urls{
  static String bashUrl = "http://35.73.30.144:2008/api/v1";
  static String createProductUrl = "$bashUrl/CreateProduct";
  static String readProductUrl = "$bashUrl/ReadProduct";
  static String updateProductUrl(String id) => "$bashUrl/UpdateProduct/$id";
  static String deleteProductUrl(String id) => "$bashUrl/DeleteProduct/$id";
}