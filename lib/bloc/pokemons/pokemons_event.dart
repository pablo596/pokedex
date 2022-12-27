part of 'pokemons_bloc.dart';

abstract class PokemonsEvent {}

class AddPokemonsToList extends PokemonsEvent {
  final List<SimplePokemon> pokemons;
  AddPokemonsToList(this.pokemons);
}

class OnLoadMoreInitialList extends PokemonsEvent {
  final bool isLoadingInitial;

  OnLoadMoreInitialList(this.isLoadingInitial);
}

class OnLoadMoreDataList extends PokemonsEvent {
  final bool isLoadingData;

  OnLoadMoreDataList(this.isLoadingData);
}
