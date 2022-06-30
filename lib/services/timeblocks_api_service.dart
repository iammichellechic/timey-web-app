import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timey_web/data/providers/timeblock.dart';

import '../schemas/endpoint_url.dart';
import '../schemas/timeblocks_schema.dart';

class TimeBlocksApi{
  String _response = '';
  String get getResponse => _response;
  List<TimeBlock> timeblocksList = [];
  final EndPoint _point = EndPoint();


  Future<dynamic> getTimeblocks() async {
    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.query(QueryOptions(
        document: gql(TimeBlocksSchema.getTimeblocks),
        fetchPolicy: FetchPolicy.networkOnly));

    if (result.hasException) {
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = "No connectivity found";
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
    } else {
      timeblocksList = (result.data!['timeblocks'] as List<dynamic>)
          .map((tb) => TimeBlock.fromJson(tb))
          .toList();
      return timeblocksList;
    }
  }

}
