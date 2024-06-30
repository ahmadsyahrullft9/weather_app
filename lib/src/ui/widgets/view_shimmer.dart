import 'package:flutter/material.dart';
import 'package:weather_app/src/ui/widgets/shimmer/shimmer.dart';

class ViewShimmer extends StatelessWidget {
  const ViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
          minWidth: double.maxFinite, minHeight: double.maxFinite),
      child: Material(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Shimmer(
          linearGradient: shimmerGradient,
          child: ShimmerLoading(
            isLoading: true,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: double.maxFinite,
                      height: 156.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Divider(color: Colors.transparent),
                    SizedBox(
                      width: double.maxFinite,
                      height: 76.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Divider(color: Colors.transparent),
                    SizedBox(
                      width: double.maxFinite,
                      height: 36.0,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const Divider(
                      color: Colors.transparent,
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
