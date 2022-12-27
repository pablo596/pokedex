import 'dart:convert';

PokemonsReponse pokemonsReponseFromJson(String str) =>
    PokemonsReponse.fromJson(json.decode(str));

String pokemonsReponseToJson(PokemonsReponse data) =>
    json.encode(data.toJson());

class PokemonsReponse {
  PokemonsReponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;

  factory PokemonsReponse.fromJson(Map<String, dynamic> json) =>
      PokemonsReponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
