import 'package:flutter/material.dart';
import 'package:transformable_list_view/transformable_list_view.dart';

Matrix4 getTransformMatrix(TransformableListItem item) {
  /// final scale of child when the animation is completed
  const endScaleBound = 0.3;

  /// 0 when animation completed and [scale] == [endScaleBound]
  /// 1 when animation starts and [scale] == 1
  final animationProgress = item.visibleExtent / item.size.height;

  /// result matrix
  final paintTransform = Matrix4.identity();

  /// animate only if item is on edge
  if (item.position != TransformableListItemPosition.middle) {
    final scale = endScaleBound + ((1 - endScaleBound) * animationProgress);

    paintTransform
      ..translate(item.size.width / 2)
      ..scale(scale)
      ..translate(-item.size.width / 2);
  }

  return paintTransform;
}