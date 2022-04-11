import 'package:flutter/material.dart';

class CharacterEpisodes {
  final String id;
  final String episode;
  final String name;
  final String airDate;
  final String created;

  CharacterEpisodes({
    required this.id,
    required this.episode,
    required this.name,
    required this.airDate,
    required this.created,
  });
}

class CharacterDetails {
  final String id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String origin;
  final String image;
  final String created;
  final String locationId;
  final String locationName;
  final String locationType;
  final String locationDimension;
  final String locationCreated;
  final List<CharacterEpisodes> episodes;

  CharacterDetails({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.image,
    required this.created,
    required this.locationId,
    required this.locationName,
    required this.locationType,
    required this.locationDimension,
    required this.locationCreated,
    required this.episodes,
  });
}
