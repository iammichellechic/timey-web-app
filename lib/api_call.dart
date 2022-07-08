import 'package:flutter/material.dart';
import 'package:gql/language.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timey_web/endpoint_url.dart';

abstract class ISafeApiCall {
  ObservableQuery<Object?> safeWatchQuery(String document);
  Future<QueryResult> safeMutation({
    required String documentMutation,
    required String documentQuery,
    required Map<String, dynamic> variables,
    required String oldData,
    required String newData,
  });
}

class SafeApiCall implements ISafeApiCall {
  SafeApiCall();

  final EndPoint _point = EndPoint();

  @override
  ObservableQuery<Object?> safeWatchQuery(String document) {
    ValueNotifier<GraphQLClient> _client = _point.getClient();
    final observableQuery = _client.value.watchQuery(
      WatchQueryOptions(
          document: gql(document),
          fetchResults: true,
          fetchPolicy: FetchPolicy.cacheAndNetwork),
    );

    return observableQuery;
  }

  @override
  Future<QueryResult> safeMutation({
    required String documentMutation,

    /// Query to read query for caching
    required String documentQuery,
    required Map<String, dynamic> variables,
    required String oldData,
    required String newData,
  }) async {
    ValueNotifier<GraphQLClient> _client = _point.getClient();

    final result = await _client.value.mutate(
      MutationOptions(
        document: gql(documentMutation),
        variables: variables,
        fetchPolicy: FetchPolicy.cacheAndNetwork,
        optimisticResult: PartialDataCachePolicy.accept,

        // ERROR://Does not update query after adding/deleting :(

        update: (cache, result) {
          if (result != null && result.hasException) {
            return;
          }

          final queryRequest = Operation(
            document: parseString(documentQuery),
          ).asRequest();

          final data = _client.value.readQuery(queryRequest);

          cache.writeQuery(queryRequest, data: {
            oldData: [
              ...data?[oldData],
              result?.data?[newData],
            ],
          });
        },
      ),
    );

    if (result.hasException) {
      // await _dialogService.showDialog(
      //     title: 'Something went wrong', description: result.exception.toString());

      print(' Exception ${result.exception}');
      throw Exception();
    }

    return result;
  }
}
