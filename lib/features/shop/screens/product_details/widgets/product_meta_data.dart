import 'package:flutter/material.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:sport_shoes_store/common/widgets/images/circular_image.dart';
import 'package:sport_shoes_store/common/widgets/texts/brand_title_text_with_verifiled_icon.dart';
import 'package:sport_shoes_store/common/widgets/texts/product_price_text.dart';
import 'package:sport_shoes_store/common/widgets/texts/product_title_text.dart';
import 'package:sport_shoes_store/features/shop/controllers/product/product_controller.dart';
import 'package:sport_shoes_store/features/shop/models/product_model.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/enums.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';
class ProductMetaData extends StatelessWidget {
  const ProductMetaData({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    final darkMode = HelperFunctions.isDarkMode(context);
    final controller = ProductController.instance;
    final salePercentage = controller.calculateSalePercentage(productModel.price, productModel.salePrice);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RoundedContainer(
              radius: Sizes.sm,
              backgroundColor: ColorApp.blue02.withOpacity(0.8),
              padding: EdgeInsets.symmetric(horizontal: Sizes.sm, vertical: Sizes.xs),
              child: Text('$salePercentage%', style: Theme.of(context).textTheme.labelLarge!.apply(color: ColorApp.black),),
            ),
            SizedBox(width: Sizes.spaceBtwItems,),
            // if(productModel.productType == ProductType.single.toString() && productModel.salePrice > 0)
            Text('\$${productModel.price}', style: Theme.of(context).textTheme.titleSmall!.apply(decoration: TextDecoration.lineThrough),),
            SizedBox(width: Sizes.spaceBtwItems,),
            Text('\$${productModel.salePrice}', style: TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
            )
          ],
        ),
        SizedBox(height: Sizes.spaceBtwItems / 1.5,),
        ProductTextTitle(title: productModel.title,),
        SizedBox(height: Sizes.spaceBtwItems / 1.5,),

        Row(
          children: [
            ProductTextTitle(title: 'Status'),
            SizedBox(width: Sizes.spaceBtwItems,),
            Text(controller.getProductStockStatus(productModel.stock), style: Theme.of(context).textTheme.titleMedium,)
          ],
        ),
        SizedBox(height: Sizes.spaceBtwItems / 1.5,),
        Row(
          children: [
            CircularImage(
              image: productModel.brand != null ? productModel.brand!.image : '',
              width: 32,
              height: 32,
              overlayColor: darkMode ? ColorApp.bg : ColorApp.black,
            ), BrandTitleWithVerifiedIcon(title: productModel.brand!.name, brandTextSizes: TextSizes.medium,)
          ],
        )
      ],
    );
  }
}
