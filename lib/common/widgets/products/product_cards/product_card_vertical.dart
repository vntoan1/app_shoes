import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/styles/shadow_style.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:sport_shoes_store/common/widgets/images/rounded_image.dart';
import 'package:sport_shoes_store/common/widgets/texts/brand_title_text_with_verifiled_icon.dart';
import 'package:sport_shoes_store/common/widgets/texts/product_title_text.dart';
import 'package:sport_shoes_store/features/shop/controllers/product/product_controller.dart';
import 'package:sport_shoes_store/features/shop/models/product_model.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/enums.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';

import '../../../../features/shop/screens/product_details/product_detail.dart';
import '../../icons/circular_icon.dart';
import '../../texts/product_price_text.dart';
import '../favourite_icon/favourite_icon.dart';
import '../product_cart_add_button.dart';

class ProductCardVertical extends StatefulWidget {
  const ProductCardVertical({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<ProductCardVertical> createState() => _ProductCardVerticalState();
}

class _ProductCardVerticalState extends State<ProductCardVertical> {
  @override
  Widget build(BuildContext context) {
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(widget.productModel.price, widget.productModel.salePrice);
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetail(productModel: widget.productModel)),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow: [ShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(Sizes.productImageRadius),
          color: dark ? ColorApp.darkGrey : ColorApp.bg,
        ),
        child: Column(
          children: [
            RoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(Sizes.sm),
              backgroundColor: dark ? ColorApp.dark : ColorApp.light,
              child: Stack(
                children: [
                  Center(
                    child: RoundImage(
                      imageUrl: widget.productModel.thumbnail ,
                      applyImageRadius: true,
                        isNetworkImage : true
                    ),
                  ),
                  if(salePercentage != null)
                  Positioned(
                      top: 12,
                      child: RoundedContainer(
                        radius: Sizes.sm,
                        backgroundColor: ColorApp.yellowF8.withOpacity(0.8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: Sizes.sm, vertical: Sizes.xs),
                        child: Text(
                          '$salePercentage%',
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .apply(color: ColorApp.black),
                        ),
                      )),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: FavouriteIcon(productId: widget.productModel.id,)
                  )
                ],
              ),
            ),
            const SizedBox(height: Sizes.spaceBtwItems / 2,),
            Padding(
              padding: const EdgeInsets.only(left: Sizes.sm),
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductTextTitle(title: widget.productModel.title, smallSize: true,),
                    const SizedBox(height: Sizes.spaceBtwItems/2,),
                    BrandTitleWithVerifiedIcon(title: widget.productModel.brand!.name),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if(widget.productModel.productType == ProductType.single.toString() && widget.productModel.salePrice > 0)
                      Padding(
                        padding: const EdgeInsets.only(left: Sizes.sm),
                        child: Text(
                          widget.productModel.price.toString(),
                          style: Theme.of(context).textTheme.labelMedium!.apply(decoration: TextDecoration.lineThrough),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: Sizes.sm),
                        child: Text(
                          widget.productModel.salePrice.toString(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        // child: ProductPriceText(price: controller.getProductPrice(widget.productModel)),
                      ),
                    ],
                  ),
                ),
                ProductCartAddToCart(productModel: widget.productModel,)
              ],
            )
          ],
        ),
      ),
    );
  }
}


