import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/models/simple_pokemon.dart';
import 'package:pokedex/widgets/fade_in_image_widget.dart';

import '../bloc/search/search_bloc.dart';
import '../helpers/helpers.dart';

class PokemonSearchCard extends StatelessWidget {
  final SimplePokemon pokemon;
  const PokemonSearchCard({super.key, required this.pokemon});

  double getFontSize(int length) {
    if (length >= 15) {
      return 22.5;
    } else {
      return 30;
    }
  }

  @override
  Widget build(BuildContext context) {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    return GestureDetector(
      onTap: (() {
        searchBloc.add(AddPokemonsToHistorial(pokemon));
        Navigator.pushNamed(context, "pokemon", arguments: pokemon);
      }),
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: fromStringToColor(pokemon.color!),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                    width: 100,
                    height: 100,
                    child: FadeInImageCustom(
                      url: pokemon.picture!,
                    )),
                Text(
                  pokemon.name!,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: getFontSize(pokemon.name?.length ?? 0)),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: fromStringToColor(pokemon.color!)!),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              height: 100,
              width: 80,
              child: Center(
                child: Text(
                  '#${pokemon.id}',
                  style: TextStyle(
                      color: fromStringToColor(pokemon.color!), fontSize: 22.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
