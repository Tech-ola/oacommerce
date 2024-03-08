
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/repositories/authentication/authentication_repository.dart';
import 'package:ecommerce/features/authentication/models/brandcategorymodel.dart';
import 'package:ecommerce/features/authentication/models/categoryuploadmodel.dart';
import 'package:ecommerce/features/authentication/models/productcategorymodel.dart';
import 'package:ecommerce/features/authentication/models/uplaodbrandmodel.dart';
import 'package:ecommerce/features/authentication/models/uploadebannermodel.dart';
import 'package:ecommerce/features/authentication/models/uploadsubcategorymodel.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  // Functon to save use data 
  Future<void> saveUserRecord(UserModel user) async{
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
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


  // Function to fetch user details base on use ID  

    Future<UserModel> fetchUserDetails() async{
    try {
     final documentSnapshot = await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).get();

     if(documentSnapshot.exists){
      return UserModel.fromSnapshot(documentSnapshot);
     }else{
      return UserModel.empty();
     }

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

  // Function to update user data 

    Future<void> updateUserDetails(UserModel updatedUser) async{
    try {
      await _db.collection("Users").doc(updatedUser.id).update(updatedUser.toJson());
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

  // Update any field in specific user collection  

    Future<void> updateSingleField(Map<String, dynamic> json) async{
    try {
      await _db.collection("Users").doc(AuthenticationRepository.instance.authUser?.uid).update(json);
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

  // Function to rmove user data from firestore 
      Future<void> removeUserRecord(String userId) async{
    try {
      await _db.collection("Users").doc(userId).delete();
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

  // Upload any Image 
  Future<String> uploadImage(String path, XFile image) async{
       try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;

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




  // ----------------  UPLOADS  -------------

      // Banner
  Future<void> bannerrecord(UploadbannerModel user) async{
    try {
      await _db.collection("Banners").doc().set(user.toJson());
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

  // Brands 
        // Banner
  Future<void> brandrecord(UploadBrandModel user) async{
    try {
      await _db.collection("Brands").doc().set(user.toJson());
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


        // Category
 Future<void> categoryrecord(String docId, UploadCategoryModel category) async {
  try {
    await _db.collection("Categories").doc(docId).set(category.toJson());
  } on FirebaseException catch (e) {
    throw e.code;
  } on FormatException catch (_) {
    throw "Format error exception";
  } on PlatformException catch (e) {
    throw e.code;
  } catch (e) {
    throw 'Something went wrong. Please try again';
  }
}


// Get category records
Future<List<Map<String, dynamic>>> getsubCategories() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Categories')
      .where('ParentId', isEqualTo: "")
      .get();

  return querySnapshot.docs.map((doc) {
    return {
      'id': doc.id,
      'name': doc['Name'],
    };
  }).toList();
}

// Get brand records
Future<List<Map<String, dynamic>>> getBrands() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Brands')
      .get();

  return querySnapshot.docs.map((doc) {
    return {
      'id': doc.id,
      'name': doc['Name'],
    };
  }).toList();
}

// Get product records
Future<List<Map<String, dynamic>>> getProducts() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Products')
      .get();

  return querySnapshot.docs.map((doc) {
    return {
      'id': doc.id,
      'name': doc['Title'],
    };
  }).toList();
}


// Get category records
Future<List<Map<String, dynamic>>> getuploadCategory() async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Categories')
      .get();

  return querySnapshot.docs.map((doc) {
    return {
      'id': doc.id,
      'name': doc['Name'],
    };
  }).toList();
}


  // Save sub category 
  Future<void> subcategoryrecord(String docId, UploadSubCategoryModel subcategory) async{
    try {
      await _db.collection("Categories").doc(docId).set(subcategory.toJson());
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

    // Save brandcategory category 
  Future<void> savebrandcategory(UploadBrandCategoryModel brandcategory) async{
    try {
      await _db.collection("BrandCategory").doc().set(brandcategory.toJson());
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

      // Save productcategory category 
  Future<void> saveproductcategory(UploadProductCategoryModel productcategory) async{
    try {
      await _db.collection("ProductCategory").doc().set(productcategory.toJson());
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