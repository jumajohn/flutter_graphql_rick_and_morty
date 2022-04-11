import 'dart:io';

import 'package:graphql_flutter/graphql_flutter.dart';
import './queries.dart' as queries;

class CharacterRepository {
  static final HttpLink _httpLink = HttpLink(
    'https://rickandmortyapi.com/graphql',
  );

  static final Link _link = _httpLink;

  static final GraphQLClient _client = GraphQLClient(
    cache: GraphQLCache(store: InMemoryStore()),
    link: _link,
  );

  Future<QueryResult> fetchCharacters(int pageNumber) async {
    final WatchQueryOptions _options = WatchQueryOptions(
      document: gql(queries.readCharactersRepositories),
    
      pollInterval: const Duration(seconds: 4),
      variables: {
        'page': pageNumber,
      },
      fetchResults: true,
      
     
    );


    return _client.query(_options);
  }
}
