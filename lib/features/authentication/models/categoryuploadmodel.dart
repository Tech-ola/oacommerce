class UploadCategoryModel{
  
  final String imageUrl;
  final String categoryname;
  bool isfeatured;
  final String parentid;

  UploadCategoryModel({
    required this.categoryname, 
    required this.imageUrl,
    required this.isfeatured,
    required this.parentid,
  });


  Map<String, dynamic> toJson() {
    return {
      'Image' : imageUrl,
      'IsFeatured' : true,
      'Name' : categoryname,
      'ParentId' : parentid,
    };
  }
}
