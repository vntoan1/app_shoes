import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/loader/loaders.dart';
import 'package:sport_shoes_store/data/repositories/product_repository.dart';
import 'package:sport_shoes_store/utils/constants/enums.dart';

import '../../models/product_model.dart';

class ProductController extends GetxController{
  static ProductController get instance => Get.find();

  final isLoading = false.obs;
  final productRepository = Get.put(ProductRepository());
  RxList<ProductModel> featuredProducts = <ProductModel>[].obs;

  @override
  void onInit() {
    fetchFeaturedProducts();
    super.onInit();
  }

  void fetchFeaturedProducts() async {
    try{
      isLoading.value = true;

      final products = await productRepository.getFeaturedProducts();

      featuredProducts.assignAll(products);
    }catch(e){
      Loaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try{
      final products = await productRepository.getFeaturedProducts();
      return products;
    }catch(e){
      Loaders.errorSnackBar(title: 'Oh snap', message: e.toString());
      return [];
    }
  }

  String getProductPrice (ProductModel productModel){
    double smallestPrice = double.infinity;
    double largestPrice = 0.0;
    if(productModel.productType == ProductType.single.toString()){
      return (productModel.salePrice > 0 ? productModel.salePrice : productModel.price).toString();
    }else{
      // calculate the smallest and largest prices among variations
      for(var variation in productModel.productVariations!){
        // determine the price to consider (sale price if available, otherwise regular price)
        double priceToConsider = variation.salePrice > 0.0 ? variation.salePrice : variation.price;

        // update smallest and largest prices
        if(priceToConsider < smallestPrice){
          smallestPrice = priceToConsider;
        }

        if(priceToConsider > largestPrice){
          largestPrice = priceToConsider;
        }
      }
      // if smallest and largest prices  are the same, return a single price
      if(smallestPrice.isEqual(largestPrice)){
        return largestPrice.toString();
      }else{
        // otherwise, return a price range
        return "$smallestPrice - \$$largestPrice";
      }
    }
  }

  // calculate discount percentage
  String? calculateSalePercentage(double originalPrice, double? salePrice){
    if(salePrice == null || salePrice <= 0.0) return null;
    if(originalPrice <= 0) return null;

    double percentage = ((originalPrice - salePrice) / originalPrice) * 100;
    return percentage.toStringAsFixed(0);
  }

  // check product stock status
  String getProductStockStatus(int stock){
    return stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}