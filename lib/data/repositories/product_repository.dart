import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/features/shop/firebase/firebase_storage_sevice.dart';

import '../../features/shop/models/product_model.dart';
import '../../utils/constants/enums.dart';
import '../../utils/exceptions/firebase_exceptions.dart';
import '../../utils/exceptions/format_exceptions.dart';
import '../../utils/exceptions/platform_exceptions.dart';

class ProductRepository extends GetxController{
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;


  Future<List<ProductModel>> getFeaturedProducts() async {
    try{
      final snapshot= await _db.collection('Products').where('IsFeatured', isEqualTo: true).limit(10).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
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

  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try{
      final snapshot= await _db.collection('Products').where('IsFeatured', isEqualTo: true).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
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

  Future<List<ProductModel>> getFavoriteProducts(List<String> productId) async {
    try{
      final snapshot= await _db.collection('Products').where(FieldPath.documentId, whereIn: productId).get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } on FirebaseException catch(e){
      throw KFirebaseException(e.code).message;
    } on FormatException catch(_){
      throw const KFormatException();
    }catch(e){
      throw 'Something went wrong. Please try again';
    }
  }

  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try{
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs.map((doc) => ProductModel.fromQuerySnapshot(doc)).toList();
      return productList;
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


  Future<List<ProductModel>> getProductsForBrand({required String brandId, int limit = -1}) async {
    try{
     final querySnapshot = limit == -1
         ? await _db.collection('Products').where('Brand.Id', isEqualTo:  brandId).get()
         : await _db.collection('Products').where('Brand.Id', isEqualTo:  brandId).limit(limit).get();
     final products = querySnapshot.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
     return products;
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


  Future<List<ProductModel>> getProductsForCategory({required String categoryId, int limit = 4}) async {
    try{
      final productCategoryQuery = limit == -1
          ? await _db.collection('ProductCategory').where('categoryId', isEqualTo: categoryId).get()
          : await _db.collection('ProductCategory').where('categoryId', isEqualTo:  categoryId).limit(limit).get();
      // extract brandIds from the documents
      List<String> productIds = productCategoryQuery.docs.map((doc) => doc['productId'] as String).toList();

      // query to get all documents where the brandId is in the list of brandIds, fieldPath.documentId to query document in collection
      final productsQuery = await _db.collection('Products').where(FieldPath.documentId, whereIn: productIds).get();

      // extract brands name or other relevant data from the documents
      List<ProductModel> products = productsQuery.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();
      return products;
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


  Future<void> uploadDummyData(List<ProductModel> products) async{
    try{
      // upload all the products along with their images
      final storage = Get.put(KFirebaseStorageService());
      
      // loop through each product
      for(var product in products){
        //get image data link from local assets
        final thumbnail = await storage.getImageDataFromAssets(product.thumbnail);
        
        //upload image and get its url
        final url = await storage.uploadImageData('Products/Images', thumbnail, product.thumbnail.toString());

        // assign url to product.thumbnail attribute
        product.thumbnail = url;

        //product list of image
        if(product.images != null && product.images!.isNotEmpty){
          List<String> imagesUrl = [];
          for(var image in product.images!){
            //get image and get its url
            final assetImage = await storage.getImageDataFromAssets(image);

            final url = await storage.uploadImageData('Products/Images', assetImage, image);
            // assign url to product.thumbnail attribute
            imagesUrl.add(url);
          }
          product.images!.clear();
          product.images!.addAll(imagesUrl);
        }

        //upload variation image
        if(product.productType == ProductType.variable.toString()){
          for (var variation in product.productVariations!){
            // get image data link from local assets
            final assetImage = await storage.getImageDataFromAssets(variation.image);
            
            //upload image and get its url
            final url = await storage.uploadImageData('Products/Images', assetImage, variation.image);

            // assign url to product.thumbnail attribute
            variation.image = url;
          }
        }
        await _db.collection('Products').doc(product.id).set(product.toJson());
      }
    }on FirebaseException catch(e){
      throw e.message!;
    }on SocketException catch(e){
      throw e.message;
    }on PlatformException catch(e){
      throw e.message!;
    }catch(e){
      throw e.toString();
    }
  }
}