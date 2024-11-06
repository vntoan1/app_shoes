import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sport_shoes_store/data/repositories/authentication_repository.dart';
import 'package:sport_shoes_store/features/authentication/models/user_model.dart';
import 'package:sport_shoes_store/utils/exceptions/firebase_exceptions.dart';
import 'package:sport_shoes_store/utils/exceptions/format_exceptions.dart';
import 'package:sport_shoes_store/utils/exceptions/platform_exceptions.dart';

class UserRepository extends GetxController{
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  ///Function to save user data to Firestore
  Future<void> saveUserRecord(UserModel user) async {
    try{
      await _db.collection('Users').doc(user.id).set(user.toJson());
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

  Future<UserModel> fetchUserDetails() async {
    try{
      final documentSnapshot = await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).get();
      if(documentSnapshot.exists){
        return UserModel.fromSnapshot(documentSnapshot);
      }else{
        return UserModel.empty();
      }
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

  Future<void> updateUserDetails(UserModel updateUser) async {
    try{
      await _db.collection('Users').doc(updateUser.id).update(updateUser.toJson());
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

  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try{
      await _db.collection('Users').doc(AuthenticationRepository.instance.authUser?.uid).update(json);
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

  Future<void> removeRecord(String userId) async {
    try{
      await _db.collection('Users').doc().delete();
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

  Future<String> uploadImage(String path, XFile image) async {
    try{
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
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
}