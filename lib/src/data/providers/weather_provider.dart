import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:weather_app/src/config/app_data.dart';
import 'package:weather_app/src/data/models/weather_item.dart';
import 'package:weather_app/src/data/repositories/weather_repository.dart';

final weatherRepoProvider =
    Provider<WeatherRepository>((ref) => WeatherRepository());

class WeatherDataNotifier extends ChangeNotifier {
  static final provider = ChangeNotifierProvider.autoDispose
      .family<WeatherDataNotifier, String>((ref, selectedTab) {
    final repo = ref.watch(weatherRepoProvider);
    return WeatherDataNotifier(repo, selectedTab: selectedTab);
  });

  final String selectedTab;
  final WeatherRepository _repo;

  bool isLoading = false;
  final List<WeatherItem> dataList = [];

  WeatherDataNotifier(WeatherRepository repo, {required this.selectedTab})
      : _repo = repo {
    loadData();
  }

  void loadData() async {
    isLoading = true;
    dataList
      ..clear()
      ..addAll(cities.map((e) => WeatherItem(city: e)));
    notifyListeners();

    for (var i = 0; i < dataList.length; i++) {
      final item = dataList[i];
      /* 
      compute(_fetchWeather, item).then((value) {
        dataList[i] = value;
        notifyListeners();
      }); 
      */
      dataList[i] = await _fetchWeather(item);
    }

    dataList.sort((a, b) {
      final findTabA = a.forecast?.findItemForecast(selectedTab);
      final findTabB = b.forecast?.findItemForecast(selectedTab);
      return (findTabB?.length ?? 0).compareTo((findTabA?.length ?? 0));
    });
    isLoading = false;
    notifyListeners();
  }

  Future<WeatherItem> _fetchWeather(WeatherItem e) async {
    final weatherResult = await _repo.getWeather(e.city?.name ?? "");
    final weather = weatherResult.fold((l) => null, (r) => r);

    final forecastResult = await _repo.getForecast(e.city?.id ?? 0);
    final forecast = forecastResult.fold((l) => null, (r) => r);
    final WeatherItem newItem =
        e.copyWith(weather: weather, forecast: forecast);
    return newItem;
  }
}
