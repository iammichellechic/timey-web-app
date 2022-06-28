import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timey_web/data/providers/timeblock.dart';

import '../data/providers/schemas/endpoint_url.dart';
import '../data/providers/schemas/timeblocks_schema.dart';

class TimeBlocksApi {
  String _response = '';
  String get getResponse => _response;
  List<TimeBlock> timeblocksList = [];
  final EndPoint _point = EndPoint();


  Future<dynamic> getTimeblocks() async {
    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.query(QueryOptions(
        document: gql(TimeBlocksSchema.getTimeblocks),
        fetchPolicy: FetchPolicy.cacheAndNetwork));

    if (result.hasException) {
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = "No connectivity found";
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
    } else {
      timeblocksList = (result.data!['timeblocks'] as List<dynamic>)
          .map((tb) => TimeBlock.fromJson(
                tb
              ))
          .toList();
      return timeblocksList;
    }
  }

  void addTask({int userId = 1, DateTime? date, int? reportedMinutes}) async {
    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.mutate(MutationOptions(
        document: gql(TimeBlocksSchema.createTimeblocks),
        variables: {
          'userId': userId,
          'startTime': date,
          'reportedMinutes': reportedMinutes
        }));

    if (result.hasException) {
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = "No connectivity found";
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
    } else {
      print(result.data);
      _response = "Timeblock was successfully added";
    }
  }

  void clear() {
    _response = '';
  }
}
