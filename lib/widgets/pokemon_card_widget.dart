import 'package:flutter/material.dart';
import 'package:pokedex/models/simple_pokemon.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/widgets/fade_in_image_widget.dart';

import '../helpers/helpers.dart';

class PokemonCard extends StatefulWidget {
  final SimplePokemon pokemon;
  const PokemonCard({super.key, required this.pokemon});

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  PaletteGenerator? paletteGenerator;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() =>
          Navigator.pushNamed(context, "pokemon", arguments: widget.pokemon)),
      child: Stack(children: [
        Center(
          child: Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                  color: fromStringToColor(widget.pokemon.color!),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(3, 3),
                      spreadRadius: -3,
                      blurRadius: 5,
                      color: Color.fromRGBO(0, 0, 0, .5),
                    )
                  ]),
              width: 160,
              height: 120,
              child: Stack(children: [
                Positioned(
                  top: 20,
                  left: 10,
                  child: Text(
                    '${widget.pokemon.name!}\n#${widget.pokemon.id}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -20,
                  right: -20,
                  child: Image.asset(
                    "assets/pokebola-blanca.png",
                    width: 100,
                    opacity: const AlwaysStoppedAnimation(.5),
                  ),
                ),
              ])),
        ),
        Positioned(
          bottom: -5,
          right: -1,
          child: SizedBox(
              width: 120,
              height: 120,
              child: FadeInImageCustom(
                url: widget.pokemon.picture!,
              )),
        ),
      ]),
    );
  }
}
