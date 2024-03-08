
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/models/uploadproduct_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  // Firestore instance 
  final _db = FirebaseFirestore.instance;

  // Get limited products 
  
    Future<List<ProductModel>> getFeaturedProducts() async{
    try {
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).limit(4).get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
     
     
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format error exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }
  }

    // Save sub category 
  Future<void> saveproductrecord(UploadProductModel product) async{
    try {
      await _db.collection("Products").doc().set(product.toJson());
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format error exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }
  }

  // Get all featured products 

     Future<List<ProductModel>> getAllFeaturedProducts() async{
    try {
      final snapshot = await _db.collection('Products').where('IsFeatured', isEqualTo: true).get();

      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
     
     
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format error exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }
  }


  // Get products basesd on brand 
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async{
    try {
     final querySnapshot = await query.get();
     final List<ProductModel> productList = querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
     return productList;
     
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format error exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }
  }


  Future<List<ProductModel>> getFavouriteProducts(List<String> productIds) async{
    
    try {
      final snapshot = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();

      return snapshot.docs.map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot)).toList();
      
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format error exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw "Somethng went wrong. Please try again";
    }
  }


    // Get all products basesd on brand 
  Future<List<ProductModel>> getProductsForBrand({required String brandId, int limit = -1}) async{
    try {
      final querySnapshot = limit == -1 ?
      await _db.collection('Products').where('Brand.Id', isEqualTo: brandId).get() : await _db.collection('Products').where('Brand.Id', isEqualTo: brandId).limit(limit).get();

      final products = querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();

      return products;
     
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format error exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }
  }


    Future<List<ProductModel>> getProductsForCategory({required String categoryId, int limit = 4}) async{
    try {
      
      QuerySnapshot productCategoryQuery = limit == -1 ?
      await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).get() : await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).limit(limit).get();

      // Extracts products IDs 
      List<String> productIds = productCategoryQuery.docs.map((doc) => doc['productId'] as String).toList();

      // Query to get all documents 
      final productsQuery = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();


      // Extraxt brand names 
      List<ProductModel> products = productsQuery.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

      return products;
     
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format error exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }
  }

  
}