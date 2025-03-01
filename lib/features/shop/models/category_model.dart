
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryModel {
  String id;
  String name;
  String image;
  String parentId;
  bool isFeatured;

  CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.isFeatured,
    this.parentId = '',
  });

  // Empty Helper function 
  static CategoryModel empty() => CategoryModel(id: '', image: '', name: '',  isFeatured: false);

  // convert model to json 
  Map<String, dynamic> toJson() {
    return {
      'Name' : name,
      'Image' : image,
      'ParentId' : parentId,
      'IsFeatured': isFeatured,
    };
  }

  // Map JSon ORIENTED DOCUMENT 
  factory CategoryModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    if(document.data() != null){
      final data = document.data()!;

      // Map json record to model
      return CategoryModel(
        id: document.id, 
        name: data['Name'] ?? '', 
        image: data['Image'] ?? '', 
        parentId: data['ParentId'] ?? '', 
        isFeatured: data['IsFeatured'] ?? false,
      );
    } else{
      return CategoryModel.empty();
    }
  }
}