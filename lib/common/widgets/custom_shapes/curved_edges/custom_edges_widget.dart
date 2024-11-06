import 'package:flutter/cupertino.dart';

import 'custom_edges.dart';

class CurvedEdgeWidget extends StatelessWidget {
  const CurvedEdgeWidget({
    super.key, this.chid,
  });

  final Widget? chid;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCurvedEdges(),
      child: chid,
    );
  }
}