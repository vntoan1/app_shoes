import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:sport_shoes_store/common/widgets/loader/loaders.dart';
import 'package:sport_shoes_store/common/widgets/products/cart/cart_item.dart';
import 'package:sport_shoes_store/features/authentication/screens/home/home.dart';
import 'package:sport_shoes_store/features/authentication/screens/signup/success_screen.dart';
import 'package:sport_shoes_store/features/shop/controllers/cart_controller.dart';
import 'package:sport_shoes_store/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:sport_shoes_store/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:sport_shoes_store/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:sport_shoes_store/navigation_menu.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';
import 'package:sport_shoes_store/utils/helpers/pricing_calculator.dart';

import '../../../../common/widgets/products/cart/coupon_widget.dart';
import '../../controllers/order_controller.dart';
import '../cart/widgets/cart_items.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    final orderController = Get.put(OrderController());
    final totalAmount = PricingCalculator.calculateTotalPrice(subTotal, 'VN');
    final dark = HelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: KAppbar(
        showBackArrow: true,
        title: Text(
          'Thanh toán',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Column(
            children: [
              const CartItems(
                showAddRemoveButtons: false,
              ),
              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              const CouponCode(),
              const SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              RoundedContainer(
                showBorder: true,
                padding: const EdgeInsets.all(Sizes.md),
                backgroundColor: dark ? ColorApp.black : ColorApp.white,
                child: const Column(
                  children: [
                    BillingAmountSection(),
                    SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                    Divider(),
                    SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                    BillingPaymentSection(),
                    SizedBox(
                      height: Sizes.spaceBtwItems,
                    ),
                    BillingAddressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Sizes.defaultSpace),
        child: ElevatedButton(
          onPressed: subTotal > 0
              ? () => orderController.processOrder(totalAmount)
              : () => Loaders.warningSnackBar(
                  title: 'Empty cart', message: 'Add items in the...'),
          child: Text('Thanh toán với \$$totalAmount'),
        ),
      ),
    );
  }
}
