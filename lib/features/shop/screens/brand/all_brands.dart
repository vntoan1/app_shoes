import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/layouts/grid_layout.dart';
import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
import 'package:sport_shoes_store/common/widgets/brand_card/brand_card.dart';
import 'package:sport_shoes_store/common/widgets/heading/section_heading.dart';
import 'package:sport_shoes_store/common/widgets/products/sortable/sortable_products.dart';
import 'package:sport_shoes_store/features/shop/controllers/brand_controller.dart';
import 'package:sport_shoes_store/features/shop/models/brand_model.dart';
import 'package:sport_shoes_store/features/shop/screens/brand/brand_products.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';

import '../../../../common/widgets/shimmer/brand_shimmer.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    return Scaffold(
      appBar: const KAppbar(
        title: Text('Brand'),
        showBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              const SectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const SizedBox(
                height: Sizes.spaceBtwItems,
              ),
              Obx(
                      () {
                    if(brandController.isLoading.value) return const BrandsShimmer();
                    if(brandController.featureBrands.isEmpty){
                      return Center(child: Text("No data", style: Theme.of(context).textTheme.bodyMedium!.apply(color: Colors.white),));
                    }
                    return GridLayout(
                      itemCount: brandController.allBrands.length,
                      mainAxisExtent: 80,
                      itemBuilder: (_, index) {
                        final brand = brandController.allBrands[index];
                        return BrandCard(showBorder: true, brandModel: brand,onTap: ()=> BrandProducts(brand: brand,));
                      },
                    );
                  }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
