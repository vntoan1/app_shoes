import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class KCloudHelperFunctions{
  static Widget? checkSingRecordState<T>(AsyncSnapshot<T> snapshot){
    if(snapshot.connectionState == ConnectionState.waiting){
      return const Center(child: CircularProgressIndicator());
    }

    if(!snapshot.hasData || snapshot.data == null){
      return const Center(child: Text('No data'));
    }

    if(snapshot.hasError){
      return const Center(child: Text('Something went wrong'),);
    }

    return null;
  }


  static Widget? checkMultiRecordState<T>({required AsyncSnapshot<T> snapshot, Widget? loader, Widget? error, Widget? nothingFound}){
    if(snapshot.connectionState == ConnectionState.waiting){
      if(loader != null) return loader;
      return const Center(child: CircularProgressIndicator());
    }

    if(!snapshot.hasData || snapshot.data == null){
      if(nothingFound != null) return nothingFound;
      return const Center(child: Text('No data'));
    }

    if(snapshot.hasError){
      if(error != null) return error;
      return const Center(child: Text('Something went wrong'),);
    }

    return null;
  }

  static Future<String> getURLFromFilePathAndName(String path) async{
    try{
      if(path.isEmpty) return '';
      final ref = FirebaseStorage.instance.ref().child(path);
      final url = await ref.getDownloadURL();
      return url;
    }on FirebaseException catch(e){
      throw e.message!;
    }on PlatformException catch(e){
      throw e.message!;
    }catch(e){
      throw 'Something ...';
    }
  }
}