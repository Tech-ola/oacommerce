

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/features/shop/models/product_attribute_model.dart';
import 'package:ecommerce/features/shop/models/product_variation_model.dart';
import 'package:ecommerce/features/shop/models/uploadproduct_variation_model.dart';

class UploadProductModel {
  int stock;
  String? sku;
  int price;
  String title;
  DateTime? date;
  int salePrice;
  String thumbnail;
  bool? isFeatured;
  BrandModel? brand;
  String? description;
  String? categoryId;
  List<String>? images;
  String productType;
  List<ProductAttributeModel>? productAttributes;
  List<UploadProductVariationModel>? productVariations;


UploadProductModel ({
  required this.title,
  required this.stock,
  required this.price,
  required this.thumbnail,
  required this.productType,
  this.sku,
  this.brand,
  this.date,
  this.images,
  this.salePrice = 0,
  this.isFeatured,
  this.categoryId,
  this.description,
  this.productAttributes,
  this.productVariations,
});

// JSON format 
 Map<String, dynamic> toJson() {
  return {
    'SKU': sku,
    'Title': title,
    'Stock': stock,
    'Price': price,
    'Images': images ?? [],
    'Thumbnail': thumbnail,
    'SalePrice': salePrice,
    'IsFeatured': isFeatured,
    'CategoryId': categoryId,
    'Brand': brand!.toJson(),
    'Description': description,
    'ProductType': productType,
    'ProductAttributes': productAttributes != null ? productAttributes!.map((e) => e.toJson()).toList() : [],
    'ProductVariations': productVariations != null ? productVariations!.map((e) => e.toJson()).toList() : [],
  };
}

}