
import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel ({
    required this.id,
    required this.image,
    required this.name,
    this.isFeatured,
    this.productsCount
  });

  // Empty Helper funtion 
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');
  
  // Convert model to json
  toJson() {
    return {
      'Id' : id,
      'Name' : name,
      'Image' : image,
      'ProductsCount' : productsCount,
      'IsFeatured': isFeatured,
    };
  }

  // Map Json oriented document 
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if(data.isEmpty) return BrandModel.empty();
    return BrandModel(id: data['Id'] ?? '', image: data['Image'] ?? '', name: data['Name'] ?? '', 
    isFeatured: data['IsFeatured'] ?? false,
    productsCount: int.parse((data['ProductsCount'] ?? 0).toString()),
    );
  }

  // Map json oriented document snapshot
    factory BrandModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    
      if(document.data() != null){
        final data = document.data()!;

        // Map json Record to model 
        return BrandModel(
          id: document.id, 
          image: data['Image'] ?? '', 
          name: data['Name'] ?? '', 
          isFeatured: data['IsFeatured'] ?? false,
          productsCount: data['ProductsCount'] ?? '',
    );
      }else{
        return BrandModel.empty();
      }
  } 

}