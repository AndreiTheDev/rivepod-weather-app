import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DecoratedInputBorder extends InputBorder {
  DecoratedInputBorder({
    required this.child,
    required this.shadow,
  }) : super(borderSide: child.borderSide);

  final InputBorder child;

  final BoxShadow shadow;

  @override
  bool get isOutline => child.isOutline;

  @override
  Path getInnerPath(final Rect rect, {final TextDirection? textDirection}) =>
      child.getInnerPath(rect, textDirection: textDirection);

  @override
  Path getOuterPath(final Rect rect, {final TextDirection? textDirection}) =>
      child.getOuterPath(rect, textDirection: textDirection);

  @override
  EdgeInsetsGeometry get dimensions => child.dimensions;

  @override
  InputBorder copyWith({
    final BorderSide? borderSide,
    final InputBorder? child,
    final BoxShadow? shadow,
    final bool? isOutline,
  }) {
    return DecoratedInputBorder(
      child: (child ?? this.child).copyWith(borderSide: borderSide),
      shadow: shadow ?? this.shadow,
    );
  }

  @override
  ShapeBorder scale(final double t) {
    final ShapeBorder scalledChild = child.scale(t);

    return DecoratedInputBorder(
      child: scalledChild is InputBorder ? scalledChild : child,
      shadow: BoxShadow.lerp(null, shadow, t)!,
    );
  }

  @override
  void paint(
    final Canvas canvas,
    final Rect rect, {
    final double? gapStart,
    final double gapExtent = 0.0,
    final double gapPercentage = 0.0,
    final TextDirection? textDirection,
  }) {
    final Path clipPath = Path()
      ..addRect(const Rect.fromLTWH(-5000, -5000, 10000, 10000))
      ..addPath(getInnerPath(rect), Offset.zero)
      ..fillType = PathFillType.evenOdd;
    canvas.clipPath(clipPath);

    final Paint paint = shadow.toPaint();
    final Rect bounds = rect.shift(shadow.offset).inflate(shadow.spreadRadius);

    canvas.drawPath(getOuterPath(bounds), paint);

    child.paint(
      canvas,
      rect,
      gapStart: gapStart,
      gapExtent: gapExtent,
      gapPercentage: gapPercentage,
      textDirection: textDirection,
    );
  }

  @override
  bool operator ==(final Object other) {
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is DecoratedInputBorder &&
        other.borderSide == borderSide &&
        other.child == child &&
        other.shadow == shadow;
  }

  @override
  int get hashCode => Object.hash(borderSide, child, shadow);

  @override
  String toString() {
    return '''${objectRuntimeType(this, 'DecoratedInputBorder')}($borderSide, $shadow, $child)''';
  }
}
