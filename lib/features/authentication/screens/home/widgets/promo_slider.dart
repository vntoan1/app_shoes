import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/shimmer/shimmer.dart';
import 'package:sport_shoes_store/features/shop/controllers/banner_controller.dart';
// để quản lý các banner.
import 'package:sport_shoes_store/utils/constants/colors.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../controllers/home_controller.dart';
 // Đây là widget để hiển thị các banner quảng cáo dưới dạng slider.
class PromoSlider extends StatelessWidget {
  const PromoSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BannerController());
    // Khởi tạo BannerController để quản lý trạng thái của các banner quảng cáo.
    return Obx(() {
      if (controller.isLoading.value) return const KShimmerEffect(width: double.infinity, height: 190);
      if (controller.banners.isEmpty) {
        return Center(
          child: Text(
            'No data found!',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: Colors.black),
          ),
        );
      }else{
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                  viewportFraction: 1,
                  onPageChanged: (index, _) =>
                      controller.updatePageIndicator(index)), // điều chỉnh slide
              items: controller.banners
                  .map((banner) => RoundImage(
                imageUrl: banner.imageUrl,
                isNetworkImage: true,
                onPressed: () => Get.toNamed(banner.targetScreen),
              ))
                  .toList(),
            ),
            const SizedBox(
              height: Sizes.spaceBtwItems,
            ),
            Center(
              child: Obx(
                    () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    for (int i = 0; i < controller.banners.length; i++)
                      CircularContainer(
                        width: 20,
                        height: 4,
                        margin: const EdgeInsets.only(right: 10),
                        background: controller.carousalCurrentIndex.value == i
                            ? ColorApp.blue02
                            : ColorApp.grey82,
                      )
                  ],
                ),
              ),
            )
          ],
        );
      }
    });
  }
}
