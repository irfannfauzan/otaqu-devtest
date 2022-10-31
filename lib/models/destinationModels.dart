class DestinationModels {
  final int destinationId;
  final String name;

  DestinationModels({required this.destinationId, required this.name});
  factory DestinationModels.fromJson(Map<String, dynamic> json) =>
      DestinationModels(
          destinationId: json['destination_id'], name: json['name']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['destination_id'] = destinationId;
    data['name'] = name;
    return data;
  }
}
