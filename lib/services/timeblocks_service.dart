
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timey_web/data/providers/timeblock.dart';

import '../data/providers/schemas/endpoint_url.dart';
import '../data/providers/schemas/get_timeblocks_schema.dart';

class TimeBlocksApi {
  String _response = '';

  String get getResponse => _response;

  final EndPoint _point = EndPoint();

  Future<dynamic> getTimeblocks() async {
    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.query(QueryOptions(
        document: gql(GetTimeBlocks.query),
        fetchPolicy: FetchPolicy.cacheAndNetwork));

    if (result.hasException) {
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = "No connectivity found";
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
    } else {

      var episodes = (result.data!['timeblocks'] as List<dynamic>)
          .map((episode) => TimeBlock.fromJson(episode))
          .toList();
      return episodes;
    }
  }

  void clear() {
    _response = '';
  }
}
