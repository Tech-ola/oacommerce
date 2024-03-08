class UploadSubCategoryModel {
  
  final String image;
  bool isFeatured;
  final String name;
  final String parentId;


  UploadSubCategoryModel({
    required this.image,  
    required this.isFeatured,
    required this.name,
    required this.parentId,
  });

  // Convert model to json 
  Map<String, dynamic> toJson() {
    return {
      'Image' : image,
      'IsFeatured' : isFeatured,
      'Name' : name,
      'ParentId' : parentId,
    };
  }
}