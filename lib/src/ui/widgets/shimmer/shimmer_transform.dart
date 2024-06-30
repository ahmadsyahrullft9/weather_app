part of 'shimmer.dart';

class ShimmerTransform extends GradientTransform {
  final double slidePercent;

  const ShimmerTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}
