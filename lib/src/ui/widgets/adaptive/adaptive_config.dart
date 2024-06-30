import 'config.dart';

class AdaptiveConfig {
  final double screenWidth;
  final double screenHeight;

  AdaptiveConfig({
    required this.screenWidth,
    required this.screenHeight,
  });

  ScreenMode get screenMode {
    final sectionCount = this.sectionCount();
    if (sectionCount >= 3) {
      return ScreenMode.large;
    } else if (sectionCount >= 2) {
      return ScreenMode.medium;
    }
    return ScreenMode.small;
  }

  double sectionCount() {
    if (screenWidth <= widthOfSection) return 1;
    final mod = screenWidth % widthOfSection;
    final fixWidth = screenWidth - mod;
    final result = fixWidth / widthOfSection;
    if (mod > (0.75 * widthOfSection)) return result + 1;
    return result;
  }

  double crossAxisCount(num itemWidth) {
    final mod = screenWidth % itemWidth;
    final fixWidth = screenWidth - mod;
    final result = fixWidth / itemWidth;
    if (mod > (0.5 * itemWidth)) return result + 1;
    return result;
  }

  double aspectRatio({required num itemWidth, required num itemHeight}) {
    return ((itemWidth / screenWidth) * 100) /
        ((itemHeight / screenWidth) * 100);
  }
}
