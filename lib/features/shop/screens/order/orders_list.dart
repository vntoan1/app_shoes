import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:sport_shoes_store/common/widgets/loader/animation_loader.dart';
import 'package:sport_shoes_store/features/shop/controllers/order_controller.dart';
import 'package:sport_shoes_store/navigation_menu.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/cloud_helper_futions.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';
class OrderListItems extends StatefulWidget {
  const OrderListItems({super.key});

  @override
  State<OrderListItems> createState() => _OrderListItemsState();
}

class _OrderListItemsState extends State<OrderListItems> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = HelperFunctions.isDarkMode(context);
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (context, snapshot) {
        // nothing found widget
        final emptyWidget = AnimationLoaderWidget(
            text: 'Whoops! No Orders Yet!',
            animation: Images.onBoardingImage3,
          showAction: true,
          actionText: 'Lets fi...',
          onActionPressed: () => Get.off(() => const NavigationMenu()),
        );

        final response = KCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot, nothingFound: emptyWidget);
        if(response != null) return response;

        final orders = snapshot.data!;

        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (context, index) => const SizedBox(height: Sizes.spaceBtwItems,),
          itemBuilder: (context, index){
            final order = orders[index];
            return  RoundedContainer(
              showBorder: true,
              borderColor: ColorApp.grey,
              padding: const EdgeInsets.all((Sizes.md)),
              backgroundColor: dark ? ColorApp.dark : ColorApp.light,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.local_shipping),
                            const SizedBox(width: Sizes.spaceBtwItems/2,),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    order.orderStatusText,
                                    style: Theme.of(context).textTheme.bodyLarge!.apply(color: ColorApp.blue02, fontWeightDelta: 1),
                                  ),
                                  Text(
                                    order.formattedOrderDate,
                                    style: Theme.of(context).textTheme.headlineSmall,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_sharp, size: Sizes.iconSm,))
                    ],
                  ),
                  const SizedBox(height: Sizes.spaceBtwItems,),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.shopping_bag),
                            const SizedBox(width: Sizes.spaceBtwItems/2,),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order',
                                    style: Theme.of(context).textTheme.labelMedium!.apply(color: ColorApp.grey82, fontWeightDelta: 1),
                                  ),
                                  Text(
                                    order.id,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            const Icon(Icons.date_range_rounded),
                            const SizedBox(width: Sizes.spaceBtwItems/2,),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Shopping Date',
                                    style: Theme.of(context).textTheme.labelMedium!.apply(color: ColorApp.grey82, fontWeightDelta: 1),
                                  ),
                                  Text(
                                    order.formattedOrderDate,
                                    style: Theme.of(context).textTheme.titleMedium,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }
}
