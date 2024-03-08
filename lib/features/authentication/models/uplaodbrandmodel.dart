class UploadBrandModel {
  
  final String id;
  final String brandname;
  final int availableproduct;
  final String imageUrl;
  bool isFeatured;

  UploadBrandModel({
    required this.id, 
    required this.brandname, 
    required this.availableproduct, 
    required this.imageUrl,
    required this.isFeatured,

  });

  // Convert model to json 
    Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'Name' : brandname,
      'Image' : imageUrl,
      'isFeatured' : isFeatured,
      'ProductsCount' : availableproduct,
    };
  }



}