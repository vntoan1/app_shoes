import 'package:flutter/material.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/shimmer.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
class ListTitleShimmer extends StatelessWidget {
  const ListTitleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            KShimmerEffect(width: 50, height: 50, radius: 50,),
            SizedBox(width: Sizes.spaceBtwItems,),
            Column(
              children: [
                KShimmerEffect(width: 100, height: 15),
                SizedBox(height: Sizes.spaceBtwItems/2,),
                KShimmerEffect(width: 80, height: 12),
              ],
            )
          ],
        )
      ],
    );
  }
}
