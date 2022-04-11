import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data_bloc/data_bloc.dart';

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: const [
            Text(
              'Rick And Morty Characters',
              softWrap: true,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25.0,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Explore your favorite character in the show ',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const CircleAvatar(
            backgroundImage: AssetImage("assets/images/images2.jpeg"),
            backgroundColor: Colors.blue,
            radius: 50,
          ),
        
      ],
    );
  }
}
