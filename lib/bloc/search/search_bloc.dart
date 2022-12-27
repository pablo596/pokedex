import 'package:bloc/bloc.dart';
import 'package:pokedex/models/pokemons_response.dart';
import 'package:pokedex/models/simple_pokemon.dart';
import 'package:pokedex/service/pokedex_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<InitialPokemonsList>(((event, emit) =>
        emit(state.copyWith(allPokemons: event.initialList))));
    on<OnNewPokemonsFoundEvent>(
        (event, emit) => emit(state.copyWith(results: event.pokemons)));
    on<AddPokemonsToResults>((event, emit) {
      emit(state.copyWith(results: event.newHistorial));
    });
    on<AddPokemonsToHistorial>((event, emit) {
      if (state.history.length > 0) {
        for (var poke in state.history) {
          if (poke.id == event.newHistorial.id) {
            return;
          }
        }
      }

      emit(state.copyWith(history: [...state.history, event.newHistorial]));
    });
  }

  Future getPokemonsByQuery(String query) async {
    PokedexService pokedexService = PokedexService();
    final newPokemons =
        await pokedexService.getResultsByQuery(query, state.allPokemons);
    add(OnNewPokemonsFoundEvent(newPokemons));
  }
}
