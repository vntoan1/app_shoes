import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/icons/circular_icon.dart';
import 'package:sport_shoes_store/features/shop/controllers/favourite_controller.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';

class FavouriteIcon extends StatelessWidget {
  const FavouriteIcon({super.key, required this.productId});
  final String productId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouritesController());
    return Obx(
      () => CircularIcon(
        icon: controller.isFavourite(productId)
            ? Icons.favorite
            : Icons.favorite_border,
        color: controller.isFavourite(productId) ? Colors.red : null,
        onPressed: () => controller.toggleFavoriteProducts(productId),
      ),
    );
  }
}
