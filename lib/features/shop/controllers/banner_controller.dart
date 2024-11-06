import 'package:get/get.dart';
import 'package:sport_shoes_store/data/repositories/banner_repository.dart';
import 'package:sport_shoes_store/features/shop/models/banner_model.dart';

import '../../../common/widgets/loader/loaders.dart';

class BannerController extends GetxController{
  final carousalCurrentIndex = 0.obs;
  final isLoading = false.obs;
  final RxList<BannerModel> banners = <BannerModel>[].obs;

  @override
  void onInit() {
    fetchBanners();
    super.onInit();
  }

  void updatePageIndicator(index){
    carousalCurrentIndex.value = index;
  }

  Future<void> fetchBanners() async{
    try{
      // show loader while loading categories
      isLoading.value = true;

      final bannerRepo = Get.put(BannerRepository());
      final banners = await bannerRepo.fetchBanners();

      this.banners.assignAll(banners);
    }catch(e){
      Loaders.errorSnackBar(title: 'oh snap!', message: e.toString());
    }finally{
      isLoading.value = false;
    }
  }
}