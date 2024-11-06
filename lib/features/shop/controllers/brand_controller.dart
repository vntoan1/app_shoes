import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/loader/loaders.dart';
import 'package:sport_shoes_store/data/repositories/brand_repo.dart';
import 'package:sport_shoes_store/data/repositories/product_repository.dart';
import 'package:sport_shoes_store/features/shop/models/brand_model.dart';
import 'package:sport_shoes_store/features/shop/models/product_model.dart';

class BrandController extends GetxController{
  static BrandController get instance => Get.find();

   RxBool isLoading = true.obs;
   final RxList<BrandModel> allBrands = <BrandModel>[].obs;
   final RxList<BrandModel> featureBrands = <BrandModel>[].obs;
   final brandRepo = Get.put(BrandRepo());


  @override
  void onInit() {
    getFeaturedBrand();
    super.onInit();
  }

  Future<void> getFeaturedBrand() async{
     try{
       isLoading.value = true;
       final brands = await brandRepo.getAllBrands();
       allBrands.assignAll(brands);
       featureBrands.assignAll(allBrands.where((brand) => brand.isFeatured ?? false).take(4));
     }catch(e){
       Loaders.errorSnackBar(title: 'Oh snappppppppp', message: e.toString());
     }finally{
       isLoading.value = false;
     }
   }


  Future<List<BrandModel>> getBrandsForProducts(String categoryId) async{
    try{
      final brands = await brandRepo.getBrandsForCategory(categoryId);
      return brands;
    }catch(e){
      Loaders.errorSnackBar(title: 'Oh snap', message: e.toString());
      return [];
    }
  }


   Future<List<ProductModel>> getBrandProducts({required String brandId, int limit = -1}) async{
    try{
      final products = await ProductRepository.instance.getProductsForBrand(brandId: brandId, limit: limit);
      return products;
    }catch(e){
      Loaders.errorSnackBar(title: 'Oh snap', message: e.toString());
      return [];
    }
   }

}