import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/global/environment.dart';
import 'package:pokedex/models/pokemon_detail_response.dart';
import 'package:pokedex/models/pokemons_response.dart';
import 'package:pokedex/models/simple_pokemon.dart';

import '../helpers/helpers.dart';

class PokedexService with ChangeNotifier {
  Future<List<Result>?> getPokemons(int offset, int limit) async {
    try {
      final resp = await http.get(
          Uri.parse('${Enviroment.apiUrl}/pokemon?offset=$offset&limit=$limit'),
          headers: {
            'Content-Type': 'application/json',
          });
      if (resp.statusCode == 200) {
        final pokemonsResponse = pokemonsReponseFromJson(resp.body);
        return pokemonsResponse.results!;
      }
    } catch (e) {
      return [];
    }
    return null;
  }

  Future<PokemonDetailResponse?> getPokemonDetail(int id) async {
    try {
      final resp = await http
          .get(Uri.parse('${Enviroment.apiUrl}/pokemon/$id'), headers: {
        'Content-Type': 'application/json',
      });
      if (resp.statusCode == 200) {
        final pokemonDetailResponse = pokemonDetailResponseFromJson(resp.body);
        return pokemonDetailResponse;
      }
    } catch (e) {
      return null;
    }
    return null;
  }

  Future<List<Result>?> getPokemonsForSearch() async {
    try {
      final resp = await http
          .get(Uri.parse('${Enviroment.apiUrl}/pokemon/?limit=1200'), headers: {
        'Content-Type': 'application/json',
      });
      if (resp.statusCode == 200) {
        final pokemonsResponse = pokemonsReponseFromJson(resp.body);
        return pokemonsResponse.results!;
      }
    } catch (e) {
      return [];
    }
    return null;
  }

  Future<List<SimplePokemon>> getResultsByQuery(
      String query, List<Result> data) async {
    if (query.isEmpty) return [];
    List<Result> dataFiltered =
        data.where((element) => element.name!.contains(query)).toList();
    List<SimplePokemon> newListPokemons = await makePokemonsList(dataFiltered);

    return newListPokemons;
  }
}
