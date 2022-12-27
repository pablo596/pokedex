import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:pokedex/bloc/pokemons/pokemons_bloc.dart';
import 'package:pokedex/models/pokemons_response.dart';
import 'package:pokedex/models/simple_pokemon.dart';
import 'package:pokedex/service/pokedex_service.dart';
import 'package:pokedex/widgets/home_list_pokemons_widget.dart';

import 'package:provider/provider.dart';

import '../helpers/helpers.dart';
import 'SearchPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PokedexService? pokedexService;
  PokemonsBloc? pokemonsBloc;
  int offsetLimit = 0;
  Color? bgColor;
  PaletteGenerator? paletteGenerator;
  int _currentTab = 0;

  void _selectTab(int index) {
    setState(() => _currentTab = index);
  }

  @override
  void initState() {
    super.initState();
    pokedexService = Provider.of<PokedexService>(context, listen: false);
    pokemonsBloc = BlocProvider.of<PokemonsBloc>(context, listen: false);
    loadPokemons(0);
    pokemonsBloc?.add(OnLoadMoreInitialList(true));
  }

  Future<void> loadPokemons(int offSet) async {
    List<Result>? pokemons = await pokedexService?.getPokemons(offSet, 40);
    mapPokemonList(pokemons);
  }

  void mapPokemonList(List<Result>? pokemons) async {
    List<SimplePokemon> newListPokemons = await makePokemonsList(pokemons);
    pokemonsBloc!.add(AddPokemonsToList(newListPokemons));
    pokemonsBloc!.add(OnLoadMoreDataList(false));
    pokemonsBloc!.add(OnLoadMoreInitialList(false));
  }

  Widget? getBody() {
    switch (_currentTab) {
      case 0:
        return HomeListPokemons(
          loadPokemons: (int value) {
            loadPokemons(value);
          },
        );
      case 1:
        return const SearchPage();
    }
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: getBody(),
      appBar: AppBar(
        backgroundColor: _currentTab == 0 ? Colors.red : Colors.white,
        elevation: 0,
        toolbarHeight: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: _currentTab == 0 ? Colors.red : Colors.white,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(
              horizontal: size.width * .05, vertical: size.height * .01),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.red,
              boxShadow: const [
                BoxShadow(
                  offset: Offset(3, 3),
                  spreadRadius: -3,
                  blurRadius: 5,
                  color: Color.fromRGBO(0, 0, 0, 0.5),
                )
              ]),
          child: BottomNavigationBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            type: BottomNavigationBarType.fixed,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.catching_pokemon),
                label: 'Pokemons',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
            currentIndex: _currentTab,
            selectedItemColor: Colors.white,
            onTap: _selectTab,
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      extendBody: true,
    );
  }
}
