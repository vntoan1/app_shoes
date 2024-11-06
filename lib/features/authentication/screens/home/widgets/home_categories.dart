import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/category_shimmer.dart';
import 'package:sport_shoes_store/features/shop/controllers/category_controller.dart';
import 'package:sport_shoes_store/features/shop/screens/sub_category/sub_categor%C3%ADes.dart';

import '../../../../../common/layouts/grid_layout.dart';
import '../../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../../common/widgets/shimmer/brand_shimmer.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../shop/controllers/brand_controller.dart';
import '../../../../shop/screens/brand/brand_products.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());
    final brandController = Get.put(BrandController());
 // để quản lý trạng thái của danh mục và thương hiệu.
    return Obx(() {
      if (brandController.isLoading.value) {
        return const BrandsShimmer();
      }
      if (brandController.featureBrands.isEmpty) {
        return Center(
            child: Text(
          "Không có dữ liệu ...",
          style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),
        ));
      } // kiểm tra isLoading và featureBrands. Nếu featureBrands rỗng, hiển thị thông báo không có dữ liệu.
      return Container(
        height: 80,
        child: ListView.builder( // hiển thị các thương hiệu
          shrinkWrap: true,
          itemCount: brandController.featureBrands.length,
          scrollDirection: Axis.horizontal,
          // mainAxisExtent: 80,
          itemBuilder: (_, index) {
            final brand = brandController.featureBrands[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SubCategoriesScreen(
                showBorder: true,
                brandModel: brand,
                onTap: () => Get.to(BrandProducts(brand: brand)),
              ),
            );
          },
        ),
      );
    });
  }
}
