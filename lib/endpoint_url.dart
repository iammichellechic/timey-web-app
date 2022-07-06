import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class EndPoint {
  ValueNotifier<GraphQLClient> getClient() {
    ValueNotifier<GraphQLClient> _client = ValueNotifier(GraphQLClient(
      link: HttpLink('https://api.zero8.io/graphql'),
 
      cache: GraphQLCache(store: HiveStore()),
    ));

    return _client;
  }
}
