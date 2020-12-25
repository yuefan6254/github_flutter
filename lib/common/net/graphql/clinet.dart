import 'dart:io';

import 'package:github_flutter/common/net/graphql/repositories.dart';
import 'package:github_flutter/common/net/graphql/users.dart';
import 'package:graphql/client.dart';

/**
 * graphql 请求
 */

GraphQLClient _client(token) {
  final HttpLink _httpLink = HttpLink(uri: 'https://api.github.com/graphql');

  final AuthLink _authLink = AuthLink(getToken: () => '$token');

  final Link _link = _authLink.concat(_httpLink);

  return GraphQLClient(
    cache: OptimisticCache(dataIdFromObject: typenameDataIdFromObject),
    link: _link,
  );
}

GraphQLClient _innerClient;

initClient(token) {
  _innerClient ??= _client(token);
}

releaseClient() {
  _innerClient = null;
}

Future<QueryResult> getRepository(String owner, String name) async {
  final QueryOptions _options = QueryOptions(
    documentNode: gql(readRepository),
    variables: <String, dynamic>{
      'owner': owner,
      'name': name,
    },
    fetchPolicy: FetchPolicy.noCache,
  );

  return await _innerClient.query(_options);
}

Future getTrendUser(String location, {String cursor}) async {
  var variables = cursor == null
      ? <String, dynamic>{
          'location': "location:${location} sort:followers",
        }
      : <String, dynamic>{
          'location': "location:${location} sort:followers",
          'after': cursor,
        };

  final QueryOptions _options = QueryOptions(
    documentNode: gql(cursor == null ? readTreendUser : readTrendUserByCursor),
    variables: variables,
    fetchPolicy: FetchPolicy.noCache,
  );

  return _innerClient.query(_options);
}
