import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/widgets/pokemon_card_widget.dart';

import '../bloc/pokemons/pokemons_bloc.dart';
import '../models/simple_pokemon.dart';

class HomeListPokemons extends StatefulWidget {
  final dynamic loadPokemons;
  const HomeListPokemons({
    super.key,
    required this.loadPokemons,
  });

  @override
  State<HomeListPokemons> createState() => _HomeListPokemonsState();
}

class _HomeListPokemonsState extends State<HomeListPokemons> {
  @override
  Widget build(BuildContext context) {
    final pokemonsBloc = BlocProvider.of<PokemonsBloc>(context);
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<PokemonsBloc, PokemonsState>(
      builder: (context, state) {
        List<SimplePokemon>? pokemons = state.pokemonsList;
        int pokemonsLength = pokemons?.length ?? 0;
        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: -100,
              right: -100,
              child: Image(
                color: Colors.white.withOpacity(0.2),
                colorBlendMode: BlendMode.modulate,
                image: const AssetImage(
                  'assets/pokebola.png',
                ),
                width: 300,
                height: 300,
              ),
            ),
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      Flexible(
                        child: SizedBox(
                          height: double.infinity,
                          child: !state.isLoadingInitial!
                              ? NotificationListener<ScrollNotification>(
                                  onNotification: (scrollNotification) {
                                    if (scrollNotification
                                            is ScrollEndNotification &&
                                        scrollNotification.metrics.pixels ==
                                            scrollNotification
                                                .metrics.maxScrollExtent) {
                                      pokemonsBloc
                                          .add(OnLoadMoreDataList(true));
                                      widget.loadPokemons(pokemonsLength);
                                    }

                                    return true;
                                  },
                                  child: GridView.builder(
                                    physics: BouncingScrollPhysics(),
                                    padding: const EdgeInsets.only(top: 100),
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 1.3,
                                      crossAxisCount: 2,
                                    ),
                                    itemCount: pokemonsLength,
                                    itemBuilder: (BuildContext context, int i) {
                                      return PokemonCard(pokemon: pokemons![i]);
                                    },
                                  ),
                                )
                              : const Center(
                                  child: CircularProgressIndicator(
                                  color: Colors.grey,
                                )),
                        ),
                      ),
                      if (state.isLoadingData!)
                        Column(
                          children: const [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Colors.grey,
                              )),
                            ),
                            SizedBox(
                              height: 100,
                            )
                          ],
                        )
                      else
                        Container(),
                    ],
                  ),
                ),
                SafeArea(
                  child: Container(
                    width: size.width * .5,
                    height: 80,
                    decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(50)),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(3, 3),
                            spreadRadius: -3,
                            blurRadius: 20,
                            color: Color.fromRGBO(0, 0, 0, .4),
                          )
                        ]),
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 20,
                    ),
                    child: Center(
                      child: Text(
                        'Pokedex',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: size.height * .0425,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
