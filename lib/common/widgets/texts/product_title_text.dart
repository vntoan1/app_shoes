import 'package:flutter/material.dart';
class ProductTextTitle extends StatelessWidget {
  const ProductTextTitle({super.key, required this.title, this.smallSize = false, this.maxLines, this.textAlign});
  final String title;
  final bool smallSize;
  final int? maxLines;
  final TextAlign? textAlign;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: smallSize ? Theme.of(context).textTheme.labelLarge : Theme.of(context).textTheme.titleSmall,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
