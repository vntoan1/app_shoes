
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/data/repositories/authentication_repository.dart';

import '../../features/shop/models/order_model.dart';

class OrderRepo extends GetxController{
  static OrderRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<List<OrderModel>> fetchUserOrder() async {
    try{
      final userId = AuthenticationRepository.instance.authUser!.uid;
      if(userId.isEmpty) throw 'Unable to find ...';

      final result = await _db.collection('Users').doc(userId).collection('Orders').get();
      return result.docs.map((e) => OrderModel.fromSnapshot(e)).toList();
    }catch(e){
      throw 'Something went ...';
    }
  }

  Future<void> saveOrder(OrderModel order, String userId) async{
    try{
      await _db.collection('Users').doc(userId).collection('Orders').add(order.toJson());
    }catch(e){
      throw 'Something went ...';
    }
  }
}