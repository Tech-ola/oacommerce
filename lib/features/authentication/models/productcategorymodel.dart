class UploadProductCategoryModel {

  final String categoryId;
  final String productId;

  UploadProductCategoryModel({
    required this.categoryId,
    required this.productId,
  });

  Map<String,dynamic> toJson(){
    return {
      'categoryId' : categoryId,
      'productId' : productId,
    };
  }
}