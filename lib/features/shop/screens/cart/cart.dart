import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
import 'package:sport_shoes_store/common/widgets/icons/circular_icon.dart';
import 'package:sport_shoes_store/common/widgets/images/rounded_image.dart';
import 'package:sport_shoes_store/common/widgets/loader/animation_loader.dart';
import 'package:sport_shoes_store/common/widgets/texts/brand_title_text_with_verifiled_icon.dart';
import 'package:sport_shoes_store/common/widgets/texts/product_title_text.dart';
import 'package:sport_shoes_store/common/widgets/products/cart/cart_item.dart';
import 'package:sport_shoes_store/features/shop/controllers/cart_controller.dart';
import 'package:sport_shoes_store/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:sport_shoes_store/features/shop/screens/checkout/checkout.dart';
import 'package:sport_shoes_store/features/shop/screens/product_details/widgets/product_quantity_with_add_remove.dart';
import 'package:sport_shoes_store/navigation_menu.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: KAppbar(
        showBackArrow: true,
        title: Text(
          'Giỏ hàng',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: Obx(() {
        final emptyWidget = AnimationLoaderWidget(
            text: 'Whoops! Cart is Empty',
            animation: Images.onBoardingImage3,
          showAction: true,
          actionText: 'Lets fill it',
          onActionPressed: () => Get.offAll(()=> const NavigationMenu()),
        );

        if(controller.cartItems.isEmpty){
          return emptyWidget;
        }else{
          return const SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Sizes.defaultSpace),
              child: CartItems(),
            ),
          );
        }
      }),
      bottomNavigationBar: controller.cartItems.isEmpty
        ? const SizedBox()
          : Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(() => const CheckoutScreen()),
          child:  Obx( ()=> Text('Thanh toán với \$${controller.totalCartPrice.value}')),
        ),
      ),
    );
  }
}
