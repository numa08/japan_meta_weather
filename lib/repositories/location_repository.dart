import 'dart:async';

class LocationRepository {
  Future<List<String>> getLocations() async {
    return [
      'Fukuoka',
      'Hiroshima',
      'Kawasaki',
      'Kitakyushu',
      'Kobe',
      'Kyoto',
      'Nagoya',
      'Osaka',
      'Saitama',
      'Sapporo',
      'Sendai',
      'Tokyo',
      'Yokohama'
    ];
  }
}
