import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:timey_web/schemas/timeblocks_schema.dart';

import '../../endpoint_url.dart';

//No longer needed
class DeleteTimeBlockProvider extends ChangeNotifier {
  bool _status = false;

  String _response = '';

  bool get getStatus => _status;

  String get getResponse => _response;

  final EndPoint _point = EndPoint();

  //final _api = locator<TimeBlocksApi>();

  Future<void> deleteTimeBlock({
    String? timeBlockId,
  }) async {
    _status = true;
    _response = "Please wait...";
    notifyListeners();

    ValueNotifier<GraphQLClient> _client = _point.getClient();

    QueryResult result = await _client.value.mutate(MutationOptions(
        document: gql(TimeBlocksSchema.deleteTimeBlock),
        variables: {
          'timeBlockGuid': timeBlockId,
        }));

    if (result.hasException) {
      print(result.exception);
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = "No connectivity found";
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      print(result.data);
      _status = false;
      _response = "Task was successfully Deleted";

      notifyListeners();
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
