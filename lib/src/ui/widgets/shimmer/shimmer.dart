import 'package:flutter/material.dart';

part 'shimmer_transform.dart';
part 'shimmer_loading.dart';
part 'shimmer_config.dart';

class Shimmer extends StatefulWidget {
  static ShimmerState? of(BuildContext context) {
    final result = context.findAncestorStateOfType<ShimmerState>();
    return result;
  }

  final LinearGradient linearGradient;
  final Widget? child;

  const Shimmer({super.key, required this.linearGradient, this.child});

  @override
  State<Shimmer> createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  // code-excerpt-closing-bracket
  LinearGradient get gradient => LinearGradient(
        colors: widget.linearGradient.colors,
        stops: widget.linearGradient.stops,
        begin: widget.linearGradient.begin,
        end: widget.linearGradient.end,
        transform: ShimmerTransform(slidePercent: _shimmerController.value),
      );

  bool get isSized {
    final render = context.findRenderObject();
    if (render is RenderBox) {
      return (render).hasSize;
    }
    return false;
  }

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}
