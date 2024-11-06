// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sport_shoes_store/common/widgets/appbar/appbar.dart';
// import 'package:sport_shoes_store/common/widgets/heading/section_heading.dart';
// import 'package:sport_shoes_store/common/widgets/images/rounded_image.dart';
// import 'package:sport_shoes_store/common/widgets/products/product_cards/product_card_horizontal.dart';
// import 'package:sport_shoes_store/features/shop/controllers/category_controller.dart';
// import 'package:sport_shoes_store/features/shop/models/category_model.dart';
// import 'package:sport_shoes_store/features/shop/models/product_model.dart';
// import 'package:sport_shoes_store/features/shop/screens/all_products/all_products.dart';
// import 'package:sport_shoes_store/utils/constants/image_strings.dart';
// import 'package:sport_shoes_store/utils/constants/sizes.dart';
// import 'package:sport_shoes_store/utils/helpers/cloud_helper_futions.dart';
//
// class SubCategoriesScreen extends StatelessWidget {
//   const SubCategoriesScreen({super.key, required this.categoryModel, this.productModel});
//   final CategoryModel categoryModel;
//   final ProductModel? productModel;
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(CategoryController());
//     return Scaffold(
//       appBar: KAppbar(
//         title: Text(categoryModel.name),
//         showBackArrow: true,
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(Sizes.defaultSpace),
//           child: Column(
//             children: [
//               RoundImage(
//                 width: double.infinity,
//                 imageUrl: categoryModel.image,
//                 applyImageRadius: true,
//                 isNetworkImage: true,
//               ),
//               const SizedBox(
//                 height: Sizes.spaceBtwSections,
//               ),
//               FutureBuilder(
//                 future: controller.getSubCategory(categoryModel.id),
//                 builder: (context, snapshot) {
//                   final widget = KCloudHelperFunctions.checkMultiRecordState(
//                       snapshot: snapshot);
//                   if (widget != null) return widget;
//
//                   final subCategories = snapshot.data!;
//
//                   return ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: subCategories.length,
//                     physics: const NeverScrollableScrollPhysics(),
//                     itemBuilder: (context, index) {
//                       final subCategory = subCategories[index];
//                       return FutureBuilder(
//                         future: controller.getCategoryProducts(categoryId: subCategory.id),
//                         builder: (context, snapshot) {
//                           final widget = KCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot);
//                           if(widget != null) return widget;
//                           final products = snapshot.data!;
//                           return Column(
//                             children: [
//                               SectionHeading(
//                                 title: subCategory.name,
//                                 onPressed: () => Get.to(() => AllProductScreen(
//                                   title: subCategory.name,
//                                   futureMethod: controller.getCategoryProducts(
//                                       categoryId: subCategory.id, limit: -1),
//                                 )),
//                               ),
//                               const SizedBox(
//                                 height: Sizes.spaceBtwItems / 2,
//                               ),
//                               SizedBox(
//                                 height: 120,
//                                 child: ListView.separated(
//                                     scrollDirection: Axis.horizontal,
//                                     itemBuilder: (context, index) =>
//                                         ProductCartHorizontal(productModel: products[index],),
//                                     separatorBuilder: (context, index) => const SizedBox(
//                                       width: Sizes.spaceBtwItems,
//                                     ),
//                                     itemCount: products.length),
//                               )
//                             ],
//                           );
//                         },
//                       );
//                     },
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sport_shoes_store/features/shop/models/brand_model.dart';

import '../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/texts/brand_title_text_with_verifiled_icon.dart';
import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/helpers/helper.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({
    super.key, required this.showBorder, this.onTap, required this.brandModel
  });

  final BrandModel brandModel;
  final bool showBorder;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            child: Flexible(
              child: CircularImage(
                isNetworkImage: true,
                image: brandModel.image,
                backgroundColor: Colors.white,
              ),
            ),
          ),

          // RoundedContainer(
          //   padding: const EdgeInsets.all(Sizes.sm),
          //   // showBorder: showBorder,
          //   backgroundColor: Colors.transparent,
          //   child: Row(
          //     children: [
          //       Flexible(
          //         child: CircularImage(
          //           isNetworkImage: true,
          //           image: brandModel.image,
          //           backgroundColor: Colors.white,
          //         ),
          //       ),
          //       const SizedBox(width: Sizes.spaceBtwItems / 2,),
          //       Expanded(
          //         child: Column(
          //           mainAxisSize: MainAxisSize.min,
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             BrandTitleWithVerifiedIcon(title: brandModel.name, brandTextSizes: TextSizes.large, textColor: Colors.white,),
          //             // Text(
          //             //   '${brandModel.productsCount ?? 0} products',
          //             //   overflow: TextOverflow.ellipsis,
          //             //   style: Theme.of(context).textTheme.labelMedium,
          //             // )
          //           ],
          //         ),
          //       )
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}