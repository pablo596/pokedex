part of 'search_bloc.dart';

class SearchState {
  final List<SimplePokemon> history;
  final List<SimplePokemon> results;
  final List<Result> allPokemons;

  const SearchState({
    this.history = const [],
    this.results = const [],
    this.allPokemons = const [],
  });

  SearchState copyWith(
          {List<SimplePokemon>? history,
          List<Result>? allPokemons,
          List<SimplePokemon>? results}) =>
      SearchState(
        allPokemons: allPokemons ?? this.allPokemons,
        results: results ?? this.results,
        history: history ?? this.history,
      );
}

class SearchInitial extends SearchState {
  SearchInitial() : super(allPokemons: [], history: [], results: []);
}

class SearchSetResults extends SearchState {
  final List<SimplePokemon> newPokemonsList;

  SearchSetResults(this.newPokemonsList) : super(results: newPokemonsList);
}

class SearchSetHistory extends SearchState {
  final List<SimplePokemon> newPokemonsList;

  SearchSetHistory(this.newPokemonsList) : super(history: newPokemonsList);
}
