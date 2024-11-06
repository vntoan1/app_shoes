import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/sizes.dart';

class RattingAndShare extends StatelessWidget {
  const RattingAndShare({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 24,),
            const SizedBox(width: Sizes.spaceBtwItems / 2,),
            Text.rich(
                TextSpan(
                    children: [
                      TextSpan(text: '7.0', style: Theme.of(context).textTheme.bodyLarge),
                      const TextSpan(text: '(777)')
                    ]
                )
            )
          ],
        ),
        IconButton(onPressed: (){}, icon: const Icon(Icons.share, size: Sizes.iconMd,))
      ],
    );
  }
}