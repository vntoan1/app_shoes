import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../utils/constants/colors.dart';
import '../curved_edges/custom_edges_widget.dart';
import 'circular_container.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key, required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      chid: Container(
        color: ColorApp.blue02,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -250,
              child: CircularContainer(background: Colors.white.withOpacity(0.1),),
            ),
            Positioned(
              top: 100,
              right: -300,
              child: CircularContainer(background: Colors.white.withOpacity(0.1),),
            ),
            child,
          ],
        ),
      ),
    );
  }
}