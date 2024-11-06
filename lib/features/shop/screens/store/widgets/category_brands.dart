import 'package:flutter/material.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/boxes_shimmer.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/list_title_shimmer.dart';
import 'package:sport_shoes_store/features/shop/controllers/brand_controller.dart';
import 'package:sport_shoes_store/features/shop/models/category_model.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/cloud_helper_futions.dart';

import '../../../../../common/widgets/brand_card/brand_show_case.dart';
import '../../../../../utils/constants/image_strings.dart';
class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.categoryModel});

  final CategoryModel categoryModel;
  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return FutureBuilder(
      future: controller.getBrandsForProducts(categoryModel.id),
      builder: (context, snapshot) {
        const loader = Column(
          children: [
            ListTitleShimmer(),
            SizedBox(height: Sizes.spaceBtwItems,),
            BoxesShimmer(),
            SizedBox(height: Sizes.spaceBtwItems,),
          ],
        );
        final widget = KCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
        if(widget != null) return widget;

        final brands = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: brands.length,
          itemBuilder: (context, index) {
            final brand = brands[index];
            return FutureBuilder(
                future: controller. getBrandProducts(brandId: brand.id, limit: 3),
                builder: (context, snapshot) {
                  final widget = KCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if(widget != null) return widget;

                  final products = snapshot.data!;
                  return BrandShowcase(brand: brand, images: products.map((e) => e.thumbnail).toList());
                },
            );
          },
        );
      },
    );
  }
}
