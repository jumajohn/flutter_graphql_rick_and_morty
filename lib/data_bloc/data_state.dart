part of 'data_bloc.dart';

enum Status { initial, success, error, loading }

class AllCharactersState extends Equatable {
  const AllCharactersState(
      {this.reachMaximu=false,this.status = Status.initial, this.characters = const []});

  final List<CharacterDetails> characters;
  final bool reachMaximu;
  final Status status;

  

  @override
  List<Object> get props => [characters,reachMaximu,status];
}
