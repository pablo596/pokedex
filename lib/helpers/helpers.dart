import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/models/simple_pokemon.dart';

import '../models/pokemons_response.dart';

Color? fromStringToColor(String color) {
  String colorString = color;
  String valueString = colorString.split('(0x')[1].split(')')[0];
  int value = int.parse(valueString, radix: 16);
  Color otherColor = Color(value);
  return otherColor;
}

Future<Color?> getImagePalette(Image imageProvider) async {
  try {
    PaletteGenerator paletteGenerator =
        await PaletteGenerator.fromImageProvider(imageProvider.image);
    return paletteGenerator.dominantColor!.color;
  } catch (e) {
    return Colors.red;
  }
}

Future<List<SimplePokemon>> makePokemonsList(List<Result>? pokemons) async {
  List<SimplePokemon> newListPokemons =
      List.from(await Future.wait(pokemons!.map((poke) async {
    List<String>? urlParts = poke.url?.split('/');
    String id = urlParts![urlParts.length - 2];
    String picture =
        'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
    Color? color = await getImagePalette(Image.network(picture));
    return SimplePokemon(
        id: int.parse(id),
        name: poke.name,
        picture: picture,
        color: color.toString());
  })));
  return newListPokemons;
}
