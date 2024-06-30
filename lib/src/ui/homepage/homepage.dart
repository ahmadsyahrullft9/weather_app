import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/src/config/app_color.dart';
import 'package:weather_app/src/data/models/weather_item.dart';
import 'package:weather_app/src/data/providers/weather_provider.dart';
import 'package:weather_app/src/ui/widgets/adaptive/adaptive.dart';
import 'package:weather_app/src/ui/widgets/view_shimmer.dart';

part 'homepage_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AdaptiveConfig? _adaptiveConfig;

  TextStyle get _tabTitleTextStyle => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
      );

  TextStyle get _tabSelectedTitleTextStyle => const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      );
  TextStyle get _weatherNumbTextStyle => const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        color: primaryTextColor,
      );
  TextStyle get _weatherTitleTextStyle => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: primaryTextColor,
      );
  TextStyle get _weatherSubTitleTextStyle => const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: primaryTextColor,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: AdaptiveLayout(builder: (context, config) {
        _adaptiveConfig = config;
        final crossAxisCount =
            (_adaptiveConfig?.crossAxisCount(411) ?? 2).toInt();
        final gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 12 / 3,
        );
        return Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Consumer(
            builder: (context, ref, _) {
              final selectedTab = ref.watch(selectedTabProvider);
              final state =
                  ref.watch(WeatherDataNotifier.provider(selectedTab));
              if (state.isLoading) {
                return const ViewShimmer();
              }
              return GridView.builder(
                gridDelegate: gridDelegate,
                itemCount: state.dataList.length,
                itemBuilder: (context, index) {
                  final item = state.dataList[index];
                  return _weatherItem(item, selectedTab);
                },
              );
            },
          ),
        );
      }),
    );
  }

  _weatherItem(WeatherItem item, String selectedTab) {
    final findByTab = item.forecast?.findItemForecast(selectedTab);
    return Material(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: Colors.grey, width: 0.256),
        borderRadius: BorderRadius.circular(4),
      ),
      elevation: 0,
      child: Center(
        child: ListTile(
          leading: SizedBox(
            width: 52,
            child: Text((findByTab?.length ?? 0).toString(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: _weatherNumbTextStyle),
          ),
          title: Text(item.city?.name ?? "-",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: _weatherTitleTextStyle),
          subtitle: Row(
            children: {
              "min": item.weather?.main?.tempMin == null
                  ? "-"
                  : "${_kelvinToCelsius(item.weather?.main?.tempMin ?? 0).toStringAsFixed(2)}℃",
              "max": item.weather?.main?.tempMax == null
                  ? "-"
                  : "${_kelvinToCelsius(item.weather?.main?.tempMax ?? 0).toStringAsFixed(2)}℃",
            }
                .entries
                .map(
                  (e) => Text(
                    "${e.key} : ${e.value}",
                    style: _weatherSubTitleTextStyle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
                .map((e) => Expanded(child: e))
                .toList(),
          ),
          trailing: SizedBox(
            width: 52,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  item.weather?.main?.temp == null
                      ? "-"
                      : "${_kelvinToCelsius(item.weather?.main?.temp ?? 0).toStringAsFixed(2)}℃",
                  style: _weatherSubTitleTextStyle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                SizedBox(
                  width: 32,
                  height: 32,
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://openweathermap.org/img/wn/${item.weather?.weather?.firstOrNull?.icon}@2x.png",
                    fit: BoxFit.contain,
                    placeholder: (_, url) => const SizedBox(),
                    errorWidget: (_, url, err) => const SizedBox(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildAppBar() {
    return PreferredSize(
      preferredSize:
          Size.fromHeight(Theme.of(context).appBarTheme.toolbarHeight ?? 82),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Consumer(builder: (context, ref, _) {
              final selectedTab = ref.watch(selectedTabProvider);
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: ["Clear", "Clouds", "Rain", "Snow"]
                    .map(
                      (e) {
                        final selected =
                            e.toLowerCase() == selectedTab?.toLowerCase();
                        return InkWell(
                          onTap: () =>
                              ref.read(selectedTabProvider.notifier).state = e,
                          child: Material(
                            color: selected ? Colors.blue : Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: const BorderSide(
                                    width: 0.56, color: Colors.grey)),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              child: Text(
                                e,
                                style: selected
                                    ? _tabSelectedTitleTextStyle
                                    : _tabTitleTextStyle,
                              ),
                            ),
                          ),
                        );
                      },
                    )
                    .map((e) => Padding(
                        padding: const EdgeInsets.only(right: 8), child: e))
                    .toList(),
              );
            }),
          ),
        ),
      ),
    );
  }

  double _kelvinToCelsius(double kelvin) {
    return kelvin - 273.15;
  }
}
