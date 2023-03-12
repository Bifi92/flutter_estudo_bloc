import 'package:estudo_bloc/screens/home.dart';
import 'package:estudo_bloc/screens/cadastro_home.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> rotas = {
  '/': (context) => const HomeScreen(),
  '/cadastro': (context) => const CadastroHomeScreen(),
};
