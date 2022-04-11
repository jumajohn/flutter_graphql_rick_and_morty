import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import '../data/remote_repository.dart';
import '../data/local_repository.dart';
import 'package:equatable/equatable.dart';
import '../data/model.dart';
part 'data_event.dart';
part 'data_state.dart';

class AllCharacterBloc extends Bloc<AllCharactersEvent, AllCharactersState> {
  final CharacterRepository repo;
  AllCharacterBloc({
    required this.repo,
  }) : super(const AllCharactersState()) {
    on<AllCharactersEvent>(maptada);
  }

  int pageN = 1;

  int totalPageN = 2;

  bool shouldInit = false;

  void maptada(
      AllCharactersEvent event, Emitter<AllCharactersState> emit) async {
    try {
      if (state.characters.isEmpty || shouldInit) {
        shouldInit = false;
        emit(const AllCharactersState(status: Status.initial));
      }

      if (state.status == Status.initial) {
        final queryresult = await repo.fetchCharacters(pageN);

        if (queryresult.hasException) {
          shouldInit = true;
          final List list = await LocalData.getData();

          final data = jsonMap(list);

          print(queryresult.exception.toString());

          emit(AllCharactersState(
              characters: data,
              status: Status.error));

          return;
        }

        final List data = queryresult.data!['characters']['results'];

        totalPageN = queryresult.data!['characters']['info']['pages'];

        List<CharacterDetails> modelData = jsonMap(data);

        emit(AllCharactersState(status: Status.success, characters: modelData));
        LocalData.saveData(data);

        return;
      }

      if (pageN < totalPageN) {
        pageN = pageN + 1;
        print(pageN);
        final queryresult = await repo.fetchCharacters(pageN);

        if (queryresult.hasException) {
          if (pageN > 1) {
            pageN = pageN - 1;
          }
          print("yah its exception");
          emit(AllCharactersState(
              characters: state.characters,
              status: Status.error));
          return;
        }

        final List data = queryresult.data!['characters']['results'];

        List<CharacterDetails> modelData = jsonMap(data);

        emit(AllCharactersState(
            status: Status.success,
            characters: List.of(state.characters)..addAll(modelData)));
      }
    } catch (e) {
      print(e);

      if (state.status == Status.initial) {
        shouldInit = true;
        final List list = await LocalData.getData();

        if (list == null || list == []) {
          emit(AllCharactersState(
              characters: state.characters,
              status: Status.error));
          return;
        }
        final data = jsonMap(list);
        emit(AllCharactersState(
            characters: data,
            status: Status.error));
      } else {
        emit(AllCharactersState(
            characters: state.characters,
            status: Status.error));
      }
    }
  }

  List<CharacterDetails> jsonMap(List apiData) {
    List<CharacterDetails> data = [];

    if (apiData != null || apiData != []) {
      apiData.forEach((element) {
        List<CharacterEpisodes> episodeData = [];

        final List episodslist = element['episode'];

        if (apiData != null || apiData != []) {
          episodslist.forEach((e) {
            episodeData.add(CharacterEpisodes(
                id: e['id'] ?? "N/A",
                episode: e['episode'] ?? "N/A",
                name: e['name'],
                airDate: e['air_date'] ?? "N/A",
                created: e['created'] ?? "N/A"));
          });
        }

        data.add(CharacterDetails(
            id: element['id'] ?? "N/A",
            name: element['name'] ?? "N/A",
            status: element['status'] ?? "N/A",
            species: element['species'] ?? "N/A",
            type: element['type'] ?? "N/A",
            gender: element['gender'] ?? "N/A",
            origin: element['origin']['name'] ?? "N/A",
            image: element['image'] ?? "N/A",
            created: element['created'] ?? "N/A",
            locationId: element['location']['id'] ?? "N/A",
            locationName: element['location']['name'] ?? "N/A",
            locationType: element['location']['type'] ?? "N/A",
            locationDimension: element['location']['dimension'] ?? "N/A",
            locationCreated: element['location']['created'] ?? "N/A",
            episodes: episodeData));
      });
    }
    return data;
  }
}
