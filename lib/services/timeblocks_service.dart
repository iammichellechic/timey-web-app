import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import '../data/providers/schemas/endpoint_url.dart';
import '../data/providers/schemas/get_timeblocks_schema.dart';

class TimeBlocksApi {
  bool _status = false;
  String _response = '';
  dynamic _list = [];

  bool get getStatus => _status;
  String get getResponse => _response;
  List<dynamic> get getList => _list;

  final EndPoint _point = EndPoint();

  void getTimeblocks(bool isLocal) async {
    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.query(QueryOptions(
        document: gql(GetTimeBlocks.query),
        fetchPolicy: FetchPolicy.cacheAndNetwork));

    if (result.hasException) {
      
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = "No connectivity found";
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
    } else {
  
      _status = false;
      _list = result.data;
    }
  }

  dynamic getResponseData() {
    if (_list.isNotEmpty) {
      final data = _list;

      return data['timeblocks'] ?? {};
    } else {
      return {};
    }
  }

  void clear() {
    _response = '';
  }
}
