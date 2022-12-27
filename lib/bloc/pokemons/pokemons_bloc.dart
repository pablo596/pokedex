import 'package:bloc/bloc.dart';
import 'package:pokedex/models/simple_pokemon.dart';

part 'pokemons_event.dart';
part 'pokemons_state.dart';

class PokemonsBloc extends Bloc<PokemonsEvent, PokemonsState> {
  PokemonsBloc() : super(const PokemonsInitial()) {
    on<AddPokemonsToList>((event, emit) {
      emit(state
          .copyWith(pokemonList: [...?state.pokemonsList, ...event.pokemons]));
    });

    on<OnLoadMoreInitialList>((event, emit) =>
        emit(state.copyWith(isLoadingInitial: event.isLoadingInitial)));

    on<OnLoadMoreDataList>((event, emit) =>
        emit(state.copyWith(isLoadingData: event.isLoadingData)));
  }
}
