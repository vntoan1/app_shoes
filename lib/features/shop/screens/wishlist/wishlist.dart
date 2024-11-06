import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/layouts/grid_layout.dart';
import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
import 'package:sport_shoes_store/common/widgets/icons/circular_icon.dart';
import 'package:sport_shoes_store/common/widgets/loader/animation_loader.dart';
import 'package:sport_shoes_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:sport_shoes_store/features/authentication/screens/home/home.dart';
import 'package:sport_shoes_store/features/shop/controllers/favourite_controller.dart';
import 'package:sport_shoes_store/features/shop/models/product_model.dart';
import 'package:sport_shoes_store/navigation_menu.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/cloud_helper_futions.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final controller = FavouritesController.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KAppbar(
        title: Text(
          'Sản phẩm yêu thich',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        // actions: [
        //   CircularIcon(
        //     icon: Icons.add,
        //     onPressed: () => Get.to(const HomeScreen()),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.defaultSpace),
          child: Obx(
              () => FutureBuilder(
              future: controller.favoriteProducts(),
              builder: (context, snapshot) {
                final emptyWidget = AnimationLoaderWidget(
                  text: 'Whoops! Wishlist is Empty ...',
                  animation: Images.onBoardingImage3,
                  showAction: true,
                  actionText: 'Let add some',
                  onActionPressed: () => Get.offAll(const NavigationMenu()),
                );

                const loader = VerticalProductShimmer(
                  itemCount: 6,
                );
                final widget = KCloudHelperFunctions.checkMultiRecordState(
                    snapshot: snapshot,
                    loader: loader,
                    nothingFound: emptyWidget);
                if (widget != null) return widget;
                final products = snapshot.data!;
                return GridLayout(
                    itemCount: products.length,
                    itemBuilder: (_, index) =>
                        ProductCardVertical(productModel: products[index]));
              },
            ),
          ),
        ),
      ),
    );
  }
}
