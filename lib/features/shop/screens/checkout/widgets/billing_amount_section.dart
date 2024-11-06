import 'package:flutter/material.dart';
import 'package:sport_shoes_store/features/shop/controllers/cart_controller.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/pricing_calculator.dart';
class BillingAmountSection extends StatelessWidget {
  const BillingAmountSection({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Số tiền',style: Theme.of(context).textTheme.bodyLarge,),
            Text('\$$subTotal',style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tiền ship',style: Theme.of(context).textTheme.bodyLarge,),
            Text('\$${PricingCalculator.calculateShippingCost(subTotal, 'VN')}',style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Thuế',style: Theme.of(context).textTheme.bodyLarge,),
            Text('\$${PricingCalculator.calculateTax(subTotal, 'VN')}',style: Theme.of(context).textTheme.labelLarge,),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems / 2,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Tổng tiền',style: Theme.of(context).textTheme.bodyLarge,),
            Text('\$${PricingCalculator.calculateTotalPrice(subTotal, 'VN')}',style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
      ],
    );
  }
}
