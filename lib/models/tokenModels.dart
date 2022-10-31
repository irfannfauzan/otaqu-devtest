class TokenModels {
  final String message;
  final DataTokenModels data;

  TokenModels({required this.message, required this.data});

  factory TokenModels.fromJson(Map<String, dynamic> json) => TokenModels(
      message: json['message'], data: DataTokenModels.fromJson(json['data']));
}

class DataTokenModels {
  final String accesToken;

  DataTokenModels({required this.accesToken});

  factory DataTokenModels.fromJson(final json) =>
      DataTokenModels(accesToken: json['access_token']);
}
