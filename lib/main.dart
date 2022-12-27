import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokedex/bloc/search/search_bloc.dart';
import 'package:pokedex/bloc/pokemons/pokemons_bloc.dart';
import 'package:pokedex/routes/pokedex_routes.dart';
import 'package:pokedex/service/pokedex_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(MultiBlocProvider(providers: [
      BlocProvider(create: (_) => PokemonsBloc()),
      BlocProvider(create: (_) => SearchBloc()),
    ], child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PokedexService()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.red,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Pokedex',
        initialRoute: "home",
        routes: appRoutes,
      ),
    );
  }
}
