
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/features/shop/models/banner_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  // Variables 
  final _db = FirebaseFirestore.instance;

  // Get all oreder realted to user 
      Future<List<BannerModel>> fetchBanners() async{
    try {
  
        final result = await _db.collection('Banners').where('active', isEqualTo: true).get();
        return result.docs.map((documentSnapshot) => BannerModel.fromSnapshot(documentSnapshot)).toList();

  
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

  // Upload banners to cloud firebase 
}