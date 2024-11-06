import 'package:flutter/cupertino.dart';
import 'package:sport_shoes_store/common/layouts/grid_layout.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/shimmer.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';

class VerticalProductShimmer extends StatelessWidget {
  const VerticalProductShimmer({super.key, this.itemCount = 4});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return GridLayout(
        itemCount: itemCount,
        itemBuilder: (p0, p1) => const SizedBox(
          width: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              KShimmerEffect(width: 180, height: 180),
              SizedBox(height: Sizes.spaceBtwItems,),

              KShimmerEffect(width: 160, height: 15),
              SizedBox(height: Sizes.spaceBtwItems/2),
              KShimmerEffect(width: 110, height: 15),
            ],
          ),
        ),
    );
  }
}