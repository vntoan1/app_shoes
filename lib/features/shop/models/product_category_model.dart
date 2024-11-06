import 'package:cloud_firestore/cloud_firestore.dart';

class ProductCategoryModel{
  final String brandId;
  final String categoryId;
  ProductCategoryModel({
    required this.brandId,
    required this.categoryId
  });

  Map<String, dynamic> toJson(){
    return {
      'brandId' : brandId,
      'category' : categoryId,
    };
  }

  factory ProductCategoryModel.fromSnapshot(DocumentSnapshot snapshot){
    final data = snapshot.data() as Map<String, dynamic>;
    return ProductCategoryModel(
      brandId: data['productId'] as String,
      categoryId: data['categoryId'] as String,
    );
  }
}