import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/search/search_bloc.dart';
import 'package:pokedex/models/pokemons_response.dart';
import 'package:pokedex/service/pokedex_service.dart';
import 'package:provider/provider.dart';

import '../models/simple_pokemon.dart';
import '../widgets/custom_search_delegate.dart';
import '../widgets/pokemon_search_card_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  PokedexService? pokedexService;
  SearchBloc? searchBloc;
  @override
  void initState() {
    super.initState();
    pokedexService = Provider.of<PokedexService>(context, listen: false);
    searchBloc = BlocProvider.of<SearchBloc>(
      context,
    );
    fetchPokemos();
  }

  void fetchPokemos() async {
    List<Result>? pokemons = await pokedexService?.getPokemonsForSearch();

    searchBloc?.add(InitialPokemonsList(pokemons!));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                showSearch(context: context, delegate: CustomSearchDelegate());
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: const [
                      BoxShadow(
                        offset: Offset(3, 3),
                        spreadRadius: -3,
                        blurRadius: 5,
                        color: Color.fromRGBO(0, 0, 0, 0.3),
                      )
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Search a Pokemon by name"),
                    Icon(Icons.search),
                  ],
                ),
              ),
            ),
            BlocBuilder<SearchBloc, SearchState>(
              builder: (context, state) {
                return Column(
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
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )),
                    for (SimplePokemon poke in state.history)
                      PokemonSearchCard(pokemon: poke)
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
