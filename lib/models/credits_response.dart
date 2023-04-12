// To parse this JSON data, do
//
//     final creditsResponse = creditsResponseFromJson(jsonString);

import 'dart:convert';

class CreditsResponse {
  CreditsResponse({
    required this.id,
    required this.cast,
    required this.crew,
  });

  int id;
  List<Cast> cast;
  List<Cast> crew;

  factory CreditsResponse.fromRawJson(String str) =>
      CreditsResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toRawJson());

  factory CreditsResponse.fromJson(Map<String, dynamic> json) =>
      CreditsResponse(
        id: json["id"],
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromRawJson(x))),
        crew: List<Cast>.from(json["crew"].map((x) => Cast.fromRawJson(x))),
      );
}

class Cast {
  Cast({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
    required this.department,
    required this.job,
  });

  bool adult;
  int gender;
  int id;
  Department knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String? profilePath;
  int? castId;
  String? character;
  String creditId;
  int? order;
  Department? department;
  String? job;

  get fullProfilePath {
    if (this.profilePath != null) {
      return 'https://image.tmdb.org/t/p/w500${this.profilePath}';
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  factory Cast.fromRawJson(String str) => Cast.fromRawJson(json.decode(str));
}

enum Department {
  ACTING,
  PRODUCTION,
  EDITING,
  WRITING,
  SOUND,
  DIRECTING,
  CAMERA,
  COSTUME_MAKE_UP,
  ART,
  CREW,
  VISUAL_EFFECTS,
  LIGHTING
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
