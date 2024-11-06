import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/features/shop/models/product_model.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';

class ImagesController extends GetxController {
  static ImagesController get instance => Get.find();

  RxString selectedProductImage = ''.obs;

  List<String> getAllProductImages(ProductModel productModel) {
    // use set to add unique images only
    Set<String> images = {};

    // load thumbnail image
    images.add(productModel.thumbnail);

    // assign thumbnail as selected image
    selectedProductImage.value = productModel.thumbnail;

    // get all images from the product model if not null
    if (productModel.images != null) {
      images.addAll(productModel.images!);
    }

    // get all images from the product variations if not null
    if (productModel.productVariations != null ||
        productModel.productVariations!.isNotEmpty) {
      images.addAll(
          productModel.productVariations!.map((variation) => variation.image));
    }

    return images.toList();
  }

  void showEnlargedImage(String image) {
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: Sizes.defaultSpace * 2,
                        horizontal: Sizes.defaultSpace),
                    child: CachedNetworkImage(
                      imageUrl: image,
                    ),
                  ),
                  const SizedBox(
                    height: Sizes.spaceBtwSections,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: 150,
                      child: OutlinedButton(
                        onPressed: () => Get.back(),
                        child: const Text('Close'),
                      ),
                    ),
                  )
                ],
              ),
            ));
  }
}
