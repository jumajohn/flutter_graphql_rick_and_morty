import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './pages/home.dart';
import './pages/character_details_page.dart';
import './constant/theme.dart';
import './data_bloc/data_bloc.dart';
import './data/remote_repository.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>AllCharacterBloc(repo: CharacterRepository()),
      child: MaterialApp(
        title: 'rick and morty',
        theme: CustomTheme.mainTheme,
        initialRoute: "/home",
       routes: {
         "/home":(context) => const HomePage(),
         CharacterDetailsPage.RouteName:(context) => const CharacterDetailsPage(),
       },
      ),
    );
  }
}