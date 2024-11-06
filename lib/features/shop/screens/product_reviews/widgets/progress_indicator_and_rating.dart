import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utils.dart';

class RattingProgressIndicator extends StatelessWidget {
  const RattingProgressIndicator({
    super.key, required this.text, required this.value,
  });

  final String text;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text(text, style: Theme.of(context).textTheme.bodyMedium,)),
        Expanded(
          child: SizedBox(
            width: DeviceUtils.getScreenWith(context) * 0.8,
            child: LinearProgressIndicator(
              value: value,
              minHeight: 11,
              backgroundColor: ColorApp.grey82,
              borderRadius: BorderRadius.circular(7),
              valueColor: const AlwaysStoppedAnimation(ColorApp.blue02),
            ),
          ),
        )
      ],
    );
  }
}