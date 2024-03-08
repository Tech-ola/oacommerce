
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  // Variables 
  final _db = FirebaseFirestore.instance;

  // Get all categories 
  Future<List<BrandModel>> getAllBrands() async{
    try {
      final snapshot = await _db.collection('Brands').get();
      final result = snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();

      return result;
  
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

  // Get Brands for Category 
    Future<List<BrandModel>> getBrandsForCategory(String categoryId) async{
    try {
      // query to get all document 
      QuerySnapshot brandCategoryQuery = await _db.collection('BrandCategory').where('categoryId', isEqualTo: categoryId).get();

      // extratc brands 
      List<String> brandIds = brandCategoryQuery.docs.map((doc) => doc['brandId'] as String).toList();

      final brandsQuery = await _db.collection('Brands').where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

      // extract brand names 
      List<BrandModel> brands = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

      return brands;
  
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