import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/features/shop/controllers/product/images_controller.dart';
import 'package:sport_shoes_store/features/shop/models/product_model.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../common/widgets/custom_shapes/curved_edges/custom_edges_widget.dart';
import '../../../../../common/widgets/icons/circular_icon.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../common/widgets/products/favourite_icon/favourite_icon.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/helpers/helper.dart';

class ProductImageSlider extends StatelessWidget {
  const ProductImageSlider({
    super.key,
    required this.productModel,
  });

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final image = controller.getAllProductImages(productModel);
    return CurvedEdgeWidget(
      chid: Container(
        color: dark ? ColorApp.darkGrey : ColorApp.light,
        child: Stack(
          children: [
            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(Sizes.productImageRadius + 2),
                child: Center(
                  child: Obx(() {
                    final image = controller.selectedProductImage.value;
                    return GestureDetector(
                      onTap: ()=> controller.showEnlargedImage(image),
                      child: CachedNetworkImage(
                          imageUrl: image,
                          progressIndicatorBuilder: (_, __, downloadProgress) =>
                              CircularProgressIndicator(
                                value: downloadProgress.progress,
                                color: ColorApp.blue02,
                              )),
                    );
                  }),
                ),
              ),
            ),
            // chọn ảnh theo mẫu
            // Positioned(
            //   right: 40,
            //   bottom: 30,
            //   child: SizedBox(
            //     height: 80,
            //     child: ListView.separated(
            //         shrinkWrap: true,
            //         scrollDirection: Axis.horizontal,
            //         physics: const AlwaysScrollableScrollPhysics(),
            //         itemBuilder: (context, index) => Obx(() {
            //               final imageSelected =
            //                   controller.selectedProductImage.value ==
            //                       image[index];
            //               return RoundImage(
            //                 width: 80,
            //                 isNetworkImage: true,
            //                 backgroundColor: dark ? ColorApp.dark : ColorApp.bg,
            //                 border: Border.all(color: imageSelected ? ColorApp.blue02 : Colors.transparent),
            //                 padding: const EdgeInsets.all(Sizes.sm),
            //                 imageUrl: image[index],
            //                 onPressed: () => controller.selectedProductImage.value = image[index]
            //               );
            //             }),
            //         separatorBuilder: (_, __) => const SizedBox(
            //               width: Sizes.spaceBtwItems,
            //             ),
            //         itemCount: image.length),
            //   ),
            // ),
            KAppbar(
              leadingOnPressed: () => Get.back(),
              showBackArrow: true,
              actions: [
                FavouriteIcon(productId: productModel.id,)
              ],
            )
          ],
        ),
      ),
    );
  }
}
