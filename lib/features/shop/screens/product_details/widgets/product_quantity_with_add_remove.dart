import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper.dart';
import '../../../controllers/cart_controller.dart';

class ProductQuantityWithAddRemove extends StatelessWidget {
  const ProductQuantityWithAddRemove({
    super.key, required this.quantity, this.add, this.remove,
  });

  final int quantity;
  final VoidCallback? add, remove;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Row(
          children: [
            CircularIcon(
              icon: Icons.add,
              width: 32,
              height: 32,
              size: Sizes.md,
              color: HelperFunctions.isDarkMode(context) ? ColorApp.bg : ColorApp.black,
              backgroundColor: HelperFunctions.isDarkMode(context) ? ColorApp.darkGrey : ColorApp.light,
              onPressed: remove,
            ),
            const SizedBox(width: Sizes.spaceBtwItems,),
            Text(quantity.toString(), style: Theme.of(context).textTheme.titleSmall,),
            const SizedBox(width: Sizes.spaceBtwItems,),
            CircularIcon(
              icon: Icons.add,
              width: 32,
              height: 32,
              size: Sizes.md,
              color: HelperFunctions.isDarkMode(context) ? ColorApp.bg : ColorApp.black,
              backgroundColor: ColorApp.blue02,
              onPressed: add,
            ),
          ],
    );
  }
}

