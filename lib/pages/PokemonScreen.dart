import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokedex/helpers/helpers.dart';
import 'package:pokedex/models/pokemon_detail_response.dart';
import 'package:pokedex/models/simple_pokemon.dart';
import 'package:pokedex/widgets/fade_in_image_widget.dart';
import 'package:pokedex/widgets/section_detail_widget.dart';
import 'package:provider/provider.dart';

import '../service/pokedex_service.dart';

class PokemonPage extends StatefulWidget {
  const PokemonPage({super.key});

  @override
  State<PokemonPage> createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  PokedexService? pokedexService;
  SimplePokemon? pokemon;
  @override
  void initState() {
    super.initState();
    pokedexService = Provider.of<PokedexService>(context, listen: false);
    Future.delayed(Duration.zero, () {
      pokemon = ModalRoute.of(context)!.settings.arguments as SimplePokemon;
      setState(() {});
    });
  }

  Future<PokemonDetailResponse?> loadDetail(int id) async {
    return await pokedexService?.getPokemonDetail(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor:
              fromStringToColor(pokemon?.color ?? "Color(0xFF9E9E9E)"),
          elevation: 0,
          toolbarHeight: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor:
                fromStringToColor(pokemon?.color ?? "Color(0xFF9E9E9E)"),
          ),
        ),
        body: Stack(children: [
          SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: FutureBuilder(
              future: loadDetail(pokemon?.id ?? 0),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: fromStringToColor(
                        pokemon?.color ?? "Color(0xFF9E9E9E)"),
                  ));
                }
                PokemonDetailResponse pokeDetail = snapshot.data;
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 380),
                          SectionDetail(
                              label: "Types",
                              type: "types",
                              data: pokeDetail.types!,
                              color: fromStringToColor(
                                  pokemon?.color ?? "Color(0xFF9E9E9E)")!),
                          SectionDetail(
                              label: "Weight",
                              type: "weight",
                              data: '${pokeDetail.weight} kg',
                              color: fromStringToColor(
                                  pokemon?.color ?? "Color(0xFF9E9E9E)")!),
                          const SizedBox(height: 10),
                          const Text(
                            "Sprites",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                FadeInImageCustom(
                                    url:
                                        pokeDetail.sprites?.frontDefault ?? ""),
                                FadeInImageCustom(
                                    url: pokeDetail.sprites?.backDefault ?? ""),
                                FadeInImageCustom(
                                    url: pokeDetail.sprites?.frontShiny ?? ""),
                                FadeInImageCustom(
                                    url: pokeDetail.sprites?.backShiny ?? ""),
                              ],
                            ),
                          ),
                          SectionDetail(
                              label: "Abilities",
                              type: "abilities",
                              data: pokeDetail.abilities!,
                              color: fromStringToColor(
                                  pokemon?.color ?? "Color(0xFF9E9E9E)")!),
                          const SizedBox(height: 10),
                          const Text(
                            "Movements",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              pokeDetail.moves
                                      ?.map((e) => '${e.move?.name}')
                                      .toList()
                                      .join(", ") ??
                                  "",
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Stats",
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 100),
                            child: Table(
                              columnWidths: const <int, TableColumnWidth>{
                                0: FractionColumnWidth(0.75)
                              },
                              children: [
                                ...?pokeDetail.stats
                                    ?.map((e) => TableRow(children: [
                                          Container(
                                              decoration: BoxDecoration(
                                                  color: fromStringToColor(
                                                      pokemon!.color!),
                                                  border: Border.all(
                                                      color: fromStringToColor(
                                                          pokemon!.color!)!),
                                                  borderRadius:
                                                      const BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(100),
                                                    bottomLeft:
                                                        Radius.circular(100),
                                                  )),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              margin: const EdgeInsets.only(
                                                  bottom: 10),
                                              child: Text(e.stat!.name!)),
                                          TableCell(
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10,
                                                        horizontal: 10),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                        color:
                                                            fromStringToColor(
                                                                pokemon!
                                                                    .color!)!),
                                                    borderRadius:
                                                        const BorderRadius.only(
                                                      topRight:
                                                          Radius.circular(100),
                                                      bottomRight:
                                                          Radius.circular(100),
                                                    )),
                                                width: 10,
                                                child: Center(
                                                    child: Text(e.baseStat
                                                        .toString()))),
                                          )
                                        ]))
                                    .toList(),
                              ],
                            ),
                          ),
                        ],
                      )),
                );
              },
            ),
          ),
          Column(children: [
            Stack(
              children: [
                Container(
                  height: 370,
                  margin: const EdgeInsets.only(bottom: 100),
                  decoration: BoxDecoration(
                    color: fromStringToColor(
                        pokemon?.color ?? "Color(0xFF9E9E9E)"),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(1000),
                      bottomRight: Radius.circular(1000),
                    ),
                  ),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 20),
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            '${pokemon?.name}\n#${pokemon?.id}',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ]),
          Positioned(
              top: 120,
              left: 50,
              right: 50,
              child: SizedBox(
                height: 300,
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      left: 20,
                      child: Center(
                        child: Image.asset(
                          "assets/pokebola-blanca.png",
                          width: 250,
                          height: 250,
                          opacity: const AlwaysStoppedAnimation(0.7),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: -50,
                      child: Center(
                        child: FadeInImageCustom(
                          height: 400,
                          width: 250,
                          url: pokemon?.picture ?? "",
                        ),
                      ),
                    ),
                  ],
                ),
              )),
        ]));
  }
}
