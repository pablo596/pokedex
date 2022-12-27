import 'package:flutter/material.dart';
import 'package:pokedex/pages/PokemonScreen.dart';
import '../pages/HomePage.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  "home": (_) => const HomePage(),
  "pokemon": (_) => const PokemonPage()
};
