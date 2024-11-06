import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/chips/choice_chip.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:sport_shoes_store/common/widgets/heading/section_heading.dart';
import 'package:sport_shoes_store/common/widgets/texts/product_price_text.dart';
import 'package:sport_shoes_store/common/widgets/texts/product_title_text.dart';
import 'package:sport_shoes_store/features/shop/controllers/product/variation_controller.dart';
import 'package:sport_shoes_store/features/shop/models/product_model.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';
import 'package:sport_shoes_store/common/widgets/chips/chip_theme.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key, required this.productModel});
  final ProductModel productModel;
  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () => Column(
        children: [
          // if (controller.selectedVariation.value.id.isNotEmpty)
          RoundedContainer(
              padding: const EdgeInsets.all(Sizes.md),
              backgroundColor:
                  dark ? ColorApp.darkGrey : ColorApp.grey82.withOpacity(0.2),
              child: Column(
                children: [
                  Row(
                    children: [
                      SectionHeading(
                        title: 'Variation',
                        showActionButton: false,
                      ),
                      SizedBox(
                        width: Sizes.spaceBtwItems,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const ProductTextTitle(
                                title: 'Price : ',
                                smallSize: true,
                              ),
                              const SizedBox(
                                width: Sizes.spaceBtwItems,
                              ),
                              // if (controller.selectedVariation.value.salePrice >
                              //     0)
                                Text(
                                  '\$${controller.getVariationPrice()}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .apply(
                                          decoration:
                                              TextDecoration.lineThrough),
                                ),
                              const SizedBox(
                                width: Sizes.spaceBtwItems,
                              ),
                              ProductPriceText(
                                  price: controller.getVariationPrice())
                            ],
                          ),
                          Row(
                            children: [
                              ProductTextTitle(
                                title: 'Stock',
                                smallSize: true,
                              ),
                              Text(
                                controller.variationStockStatus.value,
                                style: Theme.of(context).textTheme.titleMedium,
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                  ProductTextTitle(
                    title: controller.selectedVariation.value.description ?? '',
                    smallSize: true,
                    maxLines: 4,
                  ),
                ],
              ),
            ),
          const SizedBox(
            height: Sizes.spaceBtwItems,
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: productModel.productAttributes!
                  .map((attributes) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SectionHeading(
                            title: attributes.name ?? '',
                            showActionButton: false,
                          ),
                          const SizedBox(
                            height: Sizes.spaceBtwItems / 2,
                          ),
                          Obx(
                            () => Wrap(
                                spacing: 8,
                                children:
                                    attributes.values!.map((attributeValue) {
                                  final isSelected =
                                      controller.selectedAttributes[
                                              attributes.name] ==
                                          attributeValue;
                                  final available = controller
                                      .getAttributesAvailabilityInVariation(
                                          productModel.productVariations!,
                                          attributes.name!)
                                      .contains(attributeValue);
                                  return KChoiceChip(
                                      text: attributeValue,
                                      selected: isSelected,
                                      onSelected: available
                                          ? (selected) {
                                              if (selected && available) {
                                                controller.onAttributesSelected(
                                                    productModel,
                                                    attributes.name ?? '',
                                                    attributeValue);
                                              }
                                            }
                                          : null);
                                }).toList()),
                          )
                        ],
                      ))
                  .toList())
        ],
      ),
    );
  }
}
