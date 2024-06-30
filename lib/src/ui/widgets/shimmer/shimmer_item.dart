import 'package:flutter/material.dart';
import 'shimmer.dart';

class ShimmerItem extends StatelessWidget {
  final double? maxHeight;

  const ShimmerItem({super.key, this.maxHeight});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Shimmer(
        linearGradient: shimmerGradient,
        child: SizedBox(
          width: double.maxFinite,
          height: maxHeight ?? 88.0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ShimmerLoading(
              isLoading: true,
              child: Material(
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
