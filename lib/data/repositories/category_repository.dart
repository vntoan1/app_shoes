import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/features/shop/firebase/firebase_storage_sevice.dart';
import 'package:sport_shoes_store/features/shop/models/category_model.dart';

import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class CategoryRepository extends GetxController{
  static CategoryRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<CategoryModel>> getAllCategories() async {
    try{
      final snapshot= await _db.collection('Categories').get();
      final list = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return list;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    }on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try{
      final snapshot= await _db.collection('Categories').get();
      final result = snapshot.docs.map((document) => CategoryModel.fromSnapshot(document)).toList();
      return result;
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    }on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  Future<void> uploadDummyData(List<CategoryModel> categories) async {
    try{
      // upload all the categories along with their images
      final storage = Get.put(KFirebaseStorageService());
      // loop through each category
      for(var category in categories){
        // get imagedata link from the local assets
        final file = await storage.getImageDataFromAssets(category.image);
        // upload image and get its url
        final url = await storage.uploadImageData('Categories', file, category.name);
        
        // assign url to category image attribute
        category.image = url;
        // store category in firestore
        await _db.collection("Categories").doc(category.id).set(category.toJson());
      }
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on PlatformException catch(e){
      throw KPlatformException(e.code).message;
    } catch(e){
      throw 'Something went ...Try again';
    }
  }
}