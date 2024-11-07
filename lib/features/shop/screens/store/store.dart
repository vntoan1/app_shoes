import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sport_shoes_store/common/layouts/grid_layout.dart';
import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/search_container.dart';
import 'package:sport_shoes_store/common/widgets/heading/section_heading.dart';
import 'package:sport_shoes_store/common/widgets/products/cart/cart_menu_icon.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/brand_shimmer.dart';
import 'package:sport_shoes_store/common/widgets/tabbar/tab_bar.dart';
import 'package:sport_shoes_store/common/widgets/texts/brand_title_text_with_verifiled_icon.dart';
import 'package:sport_shoes_store/features/shop/controllers/brand_controller.dart';
import 'package:sport_shoes_store/features/shop/controllers/category_controller.dart';
import 'package:sport_shoes_store/features/shop/screens/brand/all_brands.dart';
import 'package:sport_shoes_store/features/shop/screens/brand/brand_products.dart';
import 'package:sport_shoes_store/features/shop/screens/store/widgets/category_tab.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/enums.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';

import '../../../../common/widgets/brand_card/brand_card.dart';
import '../../../../common/widgets/brand_card/brand_show_case.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/shimmer/vertical_product_shimmer.dart';
import '../../controllers/product/product_controller.dart';
import '../all_products/all_products.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final controller = Get.put(ProductController());
    final categories = CategoryController.instance.featuredCategories;
    final dark = HelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
          appBar: KAppbar(
            title: Text(
              'Cửa hàng',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            actions: [CartCounterIcon(onPressed: () {})],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  const SizedBox(
                    height: Sizes.spaceBtwItems,
                  ),
                  const SearchContainer(
                    text: 'Tìm kiếm trong cửa hàng',
                    showBorder: true,
                    showBackground: true,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),
                  SectionHeading(
                    title: 'Thương hiệu nổi bật',
                    onPressed: () => Get.to(() => const AllBrandsScreen()),
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwItems / 1.5,
                  ),
                  Obx(() {
                    if (brandController.isLoading.value) {
                      return const BrandsShimmer();
                    }
                    if (brandController.featureBrands.isEmpty) {
                      return Center(
                          child: Text(
                        "Không có dữ liệu ...",
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .apply(color: Colors.white),
                      ));
                    }
                    return GridLayout(
                      itemCount: brandController.featureBrands.length,
                      mainAxisExtent: 80,
                      itemBuilder: (_, index) {
                        final brand = brandController.featureBrands[index];
                        return BrandCard(
                          showBorder: true,
                          brandModel: brand,
                          onTap: () => Get.to(BrandProducts(brand: brand)),
                        );
                      },
                    );
                  }),
                  const SizedBox(height: 30,),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const VerticalProductShimmer();
                    }
                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                          child: Text('Không có dữ liệu...',
                              style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return GridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder: (context, index) => ProductCardVertical(
                            productModel: controller.featuredProducts[index]));
                  })
                ],
              ),
            ),
          )),
    );
  }
}
