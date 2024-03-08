class UploadBrandCategoryModel {
  
  final String brandid;
  final String categoryid;
  
  UploadBrandCategoryModel({
    required this.brandid,  
    required this.categoryid
  });

  // Convert model to json 
  Map<String, dynamic> toJson() {
    return {
      'brandId' : brandid,
      'categoryId' : categoryid,
    };
  }
} 