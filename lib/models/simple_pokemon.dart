import 'package:flutter/material.dart';

class SimplePokemon {
  int? id;
  String? name;
  String? picture;
  String? color;

  SimplePokemon({
    this.id,
    this.name,
    this.picture,
    this.color,
  });

  SimplePokemon copyWith({
    int? id,
    String? name,
    String? picture,
    String? color,
  }) =>
      SimplePokemon(
        id: id ?? this.id,
        name: name ?? this.name,
        picture: picture ?? this.picture,
        color: color ?? this.color,
      );
}
