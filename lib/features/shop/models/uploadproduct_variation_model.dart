
class UploadProductVariationModel {
  final String id;
  String sku;
  String image;
  String? description;
  int price;
  int salePrice;
  int stock;
  Map<String, String> attributeValues;

  UploadProductVariationModel({
    required this.id,
    this.sku = '',
    this.image = '',
    this.description = '',
    this.price = 0,
    this.salePrice = 0,
    this.stock = 0,
    required this.attributeValues,
  });

  // JSON Format 
  toJson(){
    return {
      'Id' : id,
      'Image' : image,
      'Description' : description,
      'Price' : price,
      'SalePrice' : salePrice,
      'SKU': sku,
      'Stock' : stock,
      'AttributeValues' : attributeValues,
    };
  }
  
}