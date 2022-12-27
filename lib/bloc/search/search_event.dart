part of 'search_bloc.dart';

abstract class SearchEvent {}

class InitialPokemonsList extends SearchEvent {
  final List<Result> initialList;
  InitialPokemonsList(this.initialList);
}

class OnNewPokemonsFoundEvent extends SearchEvent {
  final List<SimplePokemon> pokemons;
  OnNewPokemonsFoundEvent(this.pokemons);
}

class AddPokemonsToResults extends SearchEvent {
  final List<SimplePokemon> newHistorial;
  AddPokemonsToResults(this.newHistorial);
}

class AddPokemonsToHistorial extends SearchEvent {
  final SimplePokemon newHistorial;
  AddPokemonsToHistorial(this.newHistorial);
}
