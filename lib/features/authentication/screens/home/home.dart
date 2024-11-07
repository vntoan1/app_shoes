import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/layouts/grid_layout.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/curved_edges/custom_edges.dart';
import 'package:sport_shoes_store/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:sport_shoes_store/features/authentication/screens/home/widgets/home_appbar.dart';
import 'package:sport_shoes_store/features/authentication/screens/home/widgets/home_categories.dart';
import 'package:sport_shoes_store/features/authentication/screens/home/widgets/promo_slider.dart';
import 'package:sport_shoes_store/features/shop/controllers/product/product_controller.dart';
import 'package:sport_shoes_store/features/shop/screens/all_products/all_products.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/constants/text_strings.dart';
import 'package:sport_shoes_store/utils/device/device_utils.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';
import '../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/custom_shapes/curved_edges/custom_edges_widget.dart';
import '../../../../common/widgets/image_text_widgets/vertical_image_text.dart';
import '../../../../common/widgets/images/rounded_image.dart';
import '../../../../common/widgets/products/cart/cart_menu_icon.dart';
import '../../../../common/widgets/texts/section_heading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const PrimaryHeaderContainer(
              child: Column(
            children: [
              HomeAppBar(),
              SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              SearchContainer(
                text: 'Tìm kiếm trong cửa hàng',
              ),
              SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              Padding(
                padding: EdgeInsets.only(left: Sizes.defaultSpace),
                child: Column(
                  children: [
                    SectionHeading(
                      title: 'Thương hiệu phổ biến',
                      showActionButton: false,
                      textColor: ColorApp.bg,
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Sizes.spaceBtwSections,
              ),
              HomeCategories(),
              SizedBox(
                height: Sizes.spaceBtwSections * 2,
              ),
            ],
          )),
          Padding(
              padding: const EdgeInsets.all(Sizes.defaultSpace),
              child: Column(
                children: [
                  const PromoSlider(),
                  const SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),
                  SectionHeading(
                    title: 'Sản phẩm bán chạy',
                    onPressed: () => Get.to(() => AllProductScreen(
                        title: 'Popular Products',
                        futureMethod: controller.fetchAllFeaturedProducts(),
                        query: FirebaseFirestore.instance
                            .collection('Products')
                            .where('IsFeatured', isEqualTo: true)
                            .limit(6))),
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),
                  Obx(() {
                    if (controller.isLoading.value) {
                      return const VerticalProductShimmer();
                    }
                    if (controller.featuredProducts.isEmpty) {
                      return Center(
                          child: Text('No data',
                              style: Theme.of(context).textTheme.bodyMedium));
                    }
                    return GridLayout(
                        itemCount: controller.featuredProducts.length,
                        itemBuilder: (context, index) => ProductCardVertical(
                            productModel: controller.featuredProducts[index]));
                  })
                ],
              ))
        ],
      ),
    ));
  }
}
