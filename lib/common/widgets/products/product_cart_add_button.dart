import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/features/shop/controllers/cart_controller.dart';
import 'package:sport_shoes_store/features/shop/models/product_model.dart';
import 'package:sport_shoes_store/features/shop/screens/product_details/product_detail.dart';
import 'package:sport_shoes_store/utils/constants/enums.dart';

import '../../../features/shop/models/cart_item_model.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class ProductCartAddToCart extends StatelessWidget {
  const ProductCartAddToCart({super.key, required this.productModel, this.item});

  final ProductModel productModel;
  final CartItemModel? item;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return InkWell(
        onTap: () {
          final cartItem = controller.convertToCartItem(productModel, 1);
          controller.addOneToCart(cartItem);
      // if (productModel.productType == ProductType.single.toString()) {
      //   final cartItem = controller.convertToCartItem(productModel, 1);
      //   controller.addOneToCart(cartItem);
      // } else {
      //   print('saiiii');
      //   Get.to(() => ProductDetail(productModel: productModel));
      // }
    }, child: Obx(() {
      final productQuantityInCart =
          controller.getProductQuantityInCart(productModel.id);
      return Container(
        decoration: BoxDecoration(
            color: productQuantityInCart > 0 ? ColorApp.blue02 : ColorApp.dark,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(Sizes.cardRadiusLg),
              bottomRight: Radius.circular(Sizes.productImageRadius),
            )),
        child: SizedBox(
            width: Sizes.iconLg * 1.2,
            height: Sizes.iconLg * 1.2,
            child: Center(
              child: productQuantityInCart > 0
                  ? Text(
                      productQuantityInCart.toString(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .apply(color: Colors.white),
                    )
                  : const Icon(
                      Icons.add,
                      color: ColorApp.white,
                    ),
            )),
      );
    }));
  }
}
