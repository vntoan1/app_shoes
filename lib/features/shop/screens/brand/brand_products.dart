import 'package:flutter/material.dart';
import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
import 'package:sport_shoes_store/common/widgets/brand_card/brand_card.dart';
import 'package:sport_shoes_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:sport_shoes_store/features/shop/controllers/brand_controller.dart';
import 'package:sport_shoes_store/features/shop/models/brand_model.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/cloud_helper_futions.dart';
class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});
  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final controller = BrandController.instance;
    return Scaffold(
      appBar: KAppbar(
        title: Text(brand.name),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              BrandCard(showBorder: true, brandModel: brand),
              const SizedBox(height: Sizes.spaceBtwSections,),
              FutureBuilder(
                future: controller.getBrandProducts(brandId: brand.id),
                builder: (context, snapshot) {
                  const loader = VerticalProductShimmer();
                  final widget = KCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, loader: loader);
                  if(widget != null) return widget;

                  final brandProducts = snapshot.data!;
                  return  SortableProducts(products: brandProducts,);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
