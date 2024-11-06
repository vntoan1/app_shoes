import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/layouts/grid_layout.dart';
import 'package:sport_shoes_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:sport_shoes_store/features/shop/controllers/category_controller.dart';
import 'package:sport_shoes_store/features/shop/models/category_model.dart';
import 'package:sport_shoes_store/features/shop/models/product_model.dart';
import 'package:sport_shoes_store/features/shop/screens/all_products/all_products.dart';
import 'package:sport_shoes_store/features/shop/screens/store/widgets/category_brands.dart';
import 'package:sport_shoes_store/utils/helpers/cloud_helper_futions.dart';

import '../../../../../common/widgets/brand_card/brand_show_case.dart';
import '../../../../../common/widgets/heading/section_heading.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              // CategoryBrands(categoryModel: categoryModel),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              FutureBuilder(
                  future: controller.getCategoryProducts(
                      categoryId: categoryModel.id),
                  builder: (context, snapshot) {
                    final response =
                        KCloudHelperFunctions.checkMultiRecordState(
                            snapshot: snapshot,
                            loader: const VerticalProductShimmer());
                    if (response != null) return response;
                    final products = snapshot.data!;
                    return Column(
                      children: [
                        // SectionHeading(
                        //   title: categoryModel.name,
                        //   onPressed: () => Get.to(AllProductScreen(
                        //     title: categoryModel.name,
                        //     futureMethod: controller.getCategoryProducts(
                        //         categoryId: categoryModel.id, limit: -1),
                        //   )),
                        // ),
                        // const SizedBox(
                        //   height: Sizes.spaceBtwItems,
                        // ),
                        GridLayout(
                            itemCount: products.length,
                            itemBuilder: (_, index) => ProductCardVertical(
                                productModel: products[index])),
                      ],
                    );
                  })
            ],
          ),
        ),
      ],
    );
  }
}
