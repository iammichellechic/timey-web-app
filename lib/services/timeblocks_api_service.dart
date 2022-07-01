import 'dart:async';

import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timey_web/model/timeblock.dart';

import '../endpoint_url.dart';
import '../schemas/timeblocks_schema.dart';

class TimeBlocksApi {
  String _response = '';
  String get getResponse => _response;
  List<TimeBlock> timeblocksList = [];
  final EndPoint _point = EndPoint();

  //TODO: Use streamcontroller/ observablequery to listen to data changes

  //final StreamController<List<TimeBlock>> _tbController =
  //    StreamController<List<TimeBlock>>.broadcast();

  // Stream getTimeblocks() async* {
  //   ValueNotifier<GraphQLClient> _client = _point.getClient();

  //   QueryResult result =  await _client.value.query(QueryOptions(
  //       document: gql(TimeBlocksSchema.getTimeblocks),
  //       fetchPolicy: FetchPolicy.cacheAndNetwork));

  //   if (result.hasException) {
  //     if (result.exception!.graphqlErrors.isEmpty) {
  //       _response = "No connectivity found";
  //     } else {
  //       _response = result.exception!.graphqlErrors[0].message.toString();
  //     }
  //   } else {
  //     var timeblocksList = (result.data!['timeblocks'] as List <dynamic>)
  //         .map((tb) => TimeBlock.fromJson(tb))
  //         .toList();
  //     //yield timeblocksList;
  //     _tbController.add(timeblocksList);
  //   }
  //   yield _tbController.stream;
  // }

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
          .map((tb) => TimeBlock.fromJson(tb))
          .toList();
      return timeblocksList;
    }
  }

  // void getTimeblocks()  {
  //   ValueNotifier<GraphQLClient> _client = _point.getClient();

  //   final observableQuery = _client.value.watchQuery(WatchQueryOptions(
  //       fetchResults: true,
  //       document: gql(TimeBlocksSchema.getTimeblocks),
  //       fetchPolicy: FetchPolicy.cacheAndNetwork));

  //   observableQuery.stream.listen((QueryResult result) {
  //     if (result.hasException) {
  //       if (result.exception!.graphqlErrors.isEmpty) {
  //         _response = "No connectivity found";
  //       } else {
  //         _response = result.exception!.graphqlErrors[0].message.toString();
  //       }
  //     } else {
  //       timeblocksList = (result.data!['timeblocks'] )
  //           .map((tb) => TimeBlock.fromJson(tb))
  //           .toList();
  //      // return timeblocksList;
  //     }
  //   });
  //   observableQuery.close();
  // }
}
