// ignore_for_file: deprecated_member_use

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data_bloc/data_bloc.dart';

import './listtile_widget.dart';

class CharacterPage extends StatefulWidget {
  const CharacterPage({Key? key}) : super(key: key);

  @override
  State<CharacterPage> createState() => _CharacterPageState();
}

class _CharacterPageState extends State<CharacterPage> {
  final ScrollController _scrollcontroller = ScrollController();
  late int totalNumberData;
  bool canFetch = false;
  bool canRequest = false;

  @override
  void initState() {
    BlocProvider.of<AllCharacterBloc>(context).add(AllCharactersEvent());

    _scrollcontroller.addListener(() {
      var triggerFetchMoreSize = _scrollcontroller.position.maxScrollExtent;

      if (canFetch && canRequest) {
        if (triggerFetchMoreSize - _scrollcontroller.position.pixels <= 200.0) {
          BlocProvider.of<AllCharacterBloc>(context).add(AllCharactersEvent());

          canFetch = false;
          canRequest = false;
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30.0),
              topLeft: Radius.circular(30.0),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 6,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: BlocBuilder<AllCharacterBloc, AllCharactersState>(
            builder: (context, state) {
              if (state.status == Status.initial) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state.status == Status.success ||
                  state.status == Status.error) {
                if (state.status != Status.error) {
                  canRequest = true;
                }

                if (state.characters == []) {
                  ReloadWidget();
                } else {
                  return ListView.builder(
                    controller: _scrollcontroller,
                    itemCount: state.characters.length + 1,
                    itemBuilder: (context, index) {
                      totalNumberData = index;

                      if (index >= state.characters.length) {
                        canFetch = true;
                      }

                      return index >= state.characters.length
                          ? state.status == Status.error
                              ? ReloadWidget()
                              : Container(
                                  padding: const EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  child: const Center(
                                      child: SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator())))
                          : List_Widget(datalist: state.characters[index]);
                    },
                  );
                }
              }
              return const Center(child: Text("juma"));
            },
          )),
    );
  }

  @override
  void dispose() {
    _scrollcontroller.dispose();
    super.dispose();
  }
}

class ReloadWidget extends StatefulWidget {

  bool isLoading = false;

  @override
  State<ReloadWidget> createState() => _ReloadWidgetState();
}

class _ReloadWidgetState extends State<ReloadWidget> {
  Timer? time;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Column(children: [
         const Text(
          "something went wrong or no internet connecton",
            softWrap: true,
          ),
          Container(
            child: widget.isLoading
                ? const CircularProgressIndicator(
                    color: Colors.orange,
                  )
                : FlatButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      setState(() {
                        time?.cancel();
                        print("why");
                        widget.isLoading = true;
                      });

                      BlocProvider.of<AllCharacterBloc>(context)
                          .add(AllCharactersEvent());

                      time = Timer(const Duration(seconds: 10), () {
                        setState(() {
                          widget.isLoading = false;
                        });
                      });
                    },
                    child: const Text("Reload"),
                  ),
          )
        ]),
      ),
    );
  }
}
