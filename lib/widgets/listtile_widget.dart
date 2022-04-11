import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rick_mont/widgets/characters_widget.dart';
import 'package:sqflite/utils/utils.dart';
import '../pages/character_details_page.dart';
import '../constant/theme.dart';
import '../data/model.dart';

// ignore: camel_case_types
class List_Widget extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const List_Widget({required this.datalist});

  final CharacterDetails datalist;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(CharacterDetailsPage.RouteName,arguments: {"data":datalist});
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                color: CustomColor.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  width: 1,
                  color: Theme.of(context).primaryColor,
                )),
            margin: const EdgeInsets.only(left: 70),
            child: ListTile(
              title: Text(datalist.name,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5),
              subtitle: Text(
                datalist.locationName,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Container(
                width: 100,
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Status:"),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: datalist.status == "Alive"
                                  ? CustomColor.alive
                                  : datalist.status == "Dead"
                                      ? Colors.red
                                      : Theme.of(context).primaryColor,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Container(
                              width: 45,
                              child: Text(datalist.status,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true),
                            )
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward_ios)
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 10,
            child: Hero(
              tag: datalist.id,
              child: CircleAvatar(
                backgroundImage:  NetworkImage(datalist.image),
                backgroundColor: Theme.of(context).primaryColor,
                radius: 35,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
