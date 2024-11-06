import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/loader/loaders.dart';
import 'package:sport_shoes_store/data/repositories/category_repository.dart';
import 'package:sport_shoes_store/data/repositories/product_repository.dart';
import 'package:sport_shoes_store/features/shop/models/category_model.dart';

import '../models/product_model.dart';

class CategoryController extends GetxController{
  static CategoryController get instance => Get.find();

  final isLoading = false.obs;
  final _categoryRepository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }
  Future<void> fetchCategories() async{
    try{
      // show loader while loading categories
      isLoading.value = true;
      // fetch categories from data source (api)
      final categories = await _categoryRepository.getAllCategories();
      // update the categories list
      allCategories.assignAll(categories);
      //filter featured categories
      featuredCategories.assignAll(allCategories.where((category) => category.isFeatured && category.parentId.isEmpty).take(8).toList());
    }catch(e){
      Loaders.errorSnackBar(title: 'oh snap!', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }

  Future<List<CategoryModel>> getSubCategory(String categoryId) async {
    final subCategories = await _categoryRepository.getSubCategories(categoryId);
    return subCategories;
  }

  Future<List<ProductModel>> getCategoryProducts({required String categoryId, int limit = 4}) async {
    final products = await ProductRepository.instance.getProductsForCategory(categoryId: categoryId, limit: limit);
    return products;
  }
}