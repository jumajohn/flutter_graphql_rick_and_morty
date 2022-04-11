// ignore_for_file: prefer_const_constructors
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rick_mont/constant/theme.dart';
import '../data/model.dart';
import 'package:cached_network_image/cached_network_image.dart';

// ignore: camel_case_types
class CharacterDetailsPage extends StatefulWidget {
  const CharacterDetailsPage({Key? key}) : super(key: key);
  // ignore: constant_identifier_names
  static const RouteName = "/character_details";

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  bool isInit = true;
  late CharacterDetails datalist;

  @override
  void didChangeDependencies() {
    if (isInit) {
      final args =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

      // ignore: unnecessary_null_comparison
      if (args == null) {
        return;
      }
      datalist = args['data'];
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            expandedHeight: 320.0,
            floating: false,
            pinned: true,
            snap: false,
            elevation: 50,
            backgroundColor: Theme.of(context).primaryColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: datalist.id,
                child: CachedNetworkImage(
                  imageUrl: datalist.image,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              title: Text(datalist.name,
                  style: TextStyle(
                    backgroundColor: Theme.of(context).primaryColor,
                    color: Colors.white,
                    fontSize: 16.0,
                  )),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
                  _buildList(context, datalist.episodes))),
        ],
      ),
    );
  }

  List<Widget> _buildList(
      BuildContext context, List<CharacterEpisodes> episodes) {
    List<Widget> listItems = [];

    listItems.add(details(context));
    listItems.add(Episodes(episodeslistdata: episodes));

    return listItems;
  }

  Widget details(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Text(
                  "Details",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline5,
                )),
            Divider(),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.all(10),
              children: [
                Row(
                  children: [
                    Text(
                      "Name:",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(datalist.name),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Status:",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      width: 10,
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
                        SizedBox(
                          width: 5,
                        ),
                        Text(datalist.status)
                      ],
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Gender:",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(datalist.gender),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "species:",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(datalist.species),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "type:",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(datalist.type),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "origin:",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(datalist.origin),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Location:",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(datalist.locationName),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class Episodes extends StatelessWidget {
  const Episodes({Key? key, required this.episodeslistdata}) : super(key: key);
  final List<CharacterEpisodes> episodeslistdata;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
                padding: EdgeInsets.all(10),
                width: double.infinity,
                child: Text(
                  "Episodes",
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline5,
                )),
            Divider(),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: episodeslistdata.length,
              itemBuilder: (context, index) {
                return EpisodeTile(episodesdata: episodeslistdata[index]);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class EpisodeTile extends StatefulWidget {
  const EpisodeTile({Key? key, required this.episodesdata}) : super(key: key);
  final CharacterEpisodes episodesdata;
  @override
  State<EpisodeTile> createState() => _EpisodeTileState();
}

class _EpisodeTileState extends State<EpisodeTile> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      ListTile(
        title: Text(widget.episodesdata.episode),
        trailing: IconButton(
          icon: Icon(
            expanded ? Icons.expand_more : Icons.expand_less,
          ),
          onPressed: () {
            setState(() {
              expanded = !expanded;
            });
          },
        ),
      ),
      if (expanded)
        Container(
          padding: EdgeInsets.only(left: 30),
          height: 70,
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            children: [
              Row(
                children: [
                  Text(
                    "Name:",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    widget.episodesdata.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    "air_date:",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget.episodesdata.airDate,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
              Row(
                children: [
                  Text(
                    "created:",
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(widget.episodesdata.created,
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ],
          ),
        )
    ]);
  }
}
