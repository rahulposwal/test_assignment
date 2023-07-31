import 'dart:convert';

ModelApiResponse modelApiResponseFromJson(String str) => ModelApiResponse.fromJson(json.decode(str));

String modelApiResponseToJson(ModelApiResponse data) => json.encode(data.toJson());

class ModelApiResponse {
  String joke;

  ModelApiResponse({
    required this.joke,
  });

  factory ModelApiResponse.fromJson(Map<String, dynamic> json) => ModelApiResponse(
    joke: json["joke"],
  );

  Map<String, dynamic> toJson() => {
    "joke": joke,
  };
}