import 'package:flutter/material.dart';
import '../constant/theme.dart';
import '../widgets/header_widget.dart';
import '../widgets/characters_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
static const RouteName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
             Header(),
            SizedBox(height: 40.0),
            CharacterPage()
          ],
        ),
      ),
    );
  }
}
