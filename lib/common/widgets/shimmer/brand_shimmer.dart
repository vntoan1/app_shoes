import 'package:flutter/cupertino.dart';
import 'package:sport_shoes_store/common/layouts/grid_layout.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/shimmer.dart';

class BrandsShimmer extends StatelessWidget {
  const BrandsShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return GridLayout(
      itemCount: itemCount,
      mainAxisExtent: 80,
      itemBuilder: (p0, p1) => const KShimmerEffect(width: 300, height: 80),
    );
  }
}
