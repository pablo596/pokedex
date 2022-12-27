part of 'pokemons_bloc.dart';

class PokemonsState {
  final List<SimplePokemon>? pokemonsList;
  final bool? isLoadingData;
  final bool? isLoadingInitial;

  const PokemonsState(
      {this.pokemonsList, this.isLoadingData, this.isLoadingInitial});

  PokemonsState copyWith({
    List<SimplePokemon>? pokemonList,
    bool? isLoadingInitial,
    bool? isLoadingData,
  }) =>
      PokemonsState(
        pokemonsList: pokemonList ?? this.pokemonsList,
        isLoadingInitial: isLoadingInitial ?? this.isLoadingInitial,
        isLoadingData: isLoadingData ?? this.isLoadingData,
      );
}

class PokemonsInitial extends PokemonsState {
  const PokemonsInitial()
      : super(pokemonsList: null, isLoadingData: false, isLoadingInitial: true);
}

class PokemonsSetList extends PokemonsState {
  final List<SimplePokemon> newPokemonsList;

  const PokemonsSetList(this.newPokemonsList)
      : super(pokemonsList: newPokemonsList);
}

class PokemonsLoadMoreList extends PokemonsState {
  final bool isLoading;

  const PokemonsLoadMoreList(this.isLoading) : super(isLoadingData: isLoading);
}

class PokemonsLoadInitialList extends PokemonsState {
  final bool isLoading;

  const PokemonsLoadInitialList(this.isLoading)
      : super(isLoadingInitial: isLoading);
}
