import 'package:flutter/material.dart';
import 'package:sport_shoes_store/common/widgets/custom_shapes/containers/circular_container.dart';
import 'package:sport_shoes_store/utils/constants/colors.dart';
import 'package:sport_shoes_store/utils/helpers/helper.dart';

class KChoiceChip extends StatelessWidget {
  const KChoiceChip(
      {super.key, required this.text, required this.selected, this.onSelected});
  final String text;
  final bool selected;
  final void Function(bool)? onSelected;

  @override
  Widget build(BuildContext context) {
    final isColor = HelperFunctions.getColor(text) != null;
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        label: isColor
            ? const SizedBox()
            : Text(text),
        selected: selected,
        onSelected: onSelected,
        labelStyle: TextStyle(color: selected ? ColorApp.bg : null),
        avatar: isColor
            ? CircularContainer(
                width: 50,
                height: 50,
                background: HelperFunctions.getColor(text)!) : null,
        shape: isColor ? CircleBorder() : null,
        labelPadding: isColor ? EdgeInsets.all(0) : null,
        padding: isColor ? EdgeInsets.all(0) : null,
        // selectedColor: Colors.green,
        backgroundColor: isColor ? HelperFunctions.getColor(text) : null,
      ),
    );
  }
}
