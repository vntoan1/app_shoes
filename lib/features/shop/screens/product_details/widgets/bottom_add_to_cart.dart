import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/icons/circular_icon.dart';
import 'package:sport_shoes_store/features/shop/controllers/cart_controller.dart';
import 'package:sport_shoes_store/features/shop/models/product_model.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';

import '../../../../../common/widgets/heading/section_heading.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../controllers/checkout_controller.dart';
import '../../../controllers/product/images_controller.dart';
import '../../../models/payment_method_model.dart';
import '../../checkout/widgets/payment_title.dart';

class BottomAddToCart extends StatelessWidget {
  const BottomAddToCart({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final controllerImg = Get.put(ImagesController());
    // final image = controllerImg.getAllProductImages(productModel);
    final controller = CartController.instance;
    controller.updateAlreadyAddedProductCount(product);
    final dark = HelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: ElevatedButton(
        onPressed: () => selectPaymentMethod(context),
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(Sizes.md),
            backgroundColor: Colors.orangeAccent,
            side: const BorderSide(color: Colors.transparent)),
        child: const SizedBox(
          width: double.infinity,
          height: 30,
          child: Center(
            child: Text(
              'Thêm vào giỏ hàng',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
    // return Container(
    //   padding: const EdgeInsets.symmetric(horizontal: Sizes.defaultSpace, vertical: Sizes.defaultSpace / 2),
    //   decoration: BoxDecoration(
    //     color: dark ? ColorApp.darkGrey : ColorApp.light,
    //     // borderRadius:const  BorderRadius.only(
    //     //   topLeft: Radius.circular(Sizes.cardRadiusLg),
    //     //   topRight: Radius.circular(Sizes.cardRadiusLg)
    //     // )
    //   ),
    //   child: Obx(
    //     ()=> Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Row(
    //           children: [
    //             CircularIcon(
    //                 icon: Icons.minimize,
    //               backgroundColor: ColorApp.darkGrey,
    //               width: 40,
    //               height: 40,
    //               color: ColorApp.bg,
    //               onPressed: () => controller.productQuantityInCart.value < 1 ? null : controller.productQuantityInCart.value -= 1,
    //             ),
    //             const SizedBox(width: Sizes.spaceBtwItems,),
    //             Text(controller.productQuantityInCart.value.toString(), style: Theme.of(context).textTheme.titleSmall,),
    //             const SizedBox(width: Sizes.spaceBtwItems,),
    //             CircularIcon(
    //               icon: Icons.add,
    //               backgroundColor: ColorApp.darkGrey,
    //               width: 40,
    //               height: 40,
    //               color: ColorApp.bg,
    //               onPressed: () => controller.productQuantityInCart.value += 1,
    //             ),
    //           ],
    //         ),
    //         ElevatedButton(
    //           onPressed: controller.productQuantityInCart.value < 1 ? null : () => controller.addToCart(product),
    //           style: ElevatedButton.styleFrom(
    //               padding: const EdgeInsets.all(Sizes.md),
    //               backgroundColor: ColorApp.black,
    //               side: const BorderSide(color: ColorApp.black)
    //           ),
    //           child: const Text('Thêm vào giỏ hàng'),
    //         )
    //       ],
    //     ),
    //   ),
    // );
  }

  Future<dynamic> selectPaymentMethod(BuildContext context) {
    final controller = CartController.instance;
    final controllerImg = Get.put(ImagesController());
    final image = controllerImg.getAllProductImages(product);
    return showModalBottomSheet(
        context: context,
        builder: (_) => SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(Sizes.iconLg),
                child: Obx(() {
                  final image = controllerImg.selectedProductImage.value;
                  return Column(
                    children: [
                      Row(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              width: 150,
                              height: 150,
                              color: Colors.black,
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                  imageUrl: image,
                                  progressIndicatorBuilder:
                                      (_, __, downloadProgress) =>
                                          CircularProgressIndicator(
                                            value: downloadProgress.progress,
                                            color: ColorApp.blue02,
                                          )),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 100),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(product.brand!.name, overflow: TextOverflow.ellipsis, maxLines: 3),
                                  Text(product.title, overflow: TextOverflow.ellipsis, maxLines: 3),
                                  Text('\$${product.price}'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Số lượng'),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () =>
                                      controller.productQuantityInCart.value < 1
                                          ? null
                                          : controller
                                              .productQuantityInCart.value -= 1,
                                  icon: const Icon(Icons.remove)),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(controller.productQuantityInCart.value
                                  .toString()),
                              const SizedBox(
                                width: 6,
                              ),
                              IconButton(
                                  onPressed: () => controller
                                      .productQuantityInCart.value += 1,
                                  icon: const Icon(Icons.add)),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: controller.productQuantityInCart.value < 1
                            ? null
                            : () async {
                                controller.addToCart(product);
                                Navigator.pop(context);
                              },
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(Sizes.md),
                            backgroundColor: Colors.orangeAccent,
                            side: const BorderSide(color: Colors.transparent)),
                        child: const SizedBox(
                          width: double.infinity,
                          height: 30,
                          child: Center(
                            child: Text(
                              'Thêm vào giỏ hàng',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                }),
              ),
            ));
  }

  // void _showToast(BuildContext context) {
  //   final scaffold = ScaffoldMessenger.of(context);
  //   scaffold.showSnackBar(
  //     SnackBar(
  //       content: const Text('Số lượng bé hơn 0, vui lòng nhập số lượng'),
  //       action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
  //     ),
  //   );
  // }
}
