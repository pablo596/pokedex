import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/models/simple_pokemon.dart';
import 'package:pokedex/widgets/pokemon_search_card_widget.dart';

import '../bloc/search/search_bloc.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate() : super(searchFieldLabel: "Search a Pokemon by name");

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
          query = '';
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    searchBloc.add(OnNewPokemonsFoundEvent([]));
    searchBloc.getPokemonsByQuery(query);
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state.results.length == 0) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.grey),
          );
        } else {
          return ListView.builder(
            itemCount: state.results.length,
            itemBuilder: (BuildContext context, int index) {
              SimplePokemon pokemon = state.results[index];
              return PokemonSearchCard(pokemon: pokemon);
            },
          );
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.all(10),
                  child: state.history.length > 0
                      ? const Text(
                          "Recent searches",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        )
                      : Column(
                          children: const [
                            Icon(Icons.arrow_upward),
                            Text(
                              "Search a Pokemon by name",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            )
                          ],
                        )),
              for (SimplePokemon poke in state.history)
                PokemonSearchCard(pokemon: poke)
            ],
          ),
        );
      },
    );
  }
}
