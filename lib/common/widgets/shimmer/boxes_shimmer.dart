import 'package:flutter/material.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/shimmer.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
class BoxesShimmer extends StatelessWidget {
  const BoxesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: KShimmerEffect(width: 150, height: 110)),
            SizedBox(width: Sizes.spaceBtwItems,),
            Expanded(child: KShimmerEffect(width: 150, height: 110)),
            SizedBox(width: Sizes.spaceBtwItems,),
            Expanded(child: KShimmerEffect(width: 150, height: 110)),
          ],
        )
      ],
    );
  }
}
