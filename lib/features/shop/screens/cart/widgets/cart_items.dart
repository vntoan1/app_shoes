import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/features/shop/controllers/cart_controller.dart';

import '../../../../../common/widgets/products/cart/cart_item.dart';
import '../../../../../common/widgets/texts/product_title_text.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../product_details/widgets/product_quantity_with_add_remove.dart';

class CartItems extends StatelessWidget {
  const CartItems({
    super.key,
    this.showAddRemoveButtons = true,
  });

  final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(
          height: Sizes.spaceBtwSections,
        ),
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) => Obx(() {
          final item = controller.cartItems[index];
          return Column(
            children: [
              CartItem(
                cartItemModel: item,
              ),
              if (showAddRemoveButtons)
                const SizedBox(
                  height: Sizes.spaceBtwItems,
                ),
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const SizedBox(width: 70),
                        ProductQuantityWithAddRemove(
                          quantity: item.quantity,
                          add: () => controller.addOneToCart(item),
                          remove: () => controller.removeOneFromCart(item),
                        ),
                      ],
                    ),
                    ProductTextTitle(
                        title: (item.price * item.quantity).toStringAsFixed(1)),
                  ],
                )
            ],
          );
        }),
      ),
    );
  }
}
