class DataAvailModels {
  final AvailModels availModels;

  DataAvailModels({required this.availModels});

  factory DataAvailModels.fromJson(Map<String, dynamic> json) =>
      DataAvailModels(availModels: AvailModels.fromJson(json['data']));
}

class AvailModels {
  final int totalPage;
  final int currentPage;
  final List<ListAvailModels>? list;

  AvailModels(
      {required this.totalPage, required this.currentPage, required this.list});
  factory AvailModels.fromJson(Map<String, dynamic> json) => AvailModels(
      totalPage: json['total_page'],
      currentPage: json['current_page'],
      list: json['packages'] == null
          ? null
          : (json['packages'] as List)
              .map((i) => ListAvailModels.fromJson(i))
              .toList());
}

class ListAvailModels {
  final String name;
  final int price;
  final List<dynamic> images;
  final List<LocationListAvailModels>? locationList;

  ListAvailModels(
      {required this.name,
      required this.price,
      required this.images,
      required this.locationList});

  factory ListAvailModels.fromJson(Map<String, dynamic> json) =>
      ListAvailModels(
          name: json['name'],
          price: json['price'],
          images: json['images'],
          locationList: List.from(json['destinations'])
              .map((e) => LocationListAvailModels.fromJson(e))
              .toList());
}

class LocationListAvailModels {
  final String name;

  LocationListAvailModels({required this.name});
  factory LocationListAvailModels.fromJson(Map<String, dynamic> json) =>
      LocationListAvailModels(name: json['name']);
}
