import 'package:flutter/material.dart';
import 'package:sport_shoes_store/common/styles/shadow_style.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:sport_shoes_store/common/widgets/icons/circular_icon.dart';
import 'package:sport_shoes_store/common/widgets/images/rounded_image.dart';
import 'package:sport_shoes_store/common/widgets/products/favourite_icon/favourite_icon.dart';
import 'package:sport_shoes_store/common/widgets/texts/brand_title_text_with_verifiled_icon.dart';
import 'package:sport_shoes_store/common/widgets/texts/product_title_text.dart';
import 'package:sport_shoes_store/features/shop/models/product_model.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';

import '../../../../features/shop/controllers/product/product_controller.dart';
import '../../texts/product_price_text.dart';
class ProductCartHorizontal extends StatelessWidget {
  const ProductCartHorizontal({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(productModel.price, productModel.salePrice);
    final dark = HelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: const EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Sizes.productImageRadius),
        color: dark ? ColorApp.darkGrey : ColorApp.greyBD
      ),
      child: Row(
        children: [
          RoundedContainer(
            height: 120,
            padding: const EdgeInsets.all(Sizes.sm),
            backgroundColor: dark ? ColorApp.dark : ColorApp.light,
            child: Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: RoundImage(
                      imageUrl: productModel.thumbnail ,
                      applyImageRadius: true,
                      isNetworkImage : true
                  ),
                ),
                if(salePercentage != null)
                Positioned(
                  top: 12,
                  child: RoundedContainer(
                    radius: Sizes.sm,
                    backgroundColor: ColorApp.blue02.withOpacity(0.8),
                    padding: const EdgeInsets.symmetric(horizontal: Sizes.sm, vertical: Sizes.xs),
                    child: Text('$salePercentage', style: Theme.of(context).textTheme.labelLarge!.apply(color: ColorApp.black),),
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: FavouriteIcon(productId: productModel.id,)
                )
              ],
            ),
          ),
          SizedBox(
            width: 172,
            child: Padding(
              padding: const EdgeInsets.only(top: Sizes.sm, left: Sizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductTextTitle(title: productModel.title, smallSize: true,),
                      const SizedBox(height: Sizes.spaceBtwItems/2,),
                      BrandTitleWithVerifiedIcon(title: productModel.brand!.name)
                    ],
                  ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          children: [
                            // if(widget.productModel.productType == ProductType.single.toString() && widget.productModel.salePrice > 0)
                            Padding(
                              padding: const EdgeInsets.only(left: Sizes.sm),
                              child: Text(
                                productModel.price.toString(),
                                style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: Sizes.sm),
                              child: ProductPriceText(price: controller.getProductPrice(productModel),),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                            color: ColorApp.dark,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(Sizes.cardRadiusLg),
                              bottomRight: Radius.circular(Sizes.productImageRadius),
                            )
                        ),
                        child: const SizedBox(
                          width: Sizes.iconLg * 1.2,
                          height: Sizes.iconLg * 1.2,
                          child: Center(child: Icon(Icons.add, color: ColorApp.bg,),),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
