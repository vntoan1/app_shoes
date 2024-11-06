import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sport_shoes_store/features/shop/models/cart_item_model.dart';

import '../../images/rounded_image.dart';
import '../../texts/brand_title_text_with_verifiled_icon.dart';
import '../../texts/product_title_text.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    super.key,
    required this.cartItemModel,
  });

  final CartItemModel cartItemModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RoundImage(
          imageUrl: cartItemModel.image ?? '',
          width: 60,
          height: 60,
          isNetworkImage: true,
          padding: const EdgeInsets.all(Sizes.sm),
          backgroundColor: HelperFunctions.isDarkMode(context)
              ? ColorApp.darkGrey
              : ColorApp.light,
        ),
        const SizedBox(
          width: Sizes.spaceBtwItems,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              BrandTitleWithVerifiedIcon(title: cartItemModel.brandName ?? ''),
              Text(
                cartItemModel.title,
                style: const TextStyle(
                    fontSize: 18, overflow: TextOverflow.ellipsis),
              ),
              // Flexible(
              //     child: ProductTextTitle(
              //       title: cartItemModel.title,
              //       maxLines: 1,
              //     )),
              // Text.rich(TextSpan(children: [
              //   TextSpan(
              //     children: (cartItemModel.selectedVariation ?? {})
              //         .entries
              //         .map((e) => TextSpan(
              //       children: [
              //         TextSpan(text: '${e.key}', style: Theme.of(context).textTheme.bodySmall),
              //         TextSpan(text: '${e.value}', style: Theme.of(context).textTheme.bodyLarge),
              //       ]
              //     )).toList(),
              //   )
              // ]))
            ],
          ),
        )
      ],
    );
  }
}
