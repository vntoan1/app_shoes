import 'package:flutter/cupertino.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/shimmer.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';

class CategoryShimmer extends StatelessWidget {
  const CategoryShimmer({super.key, this.itemCount = 6});
  final int itemCount;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          itemBuilder: (context, index) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                KShimmerEffect(width: 55, height: 55, radius: 55,),
                SizedBox(height: Sizes.spaceBtwItems / 2,),
                KShimmerEffect(width: 55, height: 8),
              ],
            );
          },
          separatorBuilder: (_,__) => const SizedBox(width: Sizes.spaceBtwItems,),
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: itemCount
      ),
    );
  }
}
