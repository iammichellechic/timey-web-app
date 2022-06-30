import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timey_web/model/timeblock.dart';
import 'package:timey_web/schemas/timeblocks_schema.dart';

import '../../schemas/endpoint_url.dart';
import '../../viewmodels/timeblocks_viewmodels.dart';

class AddTimeBlockProvider extends ChangeNotifier {
  bool _status = false;
  String _response = '';
  bool get getStatus => _status;
  String get getResponse => _response;
  final EndPoint _point = EndPoint();

  Future<void> addTimeBlock({TimeBlock? timeblock}) async {
    _status = true;
    _response = "Please wait...";
    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.mutate(MutationOptions(
        document: gql(TimeBlocksSchema.createTimeblocks),
        variables: {
          'userId': timeblock!.userId == null ? null : timeblock.userId,
          'startTime': timeblock.startDate.toIso8601String(),
          'reportedMinutes': timeblock.hours
        }));

    if (result.hasException) {
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = result.exception!.graphqlErrors[0].message.toString();
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      print(result.data);
      _status = false;
      _response = "Task was successfully added";
      
      await TimeBlocksViewModel().getTimeblocksList(); //does not work
      //TimeBlock.fromJson(jsonDecode(result.data!['timeblocks']));
      // notifyListeners();
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }


}
