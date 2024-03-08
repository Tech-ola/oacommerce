import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/repositories/categories/firebase_storage_service.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();

  // Variables 
  final _db = FirebaseFirestore.instance;

  // Get all categories 
  Future<List<CategoryModel>> getAllCategories() async {
     try{
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;

    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format Error Exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }
  }


  // Get sub categories 
    Future<List<CategoryModel>> getSubCategories(String categoryId) async {
     try{
      final snapshot = await _db.collection('Categories').where('ParentId', isEqualTo: categoryId).get();
      
      final result = snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();

      return result;
      
    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format Error Exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }


  // Upload categories to cloud firebase 
    Future<void> uploadDummyData(List<CategoryModel> categories) async {
     try{
      // Upload all the categories 
      final storage = Get.put(TFirebaseStorageService());

      // Loop through 
      for(var category in categories) {
        // Get imagedata 
        final file = await storage.getImageDataFromAssets(category.image);

        // Upload Image and Get url 
        final url = await storage.uploadImageData('Categories', file, category.name);

        // Assign url to category 
        category.image = url;

        // store category in firestore 
        await _db.collection("Categories").doc(category.id).set(category.toJson());
      }

    }  on FirebaseException catch(e) {
      throw e.code;
    } on FormatException catch(_) {
      throw "Format Error Exception";
    }  on PlatformException catch(e) {
      throw e.code;
    } catch(e){
      throw 'Somethng went wrong. Please try again';
    }
  }


}