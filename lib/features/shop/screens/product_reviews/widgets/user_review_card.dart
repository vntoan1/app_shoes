import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:readmore/readmore.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:sport_shoes_store/common/widgets/products/ratings/rating_bar_indicator.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/constants/image_strings.dart';
import 'package:sport_shoes_store/utils/constants/sizes.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';
class UserReviewCard extends StatelessWidget {
  const UserReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = HelperFunctions.isDarkMode(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage(Images.onBoardingImage3),
                ),
                SizedBox(width: Sizes.spaceBtwItems,),
                Text('John Doe', style: Theme.of(context).textTheme.titleLarge,)
              ],
            ),
            IconButton(onPressed: (){}, icon: Icon(Icons.more_vert)),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems,),
        Row(
          children: [
            KRatingBarIndicator(rating: 4),
            const SizedBox(width: Sizes.spaceBtwItems,),
            Text('01 Now, 2023', style: Theme.of(context).textTheme.bodyMedium,),
          ],
        ),
        const SizedBox(height: Sizes.spaceBtwItems,),
        ReadMoreText(
          'The user interface of the ap is quite ....',
          trimLines: 2,
          trimMode: TrimMode.Line,
          trimExpandedText: 'show less',
          trimCollapsedText: ' show more',
          moreStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: ColorApp.blue02),
          lessStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: ColorApp.blue02),
        ),
        const SizedBox(height: Sizes.spaceBtwItems,),
        RoundedContainer(
          backgroundColor: dark ? ColorApp.darkGrey : ColorApp.grey,
          child: Padding(
            padding: EdgeInsets.all(Sizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("K's Store", style: Theme.of(context).textTheme.titleMedium,),
                    Text("02 Nov, 2023", style: Theme.of(context).textTheme.bodyMedium,),
                  ],
                ),
                const SizedBox(height: Sizes.spaceBtwItems,),
                ReadMoreText(
                  'The user interface of the ap is quite ....',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: 'show less',
                  trimCollapsedText: ' show more',
                  moreStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: ColorApp.blue02),
                  lessStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: ColorApp.blue02),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: Sizes.spaceBtwItems,)
      ],
    );
  }
}
